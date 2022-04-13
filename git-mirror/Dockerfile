# syntax=docker/dockerfile:1
FROM sshd:latest

ARG USER="git"
ARG UID="1001"
ARG GROUP="git"
ARG GID="1001"
ARG PUBKEY=""

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install software-properties-common curl -y
RUN add-apt-repository ppa:git-core/ppa -y
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get update && apt-get install git git-lfs -y

RUN groupadd -g $GID $GROUP
RUN useradd --system --create-home --shell /bin/zsh --uid $UID --gid $GROUP --groups sudo $USER

USER $USER
RUN mkdir -p /home/$USER/.ssh
RUN chmod 700 /home/$USER/.ssh
RUN echo "$PUBKEY" > /home/$USER/.ssh/authorized_keys
RUN chmod 644 /home/$USER/.ssh/authorized_keys

USER root
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
