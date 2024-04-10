# Выбираем базовый образ
FROM ubuntu:20.04

# Устанавливаем необходимые зависимости для сборки
RUN apt-get update && \
    apt-get install -y git build-essential cmake libfreerdp2-dev libjpeg-dev libx11-dev libxcb-randr0-dev libxcb-xtest0-dev libxext-dev libxfixes-dev libxi-dev fakeroot devscripts

# Клонируем git-репозиторий с указанной веткой/тэгом
ARG GIT_BRANCH=main
RUN git clone --branch ${GIT_BRANCH} https://github.com/GnegGnegovich88/testdp2.git /app

# Задаем рабочий каталог
WORKDIR /app

# Копируем Dockerfile для сборки docker-образа
COPY Dockerfile/app/

# Собираем docker-образ для сборки проекта
RUN docker build -t build-image -f Dockerfile.build .

# Запускаем сборку проекта внутри docker-контейнера
RUN docker run --rm -v $(pwd):/app build-image /bin/bash -c "cmake -H. -Bbuild && cmake --build build && fakeroot dpkg-buildpackage -b -us -uc"

# Выводим список собранных артефактов (deb-пакетов)
RUN ls -la *.deb
