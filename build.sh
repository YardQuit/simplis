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

### INSTALLS RPMs
wget https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
mv 1password-latest.rpm /tmp/
dnf5 -y install /tmp/1password-latest.rpm

### FIXING ABRTD SERVICE FROM FAILING TO START
# groupadd abrt

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

### ERROR WITH BOOTC PREVENTING SYSTEMD-REMOUNT-FS.SERVICE TO START - APPLY POST INSTALL
# sed -i 's/subvol\[=.*\]/#&/g' /etc/fstab

### CLEAN UP
shopt -s extglob
rm -rf /tmp/* || true
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
rm -rf /etc/yum.repos.d/atim-starship-fedora-41.repo
rm -rf /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:a-zhn:ghostty.repo
rm -rf /etc/yum.repos.d/_copr_ryanabx-cosmic.repo
rm -rf 
