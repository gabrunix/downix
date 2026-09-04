#!/usr/bin/env bash
set -euo pipefail
APP_HOME="${DOWNIX_HOME:-$HOME/.local/share/downix}"
BIN_DIR="$HOME/.local/bin"
rm -f "$BIN_DIR/down" "$BIN_DIR/downix" "$BIN_DIR/downix-uninstall"
rm -rf "$APP_HOME"
printf 'Downix desinstalado. Tus archivos descargados no fueron eliminados.\n'
