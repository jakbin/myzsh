#!/bin/bash

intall-zsh-syntax-highlighting () {
	mkdir ~/.zsh-ext
	cd ~/.zsh-ext
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
	cd /data/data/com.termux/files/usr/etc/
	sed -i  "2isource ~/.zsh-ext/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" zshrc
}

intall-zsh-autosuggestions () {
	mkdir ~/.zsh-ext
	cd ~/.zsh-ext
	git clone https://github.com/zsh-users/zsh-autosuggestions.git
	cd /data/data/com.termux/files/usr/etc/
	sed -i  "2isource ~/.zsh-ext/zsh-autosuggestions/zsh-autosuggestions.zsh" zshrc
}

intall-zsh-autocomplete () {
	mkdir ~/.zsh-ext
	cd ~/.zsh-ext
	git clone https://github.com/marlonrichert/zsh-autocomplete.git
	cd /data/data/com.termux/files/usr/etc/
	sed -i  "2isource ~/.zsh-ext/zsh-autocomplete/zsh-autocomplete.plugin.zsh" zshrc
}

install-lsd () {
	mkdir ~/.zsh-ext
	cd ~/.zsh-ext
	echo "downloading lsd"
	wget "https://github.com/Peltoche/lsd/releases/download/0.21.0/lsd_0.21.0_amd64.deb"
	echo "installing lsd"
	sudo dpkg -i lsd_0.21.0_amd64.deb
	rm ~/.zsh-ext/lsd_0.21.0_amd64.deb
}

install-colorls () {
	cd mkdir ~/.zsh-ext
	cd ~/.zsh-ext
	gem install colorls
}

printf "Available plugins:-
(1) zsh-syntax-highlighting
(2) zsh-autosuggestions
(3) zsh-autocomplete
(4) lsd
(5) colorls\n"

read -p "which plugin do you want to install, enter number :-" num

if [[ $num -eq "1" ]]; then
	intall-zsh-syntax-highlighting
elif [[ $num -eq "2" ]]; then
	intall-zsh-autosuggestions
elif [[ $num -eq "3" ]]; then
	intall-zsh-autocomplete
elif [[ $num -eq "4" ]]; then
	install-lsd
elif [[ $num -eq "5" ]]; then
	install-colorls
else
	echo "else"
fi