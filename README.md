<div align="center">

![Downix Terminal Media Downloader](assets/downix-banner.png)

# ⬇️ Downix

![Version](https://img.shields.io/badge/version-1.1.0-00e676?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-2196f3?style=flat-square)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Termux-fbc02d?style=flat-square)
![Shell](https://img.shields.io/badge/shell-Bash-4eaa25?style=flat-square)

**A fast, clean, self-maintaining terminal media downloader for Linux and Termux.**

</div>

## What's new in 1.1.0

- Downix no longer relies on an outdated distro-provided `yt-dlp`.
- Creates its own isolated Python runtime in `~/.local/share/downix/venv`.
- Installs and updates `yt-dlp[default]`, including `yt-dlp-ejs`.
- Installs a private Deno runtime for current YouTube JavaScript challenges.
- Detects common `yt-dlp`/YouTube compatibility failures, updates the runtime, and retries once automatically.
- Avoids running `apt update` unless package installation actually needs it, reducing failures caused by unrelated broken third-party repositories.
- Adds `down --doctor` and `down --update`.

## Features

- MP3: 128 / 192 / 256 / 320 kbps
- MP4: 480p / 720p / 1080p / 1440p / 2160p / best available
- Automatic Music / Video organization
- English / Spanish persistent menu
- Android/Termux storage integration
- Runtime self-update from inside the menu
- YouTube, Instagram, Facebook, Pinterest and other public URLs supported by `yt-dlp`

## Install

```bash
git clone https://github.com/gabrunix/downix.git
cd downix
chmod +x install.sh
./install.sh
```

Then run:

```bash
down
```

Termux users only need Git before cloning:

```bash
pkg update
pkg install git -y
```

The installer handles the rest.

## Supported environments

Primary targets:

- Termux / Android
- Kali Linux
- Debian
- Ubuntu
- Linux Mint
- Pop!_OS
- Fedora
- Arch Linux
- Manjaro

The installer also contains package-manager support for zypper- and apk-based systems when compatible packages are available.

## Commands

```bash
down            # interactive menu
down --doctor   # dependency/runtime diagnostics
down --update   # update yt-dlp, yt-dlp-ejs and Deno
down --version
```

## Downloads

Linux:

```text
~/Downloads/Downix/
├── Music/
└── Video/
```

Termux:

```text
~/storage/shared/Download/Downix/
├── Music/
└── Video/
```

## How dependency management works

System package managers are used only for base tools such as Python, FFmpeg and curl. Downix intentionally does **not** use the distro's `yt-dlp` package for its runtime.

Runtime components are kept under:

```text
~/.local/share/downix/
├── down
├── venv/       # yt-dlp + yt-dlp-ejs
├── deno/       # private JavaScript runtime
└── update-runtime
```

This prevents an old `/usr/bin/yt-dlp` from breaking Downix.

## Uninstall

```bash
downix-uninstall
```

Downloaded media is preserved.

## Disclaimer

Downix does not host, distribute, or provide media content. It uses external tools such as `yt-dlp`, FFmpeg and Deno to process URLs requested by the user. Users are responsible for complying with platform terms, copyright laws and local regulations. Only download content you own, public-domain content, or content you are authorized to download. Downix does not bypass DRM.

## License

MIT License. See `LICENSE` and `THIRD_PARTY_NOTICES.md`.

## Author

**G4brun1x — Gabriel Konstantinovich**  
GitHub: **@gabrunix**
