# Dockerfile for NetStorm
#
# Linux kabah 4.4.0-96-generic #119~14.04.1-Ubuntu SMP Wed Sep 13 08:40:48 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
# Docker version 17.05.0-ce, build 89658be
#
# docker build -t netstorm .
# xhost +
# docker run -i --rm --net=host --ipc=host -v /tmp/.X11-unix/X0:/tmp/.X11-unix/X0 -v /run/user/1000/pulse:/run/user/1000/pulse -v /home/paul:/home/paul netstorm

FROM m0elnx/ubuntu-32bit

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y --no-install-recommends pulseaudio-utils && \
	apt-get install -y --no-install-recommends wine && \
	apt-get autoremove -y --purge && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY machine-id /var/lib/dbus/machine-id
COPY asound.cnf /etc/asound.cnf
COPY pulse-client.conf /etc/pulse/client.conf

RUN groupadd -g 1000 paul
RUN useradd -u 1000 -g paul -d /home/paul -s /bin/bash paul
RUN adduser paul audio

ENV DISPLAY :0.0
ENV HOME /home/paul
ENV XDG_RUNTIME_DIR /run/user/1000

USER paul
WORKDIR /home/paul
CMD wine "c:\Program Files\Netstorm\Netstorm.exe"

