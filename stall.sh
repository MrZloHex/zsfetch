#!/bin/bash

install(){
	sudo mv zsfetch /usr/local/bin
	sudo mkdir /usr/local/man/man1
	sudo mv zsfetch.1 /usr/local/man/man1
	sudo gzip /usr/local/man/man1/zsfetch.1
	sudo mandb

}

uninstall() {
	sudo rm /usr/local/bin/zsfetch
	sudo rm /usr/local/man/man1/zsfetch.1	
}

main() {
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
