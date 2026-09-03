# Upload Downix to GitHub from Termux

## 1. Install Git and GitHub CLI

```bash
pkg update
pkg install git gh
```

## 2. Configure Git identity

```bash
git config --global user.name "gabrunix"
git config --global user.email "gabrunixx@gmail.com"
```

## 3. Sign in to GitHub

```bash
gh auth login
```

Choose `GitHub.com`, `HTTPS`, and browser authentication.

## 4. Extract the repository into Termux home

```bash
cd ~
tar -xzf ~/storage/downloads/Downix-GitHub-Ready.tar.gz
cd ~/downix
```

Keep the Git repository in Termux home. Android shared storage does not preserve
all Unix permissions reliably.

## 5. Initialize and publish

```bash
git init
git branch -M main
git add .
git commit -m "Initial release of Downix"
gh repo create downix --public --source=. --remote=origin --push
```

## 6. Open the repository

```bash
gh repo view --web
```

## Future updates

```bash
git add .
git commit -m "Describe the update"
git push
```

Use `--private` instead of `--public` if you do not want other people to see or
clone the repository. The MIT license is included for public distribution.
