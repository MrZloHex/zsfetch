#!/bin/bash

MAN_PATH="/usr/local/man/man1"
OS_TYPE="linux"

get_os(){
	case "$OSTYPE" in 
		darwin*)
			OS_TYPE="darwin"
			MAN_PATH="/usr/share/man/man1"
		;;

		*) 
			OS_TYPE="linux"
			MAN_PATH="/usr/local/man/man1"
		;;
	esac		
}

install(){
	# installing program
	sudo mv zsfetch /usr/local/bin

	sudo mkdir $MAN_PATH
	sudo mv zsfetch.1 $MAN_PATH
	sudo gzip $MAN_PATH/zsfetch.1
	
	if [[ $OS_TYPE == "linux" ]]
	then
		sudo mandb
	fi
}

uninstall() {
	sudo rm /usr/local/bin/zsfetch
	sudo rm $MAN_PATH/zsfetch.1.gz
}

main() {
	get_os
	case $1 in
		"-i" | "--install") 
			install
			echo "DONE!!!"
			;;
		"-u" | "--uninstall")
			uninstall
			echo "DONE!!!"
			;;
		*)
			echo "For installation run:"
			echo "	./stall.sh -i"
			echo "	./stall.sh --install"
			echo "For uninstallation run:"
			echo "	./stall.sh -u"
			echo "	./stall.sh --uninstall"
			;;
	esac
	

}

main "$@"
