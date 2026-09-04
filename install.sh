#!/usr/bin/env bash
set -euo pipefail

VERSION="1.1.1"
APP_HOME="${DOWNIX_HOME:-$HOME/.local/share/downix}"
BIN_DIR="${HOME}/.local/bin"
VENV_DIR="$APP_HOME/venv"
DENO_DIR="$APP_HOME/deno"
PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

RESET='\033[0m'; GREEN='\033[38;5;46m'; CYAN='\033[38;5;51m'; YELLOW='\033[38;5;226m'; RED='\033[38;5;196m'
ok(){ printf '%b\n' "${GREEN}✓${RESET} $*"; }
info(){ printf '%b\n' "${CYAN}→${RESET} $*"; }
warn(){ printf '%b\n' "${YELLOW}!${RESET} $*"; }
fail(){ printf '%b\n' "${RED}✗${RESET} $*" >&2; exit 1; }
have(){ command -v "$1" >/dev/null 2>&1; }
is_termux(){ [[ -n "${TERMUX_VERSION:-}" ]] || [[ "${PREFIX:-}" == *"com.termux"* ]]; }

run_root() {
  if [[ ${EUID:-$(id -u)} -eq 0 ]]; then "$@";
  elif have sudo; then sudo "$@";
  else fail "Se necesitan privilegios para instalar paquetes del sistema y sudo no está disponible.";
  fi
}

install_system_deps() {
  if is_termux; then
    info "Entorno detectado: Termux"
    pkg install -y python ffmpeg curl ca-certificates >/dev/null
    return
  fi

  local need_ffmpeg=0 need_python=0 need_curl=0 need_xdg=0
  have ffmpeg || need_ffmpeg=1
  have python3 || need_python=1
  have curl || need_curl=1
  have xdg-open || need_xdg=1

  if (( need_ffmpeg==0 && need_python==0 && need_curl==0 )); then
    ok "Dependencias base del sistema presentes."
    return
  fi

  if have apt-get; then
    info "Gestor detectado: APT"
    local pkgs=(ca-certificates)
    ((need_ffmpeg)) && pkgs+=(ffmpeg)
    ((need_python)) && pkgs+=(python3 python3-venv)
    if have python3 && ! python3 -m venv --help >/dev/null 2>&1; then pkgs+=(python3-venv); fi
    ((need_curl)) && pkgs+=(curl)
    ((need_xdg)) && pkgs+=(xdg-utils)
    # No hacemos apt update automáticamente: repositorios externos rotos no deben bloquear Downix.
    if ! run_root apt-get install -y "${pkgs[@]}"; then
      warn "APT no pudo instalar directamente. Intentando actualizar índices una vez..."
      run_root apt-get update || warn "apt update reportó errores; continuando con índices existentes."
      run_root apt-get install -y "${pkgs[@]}"
    fi
  elif have dnf; then
    info "Gestor detectado: DNF"
    run_root dnf install -y python3 ffmpeg curl ca-certificates xdg-utils
  elif have pacman; then
    info "Gestor detectado: pacman"
    run_root pacman -S --needed --noconfirm python ffmpeg curl ca-certificates xdg-utils
  elif have zypper; then
    info "Gestor detectado: zypper"
    run_root zypper --non-interactive install python3 ffmpeg curl ca-certificates xdg-utils
  elif have apk; then
    info "Gestor detectado: apk"
    run_root apk add python3 py3-pip ffmpeg curl ca-certificates xdg-utils
  else
    fail "No reconozco el gestor de paquetes. Instala Python 3, FFmpeg y curl y vuelve a ejecutar install.sh."
  fi
}

ensure_storage_termux() {
  is_termux || return 0
  if [[ ! -d "$HOME/storage/shared" ]]; then
    if have termux-setup-storage; then
      warn "Android pedirá permiso de almacenamiento. Acéptalo."
      termux-setup-storage || true
      sleep 1
    fi
  fi
  mkdir -p "$HOME/storage/shared/Download/Downix/Music" "$HOME/storage/shared/Download/Downix/Video" 2>/dev/null || true
}

ensure_venv() {
  mkdir -p "$APP_HOME"
  local py=""
  if have python3; then py=python3; elif have python; then py=python; else fail "Python no está disponible."; fi

  if ! "$py" - <<'PY'
import sys
raise SystemExit(0 if sys.version_info >= (3,10) else 1)
PY
  then
    fail "Downix requiere Python 3.10 o superior para el yt-dlp actual."
  fi

  if [[ ! -x "$VENV_DIR/bin/python" ]]; then
    info "Creando runtime aislado de Downix..."
    "$py" -m venv "$VENV_DIR" || {
      if have apt-get && ! is_termux; then
        run_root apt-get install -y python3-venv
        "$py" -m venv "$VENV_DIR"
      else
        fail "No se pudo crear el entorno Python aislado."
      fi
    }
  fi

  info "Instalando/actualizando yt-dlp + yt-dlp-ejs..."
  "$VENV_DIR/bin/python" -m pip install --disable-pip-version-check -U pip >/dev/null
  "$VENV_DIR/bin/python" -m pip install --disable-pip-version-check -U "yt-dlp[default]"
  ok "yt-dlp $($VENV_DIR/bin/yt-dlp --version)"
}

install_deno() {
  mkdir -p "$DENO_DIR"
  if [[ -x "$DENO_DIR/bin/deno" ]]; then
    info "Actualizando Deno..."
    "$DENO_DIR/bin/deno" upgrade >/dev/null 2>&1 || true
  else
    info "Instalando Deno (runtime JavaScript recomendado por yt-dlp)..."
    local tmp
    tmp=$(mktemp)
    curl -fsSL https://deno.land/install.sh -o "$tmp"
    DENO_INSTALL="$DENO_DIR" sh "$tmp" >/dev/null
    rm -f "$tmp"
  fi
  [[ -x "$DENO_DIR/bin/deno" ]] || fail "No se pudo instalar Deno."
  ok "$($DENO_DIR/bin/deno --version | head -n1)"
}

install_runtime_updater() {
  cat > "$APP_HOME/update-runtime" <<'UPDATER'
#!/usr/bin/env bash
set -euo pipefail
APP_HOME="${DOWNIX_HOME:-$HOME/.local/share/downix}"
VENV_DIR="$APP_HOME/venv"
DENO_BIN="$APP_HOME/deno/bin/deno"
[[ -x "$VENV_DIR/bin/python" ]] || { echo "Downix runtime missing" >&2; exit 1; }
"$VENV_DIR/bin/python" -m pip install --disable-pip-version-check -U "yt-dlp[default]"
if [[ -x "$DENO_BIN" ]]; then "$DENO_BIN" upgrade || true; fi
printf 'yt-dlp: %s\n' "$("$VENV_DIR/bin/yt-dlp" --version)"
if [[ -x "$DENO_BIN" ]]; then "$DENO_BIN" --version | head -n1; fi
UPDATER
  chmod +x "$APP_HOME/update-runtime"
}

install_command() {
  mkdir -p "$BIN_DIR" "$APP_HOME"
  cp "$PROJECT_DIR/down" "$APP_HOME/down"
  chmod +x "$APP_HOME/down"
  ln -sfn "$APP_HOME/down" "$BIN_DIR/down"
  ln -sfn "$APP_HOME/down" "$BIN_DIR/downix"
  cp "$PROJECT_DIR/uninstall.sh" "$APP_HOME/uninstall.sh"
  chmod +x "$APP_HOME/uninstall.sh"
  ln -sfn "$APP_HOME/uninstall.sh" "$BIN_DIR/downix-uninstall"

  case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *)
      warn "$BIN_DIR no está actualmente en PATH."
      local rc="$HOME/.profile"
      if [[ -n "${ZSH_VERSION:-}" || "${SHELL:-}" == *zsh ]]; then rc="$HOME/.zshrc"; elif [[ "${SHELL:-}" == *bash ]]; then rc="$HOME/.bashrc"; fi
      if ! grep -Fq 'HOME/.local/bin' "$rc" 2>/dev/null; then
        printf '\n# Downix / user commands\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$rc"
      fi
      export PATH="$BIN_DIR:$PATH"
      ;;
  esac
}

printf '%b\n' "${GREEN}DOWNIX v${VERSION}${RESET}"
printf '%s\n' "Instalación automática multiplataforma"
printf '\n'
install_system_deps
ensure_storage_termux
ensure_venv
install_deno
install_runtime_updater
install_command

mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/downix"
if is_termux; then
  mkdir -p "$HOME/storage/shared/Download/Downix/Music" "$HOME/storage/shared/Download/Downix/Video" 2>/dev/null || true
else
  mkdir -p "${HOME}/Downloads/Downix/Music" "${HOME}/Downloads/Downix/Video" 2>/dev/null || true
fi

printf '\n'
ok "Downix instalado correctamente."
printf 'Comando: %bdown%b\n' "$GREEN" "$RESET"
printf 'Actualizar runtime: %bdown --update%b\n' "$GREEN" "$RESET"
printf '\nSi esta terminal aún no reconoce down, ejecuta: export PATH="$HOME/.local/bin:$PATH"\n'
