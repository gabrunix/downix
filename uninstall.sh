#!/usr/bin/env bash
set -e
if [[ -n "${TERMUX_VERSION:-}" || "${PREFIX:-}" == *com.termux* ]]; then
  rm -f "$PREFIX/bin/down"
  rm -f "$PREFIX/bin/downix-uninstall"
else
  sudo rm -f /usr/local/bin/down
  sudo rm -f /usr/local/bin/downix-uninstall
fi
printf "Downix fue desinstalado. Tus descargas no fueron borradas.\n"
