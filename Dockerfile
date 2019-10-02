FROM ubuntu:16.04
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y build-essential cmake git

RUN apt-get install -y libsndfile1-dev libfftw3-dev libsamplerate0-dev \
                       qtbase5-dev qtbase5-private-dev qttools5-dev-tools qttools5-dev qt5-default \
                       libqt5x11extras5-dev libxinerama-dev libxft-dev libxcb-keysyms1-dev libxcb-util0-dev \
                       libvorbis-dev libogg-dev libmp3lame-dev \
                       libsdl-dev libasound2-dev libjack-jackd2-dev portaudio19-dev libpulse-dev libsoundio-dev libsndio-dev \
                       libfluidsynth-dev libgig-dev libstk0-dev stk libfltk1.3-dev fluid \
                       perl libxml2-utils libxml-perl liblist-moreutils-perl

RUN apt-get install -y wget

RUN apt-get install -y software-properties-common
RUN dpkg --add-architecture i386
RUN apt-get install -y apt-transport-https
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key && apt-key add winehq.key
RUN apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' && apt-get update
RUN apt install -y --install-recommends winehq-staging wine-staging-dev gcc-multilib g++-multilib

# Carla stuff
# Detour to ubuntu 14
RUN add-apt-repository -y 'deb http://ppa.launchpad.net/kxstudio-debian/libs/ubuntu trusty main'
RUN add-apt-repository -y 'deb http://ppa.launchpad.net/kxstudio-debian/apps/ubuntu trusty main'
# RUN add-apt-repository -y ppa:kxstudio-debian/libs && add-apt-repository -y ppa:kxstudio-debian/apps
RUN apt-get update
RUN apt-get --allow-unauthenticated install -y carla


# Remove apt cache
RUN apt clean


# Configure Wine
RUN apt-get install -y curl
COPY wine.sh /app/
RUN chmod +x /app/wine.sh && /app/wine.sh


# Build && install
COPY build.sh /app/
RUN chmod +x /app/build.sh && /app/build.sh
