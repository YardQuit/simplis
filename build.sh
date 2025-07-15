#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### COPY FILES
cp -rv /tmp/sysfiles/* /
chmod +x /etc/cron.daily/*

### INSTALLS PACKAGE(S) FROM FEDORA REPOS
dnf5 install --skip-unavailable -y \
$(cat /tmp/packages/desktop) \
$(cat /tmp/packages/fonts) \
$(cat /tmp/packages/generic) \
$(cat /tmp/packages/develop) \
$(cat /tmp/packages/security)

### INSTALLS PACKAGE(S) FROM COPR REPOS
dnf5 -y install ghostty
dnf5 -y install starship
dnf5 -y install lf

### DISABLING SYSTEM UNIT FILE(S)
systemctl disable cosmic-greeter.service

### ENABLING SYSTEM UNIT FILE(S)
systemctl enable tuned.service
systemctl enable podman.socket
systemctl enable fstrim.timer
systemctl enable firewalld.service
systemctl enable tailscaled.service

### CHANGE DEFAULT FIREWALLD ZONE
cp /etc/firewalld/firewalld-workstation.conf /etc/firewalld/firewalld-workstation.conf.bak
sed -i 's/DefaultZone=FedoraWorkstation/DefaultZone=drop/g' /etc/firewalld/firewalld-workstation.conf

### YUBICO CHALLANGE FOR SUDO
cp /etc/pam.d/sudo /etc/pam.d/sudo.bak
sed -i '/PAM-1.0/a\auth       required     pam_yubico.so mode=challenge-response' /etc/pam.d/sudo

### CREATE MISSING DIRS
mkdir -p /var/spool/anacron

### CLEAN UP
dnf5 -y clean all
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
rm -rf /etc/yum.repos.d/atim-starship-fedora-41.repo
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:pgdev:ghostty.repo
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:pennbauman:ports.repo
rm -rf /etc/yum.repos.d/_copr_ryanabx-cosmic.repo
