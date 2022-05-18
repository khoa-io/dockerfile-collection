#!/bin/sh

for i in /etc/ssh/*.pub; do echo; echo ${i}; ssh-keygen -lf ${i}; done; echo
/usr/sbin/sshd -D
