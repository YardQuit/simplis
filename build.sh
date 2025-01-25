#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### COPY FILES
cp -rv /tmp/sysfiles/* /

### INSTALL PACKAGES
dnf -y install \
$(cat /tmp/packages/desktop)

### Enabling System Unit File(s)
systemctl enable bootc-fetch-apply-updates.timer
systemctl enable podman.socket
systemctl enable fstrim.timer

### Disabling System Unit File(s)

### Clean Up
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
