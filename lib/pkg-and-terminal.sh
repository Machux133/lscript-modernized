#!/bin/bash
# This file is sourced by `l`, not run directly. It holds lscript's
# apt/dnf package-manager abstraction and the gnome-terminal/konsole/
# xterm terminal-emulator abstraction (pkg_install, pkg_remove,
# pkg_autoremove, detect_pkgmgr, open_terminal).
#############PACKAGE MANAGER ABSTRACTION###############
#lscript was written for apt-get (Debian/Kali/Parrot). These three
#functions let the rest of the script also run on dnf-based systems
#(Fedora/RHEL-family) without having to special-case every call site.
function detect_pkgmgr
{
	if command -v apt-get &> /dev/null
	then
		PKGMGR="apt"
	elif command -v dnf &> /dev/null
	then
		PKGMGR="dnf"
	else
		PKGMGR="unknown"
	fi
	export PKGMGR
}
function pkg_install
{
	#usage: pkg_install <apt-package-name> [<apt-package-name> ...]
	#Package names are written as their apt (Debian/Kali) name, same
	#as the rest of this script always has. On dnf systems, known
	#name differences are translated below; packages this fork hasn't
	#verified as existing on Fedora print a warning instead of
	#guessing silently.
	local apt_pkgs=("$@")
	if [[ "$PKGMGR" = "dnf" ]]
	then
		local dnf_pkgs=()
		local p
		for p in "${apt_pkgs[@]}"
		do
			case "$p" in
				ncurses-dev) dnf_pkgs+=("ncurses-devel") ;;
				python-pip|python3-pip) dnf_pkgs+=("python3-pip") ;;
				python-dev) dnf_pkgs+=("python3-devel") ;;
				python-setuptools) dnf_pkgs+=("python3-setuptools") ;;
				python-tqdm) dnf_pkgs+=("python3-tqdm") ;;
				libpcap0.8-dev) dnf_pkgs+=("libpcap-devel") ;;
				libnetfilter-queue-dev) dnf_pkgs+=("libnetfilter_queue-devel") ;;
				libssl-dev) dnf_pkgs+=("openssl-devel") ;;
				libjpeg-dev) dnf_pkgs+=("libjpeg-turbo-devel") ;;
				libxml2-dev) dnf_pkgs+=("libxml2-devel") ;;
				libxslt1-dev) dnf_pkgs+=("libxslt-devel") ;;
				libcapstone3|libcapstone-dev) dnf_pkgs+=("capstone-devel") ;;
				libffi-dev) dnf_pkgs+=("libffi-devel") ;;
				gnome-terminal|fuse|pulseaudio|nmap|arp-scan|iftop|geany|bleachbit|masscan|file|php-curl|bcrypt|wine|ruby|rubygem-bundler|nodejs|make|gcc-c++|git|python3|python3-requests|python3-scapy|curl|autoconf|automake|libtool|libnet-devel|libpcap-devel|hwdata)
					dnf_pkgs+=("$p") ;;
				open-vm-tools-desktop)
					dnf_pkgs+=("open-vm-tools-desktop" "open-vm-tools") ;;
				nginx-full|nginx-common)
					echo -e """$RS""'$p' isn't available via dnf on Fedora/RHEL-family systems (Debian-only split package, not needed there). Skipping.""$CE""" ;;
				*)
					echo -e """$RS""'$p' hasn't been verified on dnf-based systems - trying the same package name, but it may not exist there.""$CE"""
					dnf_pkgs+=("$p") ;;
			esac
		done
		if [[ "${#dnf_pkgs[@]}" -gt 0 ]]
		then
			dnf -y install "${dnf_pkgs[@]}"
		fi
	elif [[ "$PKGMGR" = "apt" ]]
	then
		apt-get -y install "${apt_pkgs[@]}"
	else
		echo -e """$RS""No supported package manager (apt-get/dnf) found. Install manually: ${apt_pkgs[*]}""$CE"""
	fi
}
function pkg_remove
{
	#usage: pkg_remove <apt-package-name> [<apt-package-name> ...]
	local apt_pkgs=("$@")
	if [[ "$PKGMGR" = "dnf" ]]
	then
		local dnf_pkgs=()
		local p
		for p in "${apt_pkgs[@]}"
		do
			case "$p" in
				nginx-full|nginx-common) ;;
				*) dnf_pkgs+=("$p") ;;
			esac
		done
		if [[ "${#dnf_pkgs[@]}" -gt 0 ]]
		then
			dnf -y remove "${dnf_pkgs[@]}"
		fi
	elif [[ "$PKGMGR" = "apt" ]]
	then
		apt-get -y remove "${apt_pkgs[@]}"
	fi
}
function pkg_autoremove
{
	if [[ "$PKGMGR" = "dnf" ]]
	then
		dnf -y autoremove
	elif [[ "$PKGMGR" = "apt" ]]
	then
		apt-get -y autoremove
	fi
}
#############TERMINAL EMULATOR ABSTRACTION###############
#lscript opens its helper menus (handshake-menu/deauth-menu/wps-menu/
#wep-menu) and a few tools in
#their own terminal window via gnome-terminal. open_terminal also
#supports konsole (KDE) and xterm as fallbacks, so this works outside
#GNOME too.
function open_terminal
{
	#usage: open_terminal "<WxH+X+Y geometry, or "" for none>" "<command line>"
	local geometry="$1"
	local cmdline="$2"
	if command -v gnome-terminal &> /dev/null
	then
		if [[ "$geometry" = "" ]]
		then
			gnome-terminal -- bash -c "$cmdline"
		else
			gnome-terminal --geometry "$geometry" -- bash -c "$cmdline"
		fi
	elif command -v konsole &> /dev/null
	then
		#konsole's --geometry has been unreliable for sizing/positioning
		#new windows across KDE 4/5/6 (KDE bug 147094), so geometry is
		#only honored on gnome-terminal/xterm. konsole's process model
		#isn't guaranteed to detach like gnome-terminal does, so this is
		#backgrounded explicitly.
		konsole -e bash -c "$cmdline" & disown
	elif command -v xterm &> /dev/null
	then
		if [[ "$geometry" = "" ]]
		then
			xterm -e bash -c "$cmdline" & disown
		else
			xterm -geometry "$geometry" -e bash -c "$cmdline" & disown
		fi
	else
		echo -e """$RS""No supported terminal emulator found (gnome-terminal/konsole/xterm). Run this manually: ""$CE""$cmdline"
	fi
}
