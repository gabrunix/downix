<div align="center">

![Downix Terminal Media Downloader](assets/downix-banner.png)

# ⬇️ DOWNIX

### Terminal Media Downloader for Linux & Termux

![Version](https://img.shields.io/badge/version-1.1.1-00e676?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-2196f3?style=for-the-badge)
![Linux](https://img.shields.io/badge/Linux-supported-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Termux](https://img.shields.io/badge/Termux-supported-000000?style=for-the-badge&logo=android&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-shell-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)

**Fast · Clean · Bilingual · Self-maintaining**

Download audio and video directly from your terminal, choose the quality, and let Downix organize everything automatically.

</div>

---

## ✨ Features

| | Feature |
|---|---|
| 🎵 | Download audio as **MP3** |
| 🎚️ | Audio quality: **128 / 192 / 256 / 320 kbps** |
| 🎬 | Download video as **MP4** |
| 📺 | Video quality: **480p / 720p / 1080p / 1440p / 2160p / Best** |
| 📁 | Automatic organization into **Music** and **Video** folders |
| 🌐 | Public URLs supported by `yt-dlp` |
| 🔄 | Update runtime dependencies directly from Downix |
| 🛠️ | Automatic recovery for common YouTube / `yt-dlp` compatibility errors |
| 🌍 | Persistent **Español / English** interface |
| 📱 | Native Android storage integration in Termux |
| 🐧 | Support for popular Linux distributions |

---

## 🚀 Installation

### 📱 Termux / Android — copy and paste everything

Open Termux and paste this complete block:

```bash
pkg update -y && \
pkg install -y git && \
cd "$HOME" && \
rm -rf downix && \
git clone https://github.com/gabrunix/downix.git && \
cd downix && \
chmod +x install.sh && \
./install.sh
```

When Android asks for storage permission, **allow it**.

After installation, run:

```bash
down
```

> The installer takes care of Python, FFmpeg, curl, the isolated Downix runtime, current `yt-dlp`, `yt-dlp-ejs`, Deno, storage folders, and the `down` command.

### 🐧 Linux — copy and paste

```bash
cd "$HOME" && \
rm -rf downix && \
git clone https://github.com/gabrunix/downix.git && \
cd downix && \
chmod +x install.sh && \
./install.sh
```

Then:

```bash
down
```

The installer automatically detects the available package manager and installs the required base dependencies when necessary.

---

## 🖥️ Interface

```text
  ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗██╗  ██╗
  ██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║╚██╗██╔╝
  ██║  ██║██║   ██║██║ █╗ ██║██╔██╗ ██║██║ ╚███╔╝
  ██║  ██║██║   ██║██║███╗██║██║╚██╗██║██║ ██╔██╗
  ██████╔╝╚██████╔╝╚███╔███╔╝██║ ╚████║██║██╔╝ ██╗
  ╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝
            by G4brun1x  •  Media Downloader

  [1] Descargar audio MP3
  [2] Descargar video MP4
  [3] Explorar archivos descargados
  [4] Actualizar dependencias
  [5] Cambiar idioma
  [0] Salir
```

---

## 📂 Download folders

### Linux

```text
~/Downloads/Downix/
├── Music/
└── Video/
```

### Termux / Android

```text
~/storage/shared/Download/Downix/
├── Music/
└── Video/
```

Downloaded media is **not removed** when Downix is uninstalled.

---

## 🧠 Self-managed runtime

Downix does not depend on an old distro-provided `yt-dlp` package.

It keeps its runtime isolated under:

```text
~/.local/share/downix/
├── down
├── venv/          # yt-dlp + yt-dlp-ejs
├── deno/          # JavaScript runtime
└── update-runtime
```

This means a stale `/usr/bin/yt-dlp` from APT or another package manager will not break Downix.

When Downix detects common extractor or JavaScript challenge errors, it can update its own runtime and retry the download once automatically.

---

## 🔄 Update dependencies

From the interactive menu choose:

```text
[4] Actualizar dependencias
```

Or run:

```bash
down --update
```

This updates the Downix-managed `yt-dlp` runtime and Deno without replacing your downloaded media.

---

## 🐧 Supported environments

Downix targets:

- 📱 **Termux / Android**
- 🐉 **Kali Linux**
- 🌀 **Debian**
- 🟠 **Ubuntu**
- 🌿 **Linux Mint**
- 🚀 **Pop!_OS**
- 🔷 **Fedora**
- 🏹 **Arch Linux**
- 🟢 **Manjaro**
- ⚙️ Other compatible Unix-like systems using supported package managers

Package-manager detection currently includes `pkg`, `apt`, `dnf`, `pacman`, `zypper`, and `apk` where compatible packages are available.

---

## ⌨️ Commands

```bash
down            # Open Downix
down --update   # Update the managed runtime
down --version  # Show Downix version
```

---

## 🗑️ Uninstall

```bash
downix-uninstall
```

Your downloaded music and videos are preserved.

---

## 🧩 Project structure

```text
downix/
├── assets/
│   └── downix-banner.png
├── docs/
│   └── TROUBLESHOOTING.md
├── down
├── install.sh
├── uninstall.sh
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── SECURITY.md
├── THIRD_PARTY_NOTICES.md
├── LICENSE
└── .gitignore
```

---

## ⚖️ Disclaimer

Downix is an independent open-source terminal media downloader. It does not host or distribute media content.

It uses external tools such as `yt-dlp`, FFmpeg and Deno to process URLs requested by the user. Users are responsible for complying with platform terms of service, copyright laws and local regulations. Only download content you own, public-domain content, or content you are authorized to download.

Downix does not bypass DRM and is not affiliated with YouTube, Google, Instagram, Meta, Facebook, Pinterest, `yt-dlp`, FFmpeg or Deno.

---

## 📜 License

Released under the **MIT License**. See [`LICENSE`](LICENSE) and [`THIRD_PARTY_NOTICES.md`](THIRD_PARTY_NOTICES.md).

---

<div align="center">

## 👤 Author

**G4brun1x — Gabriel Urbaesz**

GitHub: **[@gabrunix](https://github.com/gabrunix)**

**Downix · Terminal-first · Open Source · Linux + Termux**

</div>
