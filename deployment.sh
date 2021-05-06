#!/bin/bash

OS_TYPE="linux"

get_os(){
	case "$OSTYPE" in 
		darwin*)
			OS_TYPE="darwin"
		;;

		*) 
			OS_TYPE="linux"
		;;
	esac		
}

install(){
	# installing program
	sudo mv zsfetch /usr/local/bin

	# installing man page
	if [[ $OS_TYPE == "linux" ]]
	then
		#sudo mkdir /usr/local/man
		sudo mkdir /usr/local/man/man1
		sudo mv zsfetch.1 /usr/local/man/man1
		sudo gzip /usr/local/man/man1/zsfetch.1
		sudo mandb

	elif [[ $OS_TYPE == "darwin" ]] 
	then
		sudo mkdir /usr/share/man/man1
		sudo mv zsfetch.1 /usr/share/man/man1
		sudo gzip /usr/local/man/man1/zsfetch.1
		sudo man-db
	fi
}

uninstall() {
	sudo rm /usr/local/bin/zsfetch

	if [[ $OS_TYPE == "linux" ]]
	then	
		sudo rm /usr/share/man/man1/zsfetch.1.gz

	elif [[ $OS_TYPE == "darwin" ]] 
	then11
		sudo rm /usr/share/man/man1/zsfetch.1.gz
	fi
}

main() {
	get_os
	case $1 in
		"-i" | "--install") 
			install
			;;
		"-u" | "--uninstall")
			uninstall
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
	
	echo "DONE!!!"
}

main "$@"
