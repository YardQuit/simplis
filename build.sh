#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### COPY FILES
cp -rv /tmp/sysfiles/* /

### INSTALL PACKAGES
# dnf -y install \
# $(cat /tmp/packages/<filename>)

### Run configuration scripts
sh /tmp/scripts/script_template.sh

### Disabling System Unit File(s)

### Enabling System Unit File(s)
# systemctl enable rpm-ostreed-automatic.timer
# systemctl enable tuned.service
# systemctl enable podman.socket
# systemctl enable fstrim.timer

### Clean Up
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)