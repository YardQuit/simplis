[![Build_Image](https://github.com/YardQuit/simplis/actions/workflows/build.yml/badge.svg)](https://github.com/YardQuit/simplis/actions/workflows/build.yml)
[![Clean_Images](https://github.com/YardQuit/simplis/actions/workflows/cleanup.yml/badge.svg)](https://github.com/YardQuit/simplis/actions/workflows/cleanup.yml)
[![Dependabot Updates](https://github.com/YardQuit/simplis/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/YardQuit/simplis/actions/workflows/dependabot/dependabot-updates)

# simplis

## Purpose

Testing

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
Rebase from unsigned to signed:
```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/yardquit/simplis:latest
```
Restart your system for the changes take effect:
```bash
systemctl reboot
```

### bootc switch
Rebase from bootc
```bash
sudo bootc switch --enforce-container-sigpolicy ghcr.io/yardquit/simplis:latest
```

Restart your system for the changes take effect:
```bash
systemctl reboot
```
