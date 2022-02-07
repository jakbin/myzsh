#!/bin/bash
# check if .zshrc file exits
File=/home/$USER/.zshrc
if [ -f "$File" ]; then
	echo "$File exists."
	mv /home/$USER/.zshrc /home/$USER/zshrc-backup.sh
	echo "old .zshrc moved to zshrc-backup.sh"
fi

url='https://raw.githubusercontent.com/jakbin/myzsh/main/.zshrc'
wget -P /home/$USER/ $url
echo ".zshrc file downloaded"