#!/bin/bash

# set locale
echo "########## set locale ##########"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# set /bin/sh to bash
echo "########## set /bin/sh to bash ##########"
echo "dash dash/sh boolean false" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

apt-get update && apt-get upgrade -y

# wine-staging
echo "########## install wine-staging ##########"
dpkg --add-architecture i386
apt-get install -y apt-transport-https
wget -nc https://dl.winehq.org/wine-builds/winehq.key && apt-key add winehq.key
apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' && apt-get update
# wine-staging-dev g++-multilib -> wine compile library
# gcc-multilib -> libraray for compiling 32bit on 64bit OS
apt-get install -y --install-recommends winehq-staging wine-staging-dev gcc-multilib g++-multilib

# for X11 forwarding issue
echo "X11UseLocalHost no" >> /etc/ssh/sshd_config
echo "########## 'X11UseLocalHost no' added to /etc/ssh/sshd_config ##########"

# install and unzip Native Access installer
echo "########## locate Native_Access_Installer to /tmp ##########"
apt install p7zip-full # Use p7zip-full. You might get error, if you don't do.
wget "https://www.native-instruments.com/fileadmin/downloads/Native_Access_Installer.zip"
7z x Native_Access_Installer.zip -o/tmp
rm Native_Access_Installer.zip

# install mesa utils for using glxinfo
echo "########## install mesa-utils for using glxinfo ##########"
apt install mesa-utils
