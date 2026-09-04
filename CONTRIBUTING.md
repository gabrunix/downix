# Contributing

Contributions, bug reports and portability fixes are welcome.

Before submitting a change:

1. Test `./install.sh` in the target environment.
2. Verify `down --version` and the interactive menu start correctly.
3. Test one public audio URL and one public video URL you are authorized to download.
4. Test **Update dependencies** from the menu when changing runtime logic.
5. Avoid hard-coded home directories or distro-specific absolute paths.
6. Keep Termux and desktop Linux behavior separated where required.
7. Do not add DRM bypass functionality.
