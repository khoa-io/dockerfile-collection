# syntax=docker/dockerfile:1
FROM alpine:latest

ARG USER="ubuntu"
ARG UID="1000"
ARG GROUP="ubuntu"
ARG GID="1000"
ARG PUBKEY=""

RUN apk add --no-cache openssh-server zsh zsh-syntax-highlighting git git-lfs sudo doas nano

RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

RUN adduser -s /bin/zsh -D -u ${UID} ${USER} && passwd -u ${USER}
RUN addgroup ${USER} wheel
RUN echo "${USER}   ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} && chmod 0440 /etc/sudoers.d/${USER}

RUN ssh-keygen -A
RUN for i in /etc/ssh/*.pub; do echo; echo ${i}; ssh-keygen -lf ${i}; done; echo

USER ${USER}
RUN mkdir -p /home/${USER}/.ssh
RUN chmod 700 /home/${USER}/.ssh
RUN echo "$PUBKEY" > /home/${USER}/.ssh/authorized_keys
RUN chmod 644 /home/${USER}/.ssh/authorized_keys

USER root
COPY ./startup.sh /
EXPOSE 22
CMD ["/bin/sh", "/startup.sh"]
