FROM debian:stretch

RUN apt update && apt upgrade -y
RUN apt install -y git live-build cdebootstrap debootstrap curl wget procps
RUN wget http://archive.linux.duke.edu/kalilinux/kali/pool/main/k/kali-archive-keyring/kali-archive-keyring_2018.2_all.deb -O /tmp/keyring.deb
RUN wget http://archive.linux.duke.edu/kalilinux/kali/pool/main/l/live-build/live-build_20190311_all.deb -O /tmp/live_build.deb
RUN dpkg -i /tmp/live_build.deb
RUN dpkg -i /tmp/keyring.deb
RUN sed -e "s/debian-archive-keyring.gpg/kali-archive-keyring.gpg/g" /usr/share/debootstrap/scripts/sid > /usr/share/debootstrap/scripts/kali
RUN sed -i '1 i\default_mirror http://archive.linux.duke.edu/kalilinux/kali' /usr/share/debootstrap/scripts/kali 
RUN ln -s /usr/share/debootstrap/scripts/kali /usr/share/debootstrap/scripts/kali-rolling

WORKDIR /root/kali-builder/
ADD . / /root/kali-builder/
CMD ["tail", "-f", "/dev/null"]
