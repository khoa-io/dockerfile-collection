# syntax=docker/dockerfile:1
FROM ubuntu:22.04

ARG USER="git"
ARG UID="1000"
ARG GROUP="git"
ARG GID="1000"
ARG PUBKEY=""

RUN apt-get update && apt-get upgrade -y && apt-get install -y openssh-server git curl bash
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get update && apt-get install -y git-lfs git-core gnupg flex bison build-essential zip curl zlib1g-dev libncurses5 x11proto-core-dev libx11-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig repo zsh zsh-syntax-highlighting sudo
# AMD64: gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev lib32z1-dev
# RUN apt-get install -y gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev lib32z1-dev

RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN ssh-keygen -A

RUN useradd --create-home --shell /bin/zsh --uid ${UID} --user-group ${USER}
RUN echo "${USER}	ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}
RUN mkdir -p /home/${USER}/.ssh && \
    chmod 700 /home/${USER}/.ssh && \
    echo "$PUBKEY" > /home/${USER}/.ssh/authorized_keys && \
    chmod 644 /home/${USER}/.ssh/authorized_keys

USER root
COPY ./startup.sh /
EXPOSE 22

WORKDIR /home/${USER}
CMD ["/bin/sh", "/startup.sh"]
