# Contributing

Contributions, bug reports and portability fixes are welcome.

Before submitting a change:

1. Test `./install.sh` in the target environment.
2. Run `down --doctor`.
3. Test one public audio URL and one public video URL you are authorized to download.
4. Avoid hard-coded home directories or distro-specific absolute paths.
5. Keep Termux and desktop Linux behavior separated where required.
6. Do not add DRM bypass functionality.
