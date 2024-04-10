FROM ubuntu:22.04

ARG BRANCH_NAME

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:remmina/ppa && \
    apt-get update && \
    apt-get install -y build-essential git cmake libfreerdp2-dev libjpeg-dev libx11-dev libxcb-randr0-dev libxcb-xtest0-dev libxext-dev libxfixes-dev libxi-dev fakeroot devscripts

WORKDIR /app

RUN git clone --branch ${BRANCH_NAME} https://github.com/GnegGnegovich88/testdp2.git /app/freerdp2 && \
    cmake -H/app/freerdp2 -B/app/build && \
    cmake --build /app/build && \
    fakeroot dpkg-buildpackage -b -us -uc

RUN ls -la /app/*.deb
