FROM debian:buster-slim

RUN apt-get update && apt-get install -y build-essential git cmake libfreerdp-dev libjpeg-dev libx11-dev libxcb-randr0-dev libxcb-xtest0-dev libxext-dev libxfixes-dev libxi-dev fakeroot devscripts

WORKDIR /app

COPY . .

RUN cmake -H. -Bbuild && cmake --build build --target package
