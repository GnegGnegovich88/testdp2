FROM debian:buster-slim

RUN apt-get update && apt-get install -y build-essential git cmake libfreerdp-dev libjpeg-dev libx11-dev libxcb-randr0-dev libxcb-xtest0-dev libxext-dev libxfixes-dev libxi-dev fakeroot devscripts

WORKDIR /app

COPY . .

RUN echo "deb http://packages.linuxmint.com debian main upstream import backport" > /etc/apt/sources.list.d/official-package-repositories.list


RUN cmake -H. -Bbuild && cmake --build build --target package
