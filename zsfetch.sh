#!/bin/bash
# zsfetch simple POSIX fetch command-line script


# making normal name of OS
decrypt_os() {
	case $general_os in
		Linux | GNU* )	 	os=Linux		;;


		* )	echo "UNKNOWN OS"
			echo "Aborting..."
			exit 1							;;

	esac
}


# getting some standart inforamtion from uname
get_uname(){
	IFS=" " read -ra uname <<< "$(uname -srm)"

    general_os="${uname[0]}"
    distro="${uname[1]}"
    architecture="${uname[2]}"
}


main() {
	get_uname
	decrypt_os
}

main "$@"