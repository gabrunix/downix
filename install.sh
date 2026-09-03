#!/usr/bin/env bash
set -e

GREEN='\033[1;32m'; CYAN='\033[1;36m'; RESET='\033[0m'
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -n "${TERMUX_VERSION:-}" || "${PREFIX:-}" == *com.termux* ]]; then
  printf "${CYAN}Instalando Downix para Termux / Installing Downix...${RESET}\n"
  pkg update
  pkg install -y python ffmpeg
  pkg install -y termux-am || true
  python -m pip install -U yt-dlp
  mkdir -p "$PREFIX/bin"
  install -m 755 "$SCRIPT_DIR/down" "$PREFIX/bin/down"
  install -m 755 "$SCRIPT_DIR/uninstall.sh" "$PREFIX/bin/downix-uninstall"
  termux-setup-storage || true
  printf "\n${GREEN}Listo. Usa 'down' para iniciar y 'downix-uninstall' para desinstalar.${RESET}\n"
  # Un clon de Git conserva el código fuente. Los paquetes normales de
  # instalación limpian automáticamente sus archivos temporales.
  if [[ ! -d "$SCRIPT_DIR/.git" && ! -d "$SCRIPT_DIR/../.git" ]]; then
    rm -f -- "$SCRIPT_DIR/down" "$SCRIPT_DIR/uninstall.sh" \
      "$SCRIPT_DIR/README.md" "$SCRIPT_DIR/install.sh"
    if [[ "$PWD" != "$SCRIPT_DIR" ]]; then
      rmdir -- "$SCRIPT_DIR" 2>/dev/null || true
    fi
  fi
elif command -v apt-get >/dev/null 2>&1; then
  printf "${CYAN}Instalando Downix para Debian/Ubuntu/Kali...${RESET}\n"
  sudo apt-get update
  sudo apt-get install -y yt-dlp ffmpeg xdg-utils
  sudo install -m 755 "$SCRIPT_DIR/down" /usr/local/bin/down
  sudo install -m 755 "$SCRIPT_DIR/uninstall.sh" /usr/local/bin/downix-uninstall
  printf "\n${GREEN}Listo. Escribe: down${RESET}\n"
elif command -v dnf >/dev/null 2>&1; then
  sudo dnf install -y yt-dlp ffmpeg xdg-utils
  sudo install -m 755 "$SCRIPT_DIR/down" /usr/local/bin/down
  sudo install -m 755 "$SCRIPT_DIR/uninstall.sh" /usr/local/bin/downix-uninstall
  printf "\n${GREEN}Listo. Escribe: down${RESET}\n"
elif command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed yt-dlp ffmpeg xdg-utils
  sudo install -m 755 "$SCRIPT_DIR/down" /usr/local/bin/down
  sudo install -m 755 "$SCRIPT_DIR/uninstall.sh" /usr/local/bin/downix-uninstall
  printf "\n${GREEN}Listo. Escribe: down${RESET}\n"
else
  printf "Distribución no detectada. Instala yt-dlp y ffmpeg, y copia down al PATH.\n"
  exit 1
fi
