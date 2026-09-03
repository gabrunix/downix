<div align="center">

![Downix Terminal Media Downloader](assets/downix-cover.png)

# ⬇️ Downix

![Version](https://img.shields.io/badge/version-1.0.0-00e676?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-2196f3?style=flat-square)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Termux-fbc02d?style=flat-square)
![Shell](https://img.shields.io/badge/shell-Bash-4eaa25?style=flat-square)

**A fast, clean, and organized terminal media downloader for Linux and Termux.**

> Download audio and video. Choose the quality. Keep everything organized.

</div>

---

## ✨ Features

- 🎵 Download audio in **MP3** format
- 🎚️ Select **128, 192, 256, or 320 kbps** audio quality
- 🎬 Download video in **MP4** format
- 📺 Select **480p, 720p, 1080p, 1440p, 2160p**, or the best available quality
- 📁 Automatically organize downloads into Music and Video folders
- 🌐 Work with public links supported by `yt-dlp`
- 📱 Open Android's file explorer directly from the menu
- 🔄 Update dependencies without leaving Downix
- 🌍 Switch between **English and Spanish**
- 🐧 Run on Termux and popular Linux distributions
- 🔓 Open-source and lightweight

---

## 🐧 Quick Install

### 📱 Termux / Android

```bash
pkg update
pkg install git -y

git clone https://github.com/gabrunix/downix.git
cd downix
chmod +x install.sh
./install.sh
```

Allow storage access when Android requests it.

### 🐧 Linux

```bash
git clone https://github.com/gabrunix/downix.git
cd downix
chmod +x install.sh
./install.sh
```

The installer detects supported package managers and installs the necessary
dependencies automatically.

Once installed, launch Downix from any directory:

```bash
down
```

---

## 🖥️ Usage

Run:

```bash
down
```

The interactive menu provides the following options:

```text
[1] Download MP3 audio
[2] Download MP4 video
[3] Browse downloaded files
[4] Update dependencies
[5] Change language
[0] Exit
```

Paste a supported URL, choose the desired quality, and Downix handles the rest.

---

## 📂 Download Organization

Downix keeps audio and video files separated automatically:

```text
Download/
└── Downix/
    ├── Music/
    └── Video/
```

- **Termux:** `~/storage/shared/Download/Downix`
- **Linux:** `~/Downloads/Downix`

The uninstaller never deletes downloaded media.

---

## 📦 Requirements

Downix uses:

- `Bash`
- `Python` and `pip` on Termux
- `yt-dlp`
- `FFmpeg`
- `termux-am` on Termux for Android file explorer integration
- `xdg-utils` on supported desktop Linux systems

The installer handles supported dependencies automatically.

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for third-party software
and licensing information.

---

## 🐧 Platforms

Downix is designed for Unix-like environments.

Currently targeted:

- 📱 Termux / Android
- 🐉 Kali Linux
- 🌀 Debian
- 🟠 Ubuntu
- 🌿 Linux Mint
- 🚀 Pop!_OS
- 🔷 Fedora
- 🏹 Arch Linux
- 🟢 Manjaro
- And many more

> Platform support depends on the availability of the required packages and
> the behavior of each media platform.

---

## 🔄 Updating

```bash
cd downix
git pull
./install.sh
```

To update runtime dependencies, select **Update dependencies** from the Downix
menu.

---

## 🗑️ Uninstall

```bash
downix-uninstall
```

This removes the installed commands but preserves your downloaded media.

---

## 🗺️ Roadmap

- [x] MP3 audio downloads
- [x] MP4 video downloads
- [x] Multiple audio quality options
- [x] Multiple video resolution options
- [x] Automatic download organization
- [x] English and Spanish interfaces
- [x] Termux and Linux support
- [x] Android file explorer integration
- [ ] Download history
- [ ] Batch downloads
- [ ] Custom themes
- [ ] Optional cookie import assistant

---

## 🤝 Contributing

Contributions, bug reports, and feature suggestions are welcome.

See [CONTRIBUTING.md](CONTRIBUTING.md) for development and contribution
guidelines. For security-related reports, read [SECURITY.md](SECURITY.md).

---

## ⚖️ Disclaimer

Downix is an independent open-source terminal media downloader.

Downix does not host, distribute, or provide media content. It uses external
tools such as `yt-dlp` and `FFmpeg` to process URLs requested by the user.

Users are responsible for complying with the terms of service of the platforms
they access, applicable copyright laws, and local regulations. Only download
content that you own, that is in the public domain, or that you are authorized
to download.

Downix does not bypass DRM and is not affiliated with YouTube, Google,
Instagram, Meta, Facebook, Pinterest, `yt-dlp`, `FFmpeg`, or any supported
media platform.

---

## 📜 License

Downix is released under the **MIT License**.

See [LICENSE](LICENSE) for details.

---

## 👤 Author

**G4brun1x — Gabriel Urbaez**

- GitHub: [@gabrunix](https://github.com/gabrunix)

Copyright © 2026 G4brun1x. Released under the terms of the MIT License.
