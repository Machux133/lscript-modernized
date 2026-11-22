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

function remove_installation_files
{
	local bin_dir="$1" bashrc="$2"
	if [[ -L "$bin_dir" || -L "$bashrc" ]]
	then
		printf 'Uninstall stopped: %s or %s is a symbolic link.\n' "$bin_dir" "$bashrc" >&2
		return 1
	fi
	if [[ -d "$bin_dir" ]]
	then
		rm -f -- "$bin_dir"/{l,handshake-menu,deauth-menu,deauth-autocheck,wps-menu,wep-menu} || return 1
		rmdir --ignore-fail-on-non-empty -- "$bin_dir" || return 1
		if [[ -d "$bin_dir" ]]
		then
			printf 'Other files under %s were preserved.\n' "$bin_dir"
		fi
	fi
	if [[ -f "$bashrc" ]] && grep -qxF 'export PATH=/bin/lscript:$PATH' "$bashrc"
	then
		sed -i '/^export PATH=\/bin\/lscript:\$PATH$/d' "$bashrc" || return 1
		printf 'Removed lscript from PATH in %s\n' "$bashrc"
	fi
}

if [[ "${BASH_SOURCE[0]}" != "$0" ]]
then
	return 0
fi

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
		echo -e "Removing the installed launcher and helper commands"
		sleep 4

		remove_installation_files /bin/lscript ~/.bashrc || exit 1

		printf '%s\n' 'Source files and settings under /root/lscript were preserved.'

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
