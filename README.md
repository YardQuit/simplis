<<<<<<< HEAD
# simplis
simplis
=======
[![Build_Image](https://github.com/YardQuit/simplis/actions/workflows/build.yml/badge.svg)](https://github.com/YardQuit/simplis/actions/workflows/build.yml)
[![Build ISOs](https://github.com/YardQuit/simplis/actions/workflows/build-iso.yml/badge.svg)](https://github.com/YardQuit/simplis/actions/workflows/build-iso.yml)
[![Clean_Images](https://github.com/YardQuit/simplis/actions/workflows/cleanup.yml/badge.svg)](https://github.com/YardQuit/simplis/actions/workflows/cleanup.yml)
[![Dependabot Updates](https://github.com/YardQuit/simplis/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/YardQuit/simplis/actions/workflows/dependabot/dependabot-updates)

# simplis

## Purpose

My personal daily-drive with Cosmic Desktop and yubikey challange for sudo access

## Install
### rpm-ostree rebase
Rebase from rpm-ostree:
```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/yardquit/simplis:latest
```
Restart your system for the changes take effect:
```bash
systemctl reboot
```

### bootc switch
Rebase from bootc
```bash
sudo bootc switch ghcr.io/yardquit/simplis:latest
```

Restart your system for the changes take effect:
```bash
systemctl reboot
```

### YubiKey
Instructions to complete the yubikey registration process.
```bash
# Insert your YubiKey into a compatible USB port on your computer.
ykpamcfg -2
```
Ensure that YubiKey support is enabled and functional in your system settings.
```bash
sudo echo "Testing sudo with YubiKey"
```
>>>>>>> 51df65d (Initial commit)
