#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### COPY FILES
cp -rv /tmp/sysfiles/* /

### INSTALLS PACKAGE(S) FROM FEDORA REPOS
dnf5 -y install \
$(cat /tmp/packages/desktop_std) \
$(cat /tmp/packages/desktop_env) \
$(cat /tmp/packages/security) \
$(cat /tmp/packages/fonts) \
$(cat /tmp/packages/personal) 

### INSTALLS PACKAGE(S) FROM COPR REPOS
dnf5 -y install ghostty
dnf5 -y install starship

### DISABLING SYSTEM UNIT FILE(S)
systemctl disable cosmic-greeter.service

### ENABLING SYSTEM UNIT FILE(S)
systemctl enable bootc-fetch-apply-updates.timer
systemctl enable tuned.service
systemctl enable podman.socket
systemctl enable fstrim.timer
systemctl enable firewalld.service

### CHANGE DEFAULT FIREWALLD ZONE
cp /etc/firewalld/firewalld-workstation.conf /etc/firewalld/firewalld-workstation.conf.bak
sed -i 's/DefaultZone=FedoraWorkstation/DefaultZone=drop/g' /etc/firewalld/firewalld-workstation.conf

### FIX BUG PREVENTING SYSTEMD-REMOUNT-FS.SERVICE TO START - DOES NOT WORK
# sed -i 's/subvol\[=.*\]/#&/g' /etc/fstab

### CLEAN UP
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
rm -rf /etc/yum.repos.d/atim-starship-fedora-41.repo
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:a-zhn:ghostty.repo
