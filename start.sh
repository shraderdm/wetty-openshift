#!/bin/bash
/sbin/sshd -D -f /opt/sshd_config &
/usr/bin/wetty -p 8888

