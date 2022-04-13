# syntax=docker/dockerfile:1
FROM ubuntu:latest

ARG USER="ubuntu"
ARG UID="1000"
ARG GROUP="ubuntu"
ARG GID="1000"
ARG PUBKEY=""

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install openssh-server sudo zsh -y

RUN groupadd -g $GID $GROUP
RUN useradd --system --create-home --shell /bin/zsh --uid $UID --gid $GROUP --groups sudo $USER

RUN ssh-keygen -A
RUN service ssh start
RUN for i in /etc/ssh/*.pub; do echo; echo $i; ssh-keygen -lf $i; done; echo
RUN echo "%sudo   ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER
RUN mkdir -p /home/$USER/.ssh
RUN chmod 700 /home/$USER/.ssh
RUN echo "$PUBKEY" > /home/$USER/.ssh/authorized_keys
RUN chmod 644 /home/$USER/.ssh/authorized_keys

USER root
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
