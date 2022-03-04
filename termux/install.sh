#!/bin/bash
# check if .zshrc file exits
File=/data/data/com.termux/files/usr/etc/zshrc
if [ -f "$File" ]; then
	echo "$File exists."
	mv /data/data/com.termux/files/usr/etc/zshrc /data/data/com.termux/files/usr/etc/zshrc-back.sh
	echo "old zshrc moved to zshrc-backup.sh"
fi

url='https://raw.githubusercontent.com/jakbin/myzsh/main/termux/zshrc'
wget -P /data/data/com.termux/files/usr/etc/ $url
echo "zshrc file downloaded"