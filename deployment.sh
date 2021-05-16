#!/bin/bash

######################
#  Made by MrZloHex  #
#     15.05.2021     #
######################

MAN_PATH="/usr/local/man/man1"
OS_TYPE="linux"

load(){
	while [ 1 ]
	do
		echo >&6 -ne "."
		sleep 0.3
	done
}

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
	
	echo >&6 -n "Installing"

	load &
	PID=$!

	sudo mv zsfetch /usr/local/bin

	sudo mkdir $MAN_PATH
	sudo mv zsfetch.1 $MAN_PATH
	sudo gzip $MAN_PATH/zsfetch.1
	
	if [[ $OS_TYPE == "linux" ]]
	then
		sudo mandb
	fi

	sleep 1
	echo >&6 ""

	kill $PID
}

uninstall() {
	
	echo >&6 -n  "Uninstalling"
	load &
	PID=$!

	sudo rm /usr/local/bin/zsfetch
	sudo rm $MAN_PATH/zsfetch.1.gz

	sleep 1
	echo >&6 ""

	kill $PID
}

main() {	
	exec 6>&1 >/dev/null
	sudo ls

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
