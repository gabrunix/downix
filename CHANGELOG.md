# Changelog

## 1.1.0 - 2026-09-03

### Added
- Isolated Downix Python virtual environment.
- `yt-dlp[default]` installation so `yt-dlp-ejs` stays paired with yt-dlp.
- Private Deno runtime installation and upgrades.
- Automatic one-time self-healing retry for common YouTube extractor/runtime errors.
- `down --doctor` and `down --update`.
- Package-manager detection for pkg, apt, dnf, pacman, zypper and apk.

### Changed
- Downix no longer uses distro-packaged yt-dlp as its runtime.
- APT installation avoids `apt update` unless direct package installation fails.
- Installer writes user commands to `~/.local/bin` instead of requiring a system-wide Downix install.

### Preserved
- Bilingual ES/EN menu.
- MP3/MP4 quality selection.
- Music/Video folder organization.
- Termux Android storage integration.
