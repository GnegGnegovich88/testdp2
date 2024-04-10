FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y build-essential git cmake libfreerdp2-dev libjpeg-dev libx11-dev libxcb-randr0-dev libxcb-xtest0-dev libxext-dev libxfixes-dev libxi-dev fakeroot devscripts

WORKDIR /app

COPY . /app

RUN git clone --branch <branch_name> https://salsa.debian.org/debian-remote-team/freerdp2.git /app/freerdp2 && \
    cmake -H/app/freerdp2 -B/app/build && \
    cmake --build /app/build && \
    fakeroot dpkg-buildpackage -b -us -uc
