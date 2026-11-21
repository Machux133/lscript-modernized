#! /bin/bash

# set -x
# These four are read from functions that now live in lib/*.sh (ShellCheck's
# cross-file analysis doesn't trace a var set here and read in a sourced
# file in this direction, even with the source= directives below).
# shellcheck disable=SC2034
VERSION=2.1.5
#Number of tools with keyboard shortcut support
# shellcheck disable=SC2034
HOWMANYTOOLS=53
BACKL="0"
# shellcheck disable=SC2034
DONATIONS=13
# shellcheck disable=SC2034
LATESTCHANGELOGLINES=26
#############LIBRARIES###############
# At runtime lscript is always installed to /root/lscript, so these are
# hardcoded absolute paths (matching every other /root/lscript reference
# in this codebase) rather than resolved relative to this file's own
# location. The `source=` directives below just tell ShellCheck where to
# actually find these files in the repo for static analysis purposes.
# shellcheck source=lib/pkg-and-terminal.sh
source /root/lscript/lib/pkg-and-terminal.sh
# shellcheck source=lib/tool-installers.sh
source /root/lscript/lib/tool-installers.sh
# shellcheck source=lib/core-utils.sh
source /root/lscript/lib/core-utils.sh
# shellcheck source=lib/wlan-interface.sh
source /root/lscript/lib/wlan-interface.sh
# shellcheck source=lib/shortcuts.sh
source /root/lscript/lib/shortcuts.sh
# shellcheck source=lib/wifi-attacks.sh
source /root/lscript/lib/wifi-attacks.sh
# shellcheck source=lib/mitm-and-web.sh
source /root/lscript/lib/mitm-and-web.sh
# shellcheck source=lib/recon-and-exploit.sh
source /root/lscript/lib/recon-and-exploit.sh
detect_pkgmgr
cd || exit
# shellcheck disable=SC2154 # wififb is assigned in core-utils.sh's defaults_l, read further below
function main_options
{
	if [[ "$YORNAA" = "0" ]]
	then
		exit
	elif [[ "$YORNAA" = "gate" || "$YORNAA" = "gateway" ]]
	then
		TT=$(ip addr | grep "$WLANN")
		if [[ "$TT" = "" ]]
		then
			echo -e """$RS""""$WLANN"" is not available""$CE"""
			sleep 2
		else
			GATE=$(find_gateways "$WLANN" interface)
			TTT=$(is_it_an_ip "$GATE")
			if [[ "$TTT" != 1 ]]
			then
				echo -e """$RS""Couldn't find your gateway.""$CE"""
				sleep 2
				echo -e """$RS""Make sure you are connected to a network""$CE"""
				sleep 2
			else
				echo -e """$YS""Gateway found: ""$GATE""""$CE"""
				sleep 1
				xdg-open http://"$GATE"
				BACKL=1
			fi
		fi
	elif [[ "$YORNAA" = "scan" ]]
	then
		if [[ ! -f /usr/bin/arp-scan && ! -f /usr/sbin/arp-scan ]]
		then
			echo -e """$BS""Installing arp-scan""$CE"""
			install_arp_scan
			clear
		fi
		if [[ -f "$LPATH"/settings/arpin.txt ]]
		then
			read ARPIN < "$LPATH"/settings/arpin.txt
		else
			ARPIN="$WLANN"
		fi
		if [[ "$ARPIN" = "" ]]
		then
			ARPIN="$WLANN"
		fi
		TESTARP=$(ip addr | grep "$ARPIN")
		if [[ "$TESTARP" = "" ]]
		then
			clear
			echo -e """$RS""$ARPIN was not found""$CE"""
			sleep 2
			BACKL=1
		else
			ip_scan "$ARPIN" 2
		fi
	elif [[ "$YORNAA" = "22" ]]
	then
		IFTOPT=$(command -v iftop)
		if [[ "$IFTOPT" == "" ]]
		then
			pkg_install iftop
		fi
		CHECK=$(ip addr | grep "$iftopint")
		if [[ "$CHECK" = "" ]]
		then
			echo -e """$RS""Interface ""$iftopint"" was not found"
			sleep 2
		else
			xterm -hold -T "Iftop on $iftopint" -e "iftop -n -i $iftopint -b" & disown
			BACKL=1
		fi
	elif [[ "$YORNAA" = "21" ]]
	then
		sqlmap_menu
	elif [[ "$YORNAA" = "19" ]]
	then
		echo -e """$BS""IP:""$CE"" "
		read IPG
		clear
		geolocate_ip "$IPG"
	elif [[ "$YORNAA" = "18" ]]
	then
		browser_exploiting
	elif [[ "$YORNAA" = "m" ]]
	then
		mitmf_hook
	elif [[ "$YORNAA" = "g" ]]
	then
		find_gateways
	elif [[ "$YORNAA" = "l" ]]
	then
		local_ips
	elif [[ "$YORNAA" = "17" ]]
	then
		if [[ ! -f "/usr/local/bin/howdoi" ]]
		then
			echo -e """$RS""Howdoi is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_howdoi
			fi
		else
			clear
			if [[ -f "$LPATH"/settings/dispfull.txt ]]
			then
				read dispfull < "$LPATH"/settings/dispfull.txt
				if [[ "$dispfull" = "true" ]]
				then
					df="-a"
				fi
			else
				df=""
			fi
			if [[ -f "$LPATH"/settings/colorout.txt ]]
			then
				read colorout < "$LPATH"/settings/colorout.txt
				if [[ "$colorout" = "true" ]]
				then
					co="-c"
				fi
			else
				co=""
			fi
			if [[ -f "$LPATH"/settings/onlylink.txt ]]
			then
				read onlylink < "$LPATH"/settings/onlylink.txt
				if [[ "$onlylink" = "true" ]]
				then
					ol="-l"
				fi
			else
				ol=""
			fi
			if [[ -f "$LPATH"/settings/numofans.txt ]]
			then
				read numofans < "$LPATH"/settings/numofans.txt
				if [[ "$numofans" = "true" ]]
				then
					na="-n ${numofans}"
				fi
			else
				na=""
			fi
			echo -e "How do i :  "
			read HOW
			howdoi "$co" "$na" "$ol" "$df" "$HOW"
		fi
	elif [[ "$YORNAA" = "settings" || "$YORNAA" = "s" ]]
	then
		settings_menu
	elif [[ "$YORNAA" = "16" ]]
	then
		ngrok_option
		BACKL=1
	elif [[ "$YORNAA" = "donate" || "$YORNAA" = "d" ]]
	then
		donate_option
#------services
	elif [[ "$YORNAA" = "pstart" ]]
	then
		service postgresql start && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
	elif [[ "$YORNAA" = "pstop" ]]
	then
		service postgresql stop && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
	elif [[ "$YORNAA" = "nstart" ]]
	then
		service network-manager start && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
	elif [[ "$YORNAA" = "nstop" ]]
	then
		service network-manager stop && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
	elif [[ "$YORNAA" = "astart" ]]
	then
		service apache2 start && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
	elif [[ "$YORNAA" = "astop" ]]
	then
		service apache2 stop && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
	elif [[ "$YORNAA" = "nessusstart" ]]
	then
		if [[ -f /etc/init.d/nessusd ]]
		then
			/etc/init.d/nessusd start && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
		else
			echo -e """$RS""Nessus is not already installed.""$CE"""
			sleep 2
		fi
	elif [[ "$YORNAA" = "nessusstop" ]]
	then
		if [[ -f /etc/init.d/nessusd ]]
		then
			/etc/init.d/nessusd stop && echo -e """$YS""Done""$CE""" || echo -e """$RS""Error""$CE"""
		else
			echo -e """$RS""Nessus is not already installed.""$CE"""
			sleep 2
		fi
#-------------
	elif [[ "$YORNAA" = "15" ]]
	then
		BACKL="1"
		spoof_email
	elif [[ "$YORNAA" = "ks" ]]
	then
		keyboard_shortcuts
	elif [[ "$YORNAA" = "interface" ]]
	then
		interface_menu
	elif [[ "$YORNAA" = "9" ]]
	then
		tools_menu
	elif [[ "$YORNAA" = "l" ]]
	then
		clear 
		exec bash "$0"
	elif [[ "$YORNAA" = "gg" ]]
	then
		geany /bin/lscript/l
	elif [[ "$YORNAA" = "1" ]]
	then
		enable_wlan
	elif [[ "$YORNAA" = "d1" ]]
	then
		check_wlans
		if [[ "$WLANCHECKING" = "" ]]
		then
			echo -e """$RS""Error. Could find $WLANN interface to disable.""$CE"""
		else
			disable_wlan
		fi
	elif [[ "$YORNAA" = "2" ]]
	then
		check_wlans
		if [[ "$WLANCHECKING" = "" ]]
		then
			echo -e """$RS""Error. Could find $WLANN interface.""$CE"""
		else
			echo -e "Enabling $WLANNM..."
			echo -e "Killing services..."
			(airmon-ng check kill &> /dev/null && echo -e "Done." ) || echo -e """$RS""Error killing services""$YS"""
			echo -e "Starting monitor mode..."
			(airmon-ng start "$WLANN" &>/dev/null && echo -e "Done" ) || echo -e "Error starting monitor mode."
		fi
	elif [[ "$YORNAA" = "d2" ]]
	then
		check_wlans
		if [[ "$WLANMCHECKING" = "" ]]
		then
			echo -e """$RS""Error. Could find $WLANNM interface.""$CE"""
		else
			stop_monitor
		fi
	elif [[ "$YORNAA" = "3" ]]
	then
		change_mac
	elif [[ "$YORNAA" = "d3" ]]
	then
		interface_selection
		clear
		echo -e "Changing mac address of $MYINT to the original one..."
		ip link set "$MYINT" down
		macchanger -p "$MYINT"
		ip link set "$MYINT" up
		echo -e "Done."
	elif [[ "$YORNAA" = "4" ]]
	then
		if [[ ! -f "/etc/init.d/anonym8.sh" ]]
		then
			echo -e """$RS""Anonym8 is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_anonym8
			fi
		else
			echo -e "Enabling anonym8..."
			anonym8 start
			echo -e "Done."
		fi
	elif [[ "$YORNAA" = "d4" ]]
	then
		if [[ ! -f "/etc/init.d/anonym8.sh" ]]
		then
			echo -e """$RS""Anonym8 is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_anonym8
			fi
		else
			echo -e "Disabling anonym8..."
			anonym8 stop
			echo -e "Done."
		fi
	elif [[ "$YORNAA" = "5" ]]
	then
		if [[ ! -f "/usr/bin/anonsurf" ]]
		then
			echo -e """$RS""Anonsurf is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_anonsurf
			fi
		else
			echo -e "Enabling anonsurf..."
			anonsurf start
			echo -e "Done."
		fi
	elif [[ "$YORNAA" = "d5" ]]
	then
		if [[ ! -f "/usr/bin/anonsurf" ]]
		then
			echo -e """$RS""Anonsurf is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_anonsurf
			fi
		else
			echo -e "Disabling anonsurf..."
			anonsurf stop
			echo -e "Done."
		fi
	elif [[ "$YORNAA" = "6" ]]
	then
		if [[ ! -f "/usr/bin/anonsurf" ]]
		then
			echo -e """$RS""Anonsurf is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_anonsurf
			fi
		else
			echo -e "Status of anonsurf..."
			anonsurf status
			echo -e "Done."
		fi
	elif [[ "$YORNAA" = "d6" ]]
	then
		if [[ ! -f "/usr/bin/anonsurf" ]]
		then
			echo -e """$RS""Anonsurf is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_anonsurf
			fi
		else
			echo -e "Restarting anonsurf..."
			anonsurf change
			echo -e "Done."
		fi
	elif [[ "$YORNAA" = "r6" ]]
	then
		if [[ ! -f "/usr/bin/anonsurf" ]]
		then
			echo -e """$RS""Anonsurf is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_anonsurf
			fi
		else
			echo -e "Restarting anonsurf..."
			anonym8 change
			echo -e "Done."
		fi
	elif [[ "$YORNAA" = "7" ]]
	then
		public_ip
	elif [[ "$YORNAA" = "8" ]]
	then
		interface_selection
		clear
		echo "Your MACs: "
		macchanger -s "$MYINT"
	elif [[ "$YORNAA" = "10" || "$YORNAA" = "11" || "$YORNAA" = "12" ]]
	then
		new_terminal
	elif [[ "$YORNAA" = "13" ]]
	then
		mitm_menu
	elif [[ "$YORNAA" = "14" ]]
	then
		metasploit_menu
	elif [[ "$YORNAA" = "20" ]]
	then
		bruteforce_router
	elif [[ "$YORNAA" = "exit" ]]
	then
		kill -9 $PPID
		exit
	elif [[ "$YORNAA" = "update" ]]
	then
		printf '\033]2;UPDATE\a'
		clear
		update_lscript
	elif [[ "$YORNAA" = "if" || "$YORNAA" = "ifconfig" ]]
	then
		ip addr
	elif [[ "$YORNAA" = "changelog" ]]
	then
		clear
		BACKL=1
		cat "$LPATH"/Changelog | head -n 20
		echo -e "$PAKTC"
		$READAK
		clear
	elif [[ "$YORNAA" = "" ]]
	then
		clear
		exec bash "$0"
	elif [[ "$YORNAA" = "errors" ]]
	then
		errors_menu
	elif [[ "$YORNAA" = "etercheck" ]]
	then
		if [[ -d /root/wifiphisher ]]
		then
			eternalblue_check
		else
			echo -e """$RS""Wifiphisher is not installed.Type '""$CE""""$YS""install""$CE""""$RS""' to install it.""$CE"""
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_wifiphisher
			fi
		fi
	elif [[ "$YORNAA" = "eternalblue" ]]
	then
		if [[ -d /root/wifiphisher ]]
		then
			eternalblue
		else
			echo -e """$RS""Wifiphisher is not installed.Type '""$CE""""$YS""install""$CE""""$RS""' to install it.""$CE"""
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_wifiphisher
			fi
		fi
	elif [[ "$YORNAA" = "$wififb" ]]
	then
		if [[ -d /root/wifiphisher ]]
		then
			wififb_attack
		else
			echo -e """$RS""Wifiphisher is not installed.Type '""$CE""""$YS""install""$CE""""$RS""' to install it.""$CE"""
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_wifiphisher
			fi
		fi
	elif [[ "$YORNAA" = "start" ]]
	then		
		start_menu
#----------
	elif [[ "$YORNAA" = "stop" ]]
	then
		stop_menu
	elif [[ "$YORNAA" = "exit" ]]
	then
		clear
		exit
	fi
####check if it is ks
# shellcheck disable=SC2034 # var1 is used by check_if_ks in shortcuts.sh
var1=1
check_if_ks
####
}


		
#------------------------------------
####################################
defaults_l
printf '\033]2;The LAZY script\a'
if [[ "$ONETIMEPERLAUNCH" != "1" ]]
then
	one_time_per_launch_ks
fi
####################################
if [[ -f "${LPATH}/IAGREE.txt" ]]
then

	if [[ ! -f "${LPATH}/wlan.txt" ]]
	then
		set_interface_number
	fi
	if [[ ! -f "${LPATH}/wlanmon.txt" ]]
	then
		set_interface_number
	fi
	if [[ ! -f "${LPATH}/eth.txt" ]]
	then
		set_interface_number
	fi
	clear
	WLANNM=$(cat "$LPATH"/wlanmon.txt)
	WLANN=$(cat "$LPATH"/wlan.txt)
	ETH=$(cat "$LPATH"/eth.txt)	
#setting iftop's interface
	if [[ -f "$LPATH"/settings/iftopint.txt ]]
	then
		read iftopint < "$LPATH"/settings/iftopint.txt
	else
		iftopint="$WLANN"
	fi
	export iftopint
	export WLANNM
	export WLANN
	export ETH
	managed_spaces
	monitor_spaces
	if [[ ! -f "$LPATH"/latestchangelog.txt ]]
	then
		echo -e "1" > "$LPATH"/latestchangelog.txt
		latest_changelog
	fi		
	banner
	main_options
	if [[ "$BACKL" = "1" ]]
	then
		exec bash "$0"
		
	else
		echo -e "$PAKTGB"
		$READAK
		exec bash "$0"
	fi
else
	terms_of_use
fi
