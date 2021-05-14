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
	exec 6>&1 >/dev/null
	
	if [[ $2 != '-v' ]]
	then
		exec 2>/dev/null
	
	elif [[ $2 == '-v' ]] 
	then
		echo >&6 "verbose mode"	
	fi



	get_os

	case $1 in
		"-i" | "--install") 
			install
			echo >&6 "DONE!!!"
			;;
		"-u" | "--uninstall")
			uninstall
			echo >&6 "DONE!!!"
			;;
		*)
			echo >&6 "For installation run:"
			echo >&6 "	./stall.sh -i"
			echo >&6 "	./stall.sh --install"
			echo >&6 "For uninstallation run:"
			echo >&6 "	./stall.sh -u"
			echo >&6 "	./stall.sh --uninstall"
			;;
	esac
	

}

main "$@"
