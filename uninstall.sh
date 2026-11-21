#! /bin/bash

function no_uninstall
{
	echo -e "I knew you are still lazy :D :D "
	sleep 2
	echo -e "If you want any feature to be added, contact me on FB"
	sleep 2
	echo -e " "
	echo -e "Aris"
	sleep 1
	exit 0
}

if [[ "$EUID" -ne 0 ]]
then
	echo -e "This script needs to be run as root (e.g. with sudo).\nAborting."
	exit 1
fi

echo -e "Do you really want to uninstall the Lazy script from your system?(y/n)(Enter=no): "
read -r CHUN
if [[ "$CHUN" = "y" ]]
then
	echo -e "If you have any problems please contact me first."
	echo -e "Do you still wanna get rid of me?(y/n)(Enter=no): "
	read -r CHCHUN
	if [[ "$CHCHUN" = "y" ]]
	then
		echo -e "Ok, uninstalling everything that has to do with lscript on your system"
		sleep 4

		if [[ -d /bin/lscript ]]
		then
			rm -rf /bin/lscript
			echo -e "Removed /bin/lscript"
		fi

		if [[ -f ~/.bashrc ]] && grep -qF "/bin/lscript" ~/.bashrc
		then
			sed -i '/export PATH=\/bin\/lscript:\$PATH/d' ~/.bashrc
			echo -e "Removed lscript from PATH in ~/.bashrc"
		fi

		echo -e "Do you also want to delete the /root/lscript source folder?(y/n)(Enter=no): "
		read -r CHSRC
		if [[ "$CHSRC" = "y" && -d /root/lscript ]]
		then
			rm -rf /root/lscript
			echo -e "Removed /root/lscript"
		fi

		echo -e "Done."
		sleep 1
		echo -e "Open a new terminal for the PATH change to take effect."
		echo -e "Press any key to exit..."
		read -r -n 1
		exit 0
	else
		no_uninstall
	fi
else
	no_uninstall
fi
