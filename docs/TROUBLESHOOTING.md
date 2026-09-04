# Troubleshooting

## Diagnose

```bash
down --doctor
```

## YouTube extractor / nsig / EJS errors

Use:

```bash
down --update
```

The interactive downloader also recognizes several common compatibility errors and retries once after updating its isolated runtime.

## APT repository errors

Downix does not require the distro's `yt-dlp` package. Its installer tries to install missing base packages without forcing `apt update` first. A broken third-party APT repository therefore should not affect Downix when the required base packages are already installed.

## Termux storage

If `~/storage/shared` is missing:

```bash
termux-setup-storage
```

Grant the Android storage permission and rerun `./install.sh`.
