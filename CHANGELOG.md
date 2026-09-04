# Changelog

## 1.1.1 - 2026-09-03

### Changed
- Redesigned and reorganized the README with clearer sections, icons, tables and copy/paste installation blocks.
- Added a complete one-block Termux installation flow: update, Git install, clone and Downix installation.
- Corrected the author name to **Gabriel Urbaesz**.
- Removed the optional diagnostic subcommand and its related documentation.
- Kept `down --update` as the simple manual runtime update command.

### Runtime
- Downix uses an isolated Python virtual environment.
- `yt-dlp[default]` keeps `yt-dlp-ejs` paired with yt-dlp.
- Private Deno runtime installation and upgrades remain enabled.
- Automatic one-time recovery remains enabled for common YouTube extractor/runtime errors.
- Package-manager detection supports pkg, apt, dnf, pacman, zypper and apk.

### Preserved
- Bilingual ES/EN menu.
- MP3/MP4 quality selection.
- Music/Video folder organization.
- Termux Android storage integration.
