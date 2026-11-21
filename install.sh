#! /bin/bash
clear
printf '\033]2;INSTALLER\a'

#############################
# lscript files, relative to the repo/install root
#############################
LSCRIPT_FILES=(
	"l" "lh1" "lh2" "lh3" "lh31" "lh4" "lh41" "lh21" "lh42" "lh43"
	"ls/l131.sh" "ls/l132.sh" "ls/l133.sh" "uninstall.sh" "install.sh"
)
# subset that also gets copied to /bin/lscript so 'l' can find its helpers on PATH
LSCRIPT_BIN_FILES=(
	"l" "lh1" "lh2" "lh3" "lh31" "lh4" "lh41" "lh21" "lh42" "lh43"
)

if [[ "$EUID" -ne 0 ]]
then
	echo -e "This script needs to be run as root (e.g. with sudo).\nAborting."
	exit 1
fi

#############################
# minimal apt/dnf abstraction so this installer also works on
# Fedora/RHEL-family systems, not just Debian/Kali/Parrot
#############################
if command -v apt-get &> /dev/null
then
	PKGMGR="apt"
elif command -v dnf &> /dev/null
then
	PKGMGR="dnf"
else
	PKGMGR="unknown"
fi
function open_terminal
{
	#usage: open_terminal "<command line>"
	local cmdline="$1"
	if command -v gnome-terminal &> /dev/null
	then
		gnome-terminal -- bash -c "$cmdline"
	elif command -v konsole &> /dev/null
	then
		konsole -e bash -c "$cmdline" & disown
	elif command -v xterm &> /dev/null
	then
		xterm -e bash -c "$cmdline" & disown
	else
		echo -e "No supported terminal emulator found (gnome-terminal/konsole/xterm). Run this manually: $cmdline"
	fi
}
function pkg_install
{
	#package names are given as their apt name; translate the few
	#that differ on dnf-based systems
	if [[ "$PKGMGR" = "apt" ]]
	then
		apt-get -y install "$@"
	elif [[ "$PKGMGR" = "dnf" ]]
	then
		local pkgs=()
		local p
		for p in "$@"
		do
			if [[ "$p" = "ncurses-dev" ]]
			then
				pkgs+=("ncurses-devel")
			else
				pkgs+=("$p")
			fi
		done
		dnf -y install "${pkgs[@]}"
	else
		echo -e "No supported package manager (apt-get/dnf) found. Install manually: $*"
	fi
}

echo -e "Press \e[1;33many key\e[0m to install the script..."
read -n 1 -r
clear
#only install gnome-terminal if this system has no terminal emulator
#open_terminal can already use (konsole/xterm on KDE, for instance)
if ! command -v gnome-terminal &> /dev/null && ! command -v konsole &> /dev/null && ! command -v xterm &> /dev/null
then
	pkg_install gnome-terminal
fi
clear

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [[ "$DIR" != "/root/lscript" ]]
then
	echo -e "You didn't follow the github's simple install instructions. I will try to do it for you..."
	sleep 4
	if [[ -d /root/lscript ]]
	then
		rm -rf /root/lscript
	fi
	mkdir -p /root/lscript
	cp -r "$DIR"/* /root/lscript
	chmod +x /root/lscript/install.sh
	open_terminal "bash /root/lscript/install.sh"
	# The relocated copy above will do the real install; this instance is
	# running from the wrong path and must not continue (it would otherwise
	# race the new terminal and install everything twice).
	exit 0
fi

echo -e "Installing lscript..."
sleep 1
echo -e "Fixing permissions"
sleep 2
for f in "${LSCRIPT_FILES[@]}"
do
	chmod +x "/root/lscript/$f"
done

clear
echo -e "Copying script to /bin/lscript"
sleep 1
mkdir -p /bin/lscript
cd /root/lscript || exit 1
for f in "${LSCRIPT_BIN_FILES[@]}"
do
	cp "/root/lscript/$f" /bin/lscript/
done

clear
#required for gui
pkg_install ncurses-dev
clear

if [[ ! -d /root/handshakes ]]
then
	mkdir -p /root/handshakes
	echo -e "Made /root/handshake directory"
else
	echo -e "/root/handshakes directory detected. Good."
fi

if [[ ! -d /root/wordlists ]]
then
	mkdir -p /root/wordlists
	echo -e "Made /root/wordlists directory"
else
	echo -e "/root/wordlists directory detected. Good."
fi

while true
do
	clear
	echo -e "Are you \e[1;33mu\e[0mpdating or \e[1;33mi\e[0mnstalling the script?(\e[1;33mu\e[0m/\e[1;33mi\e[0m): "
	echo -e "Only use 'i' for the first time."
	read -r UORI
	if [[ "$UORI" = "u" ]]
	then
		clear
		echo -e "Type 'changelog' to see what's new on this version"
		sleep 3
		break
	elif [[ "$UORI" = "i" ]]
	then
		clear
		if grep -qF "/bin/lscript" ~/.bashrc 2>/dev/null
		then
			echo -e "lscript is already on your PATH (~/.bashrc). Skipping, so it doesn't get added twice."
			sleep 3
		else
			echo -e "Adding lscript to PATH so you can access it from anywhere"
			sleep 1
			echo 'export PATH=/bin/lscript:$PATH' >> ~/.bashrc
			sleep 1
		fi
		export PATH=/bin/lscript:$PATH
		clear
		break
	fi
done

clear
echo -e "DONE"
sleep 1
clear
echo -e "Open a NEW terminal and type 'l' to launch the script"
sleep 4
open_terminal "l"
exit 0
