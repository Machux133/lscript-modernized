#!/bin/bash
# This file is sourced by `l`, not run directly. Enabling/disabling the wireless interface and switching it in and
# out of monitor mode, MAC address changes, first-run interface
# selection, and the small menus around all of that.

function enable_wlan
{
	O4=0
	echo -e "Enabling $WLANN..."
	rfkill unblock wifi &> /dev/null; rfkill unblock all &> /dev/null
	ip link set "$WLANN" up &>/dev/null && echo -e """$YS""Done""$CE""" && O4=1  || echo -e """$RS""Error. I can't find your wireless adapter""$CE"""
}

function disable_wlan
{
	echo -e "Disabling $WLANN..."
	rfkill unblock wifi &> /dev/null; rfkill unblock all &> /dev/null
	ip link set "$WLANN" down &>/dev/null && echo -e """$YS""Done""$CE""" && O4=1 || echo -e """$RS""Error. I can't find your wireless adapter.""$CE"""
}

function interface_selection
{
if [[ "$WLANCHECKING" = "" ]]
then
	echo -e """$RS"" 1""$CE"") $WLANN"
else
	echo -e """$YS"" 1""$CE"") $WLANN"
fi
if [[ "$WLANMCHECKING" = "" ]]
then
	echo -e """$RS"" 2""$CE"") $WLANNM"
else
	echo -e """$YS"" 2""$CE"") $WLANNM"
fi
echo -e """$YS"" 3""$CE"") ""$ETH"""
echo -e """$YS"" b""$CE"") Main menu"
echo -e """$YS"" 0""$CE"") EXIT"
echo -e "Choose: "
read -e MYINT
if [[ "$MYINT" = "2" ]]
then
	if [[ "$WLANMCHECKING" = "" ]]
	then
		MYINT="OFF"
	else
		MYINT="$WLANNM"
	fi
elif [[ "$MYINT" = "1" ]]
then
	if [[ "$WLANCHECKING" = "" ]]
	then
		MYINT="OFF"
	else
		MYINT="$WLANN"
	fi
elif [[ "$MYINT" = "0" ]]
then
	clear
	exit
elif [[ "$MYINT" = "00" || "$MYINT" = "b" ]]
then
	exec bash "$0"
elif [[ "$MYINT" = "3" ]]
then
	MYINT="$ETH"
else
echo -e "Wrong choice..."
sleep 2
clear
echo -e "EXITING"
sleep 1
exec bash "$0"
fi
export MYINT
}

function change_mac
{
	interface_selection
	clear
	if [[ "$MYINT" = "OFF" ]]
	then
		echo -e "Interface not available"
		sleep 2
	else
		echo -e "Change it to a random or specific?(""$YS""r""$CE""/""$YS""s""$CE"")(""$YS""Enter""$CE""=r): "
		read -e RORS
		clear
		if [[ "$RORS" != "s" ]]
		then
			echo -e "Changing mac address of $MYINT to a random one..."
			ip link set "$MYINT" down
			macchanger -r "$MYINT"
			ip link set "$MYINT" up
			echo -e "Done."
		else
			echo -e "Enter the MAC you want:"
			read -e SMAC
			echo -e "Changing mac address of $MYINT to $SMAC..."
			ip link set "$MYINT" down
			macchanger -m "$SMAC" "$MYINT"
			ip link set "$MYINT" up
			echo -e "Done."
		fi
	fi
}

function set_interface_number
{
clear
while true
do
echo -e "Enter the name of your wireless interface when in ""$RS""managed""$CE"" mode(""$YS""Enter""$CE""=wlan0): "
read MANAGED
if [[ "$MANAGED" = "" ]]
then
	MANAGED="wlan0"
fi
echo -e "Enter the name of your wireless interface when in ""$RS""monitor""$CE"" mode(""$YS""Enter""$CE""=wlan0mon): "
read MONITOR
if [[ "$MONITOR" = "" ]]
then
	MONITOR="wlan0mon"
fi
echo -e "Enter the name of your wired interface(""$YS""Enter""$CE""=eth0): "
read WIRED
if [[ "$WIRED" = "" ]]
then
	WIRED="eth0"
fi
	echo "$MANAGED" > "$LPATH"/wlan.txt
	echo "$MONITOR" > "$LPATH"/wlanmon.txt
	echo "$WIRED" > "$LPATH"/eth.txt
	echo -e """$YS""Done""$CE"""
	sleep 1
	clear
	echo -e """$BS""If you want to change it, type ""$CE""""$YS""interface""$CE""""$BS"" any time""$CE"""
	sleep 3
	echo -e "$PAKTC"
	$READAK	
	BACKL="1"
	break
done
}

function checkifalready
{
	GOOD="1"
	num=1
	while [ $num -le 22 ]
	do
		if [[ "$CHECKKS" = "$num" ]]
		then
			GOOD="0"
			echo -e """$RS""This shortcut is already in use by the script.""$CE"""
			sleep 3
		fi
		num=$(( num+1 ))
	done
	if [[ "$GOOD" = "1" ]]
	then
		if [[ "$CHECKKS" = "etercheck" || "$CHECKKS" = "eternalblue" || "$CHECKKS" = "changelog" || "$CHECKKS" = "wififb" || "$CHECKKS" = "nessusstop" || "$CHECKKS" = "nessusstart" || "$CHECKKS" = "pstop" || "$CHECKKS" = "pstart" || "$CHECKKS" = "astop" || "$CHECKKS" = "astart" || "$CHECKKS" = "settings" || "$CHECKKS" = "donate" || "$CHECKKS" = "d" || "$CHECKKS" = "s" || "$CHECKKS" = "g" || "$CHECKKS" = "l" || "$CHECKKS" = "" || "$CHECKKS" = "if" || "$CHECKKS" = "ifconfig" || "$CHECKKS" = "interfaces" || "$CHECKKS" = "interface" || "$CHECKKS" = "errors" || "$CHECKKS" = "00" || "$CHECKKS" = "exit" || "$CHECKKS" = "update" || "$CHECKKS" = "d1" || "$CHECKKS" = "d2" || "$CHECKKS" = "d3" || "$CHECKKS" = "d4" || "$CHECKKS" = "d5" || "$CHECKKS" = "d6" || "$CHECKKS" = "d7" || "$CHECKKS" = "gg" || "$CHECKKS" = "ks" ]]
		then
			GOOD="0"
			echo -e """$RS""This shortcut is already in use by the script.""$CE"""
			sleep 3
		fi
	fi
	if [[ "$CHECKKS" = "delete" ]]
	then
		GOOD="0"
	fi
	#~ if [[ "$CHECKKS" = "b" || "$CHECKKS" = "back" ]]
	#~ then
		#~ GOOD="0"
	#~ fi
	if [[ "$GOOD" = "1" ]]
	then
		BACKUPTITLE="$TITLE"
		BACKUPNN="$nn"
		num=1
		while [[ $num -le "$HOWMANYTOOLS" ]]
		do
		nn="$num"
		listshortcuts
		if [[ -f "${KSPATH}/${TITLE}/${TITLE}ks.txt" ]]
		then
			read KSIFALREADY < "$KSPATH"/"$TITLE"/"$TITLE"ks.txt
			if [[ "$CHECKKS" == "$KSIFALREADY" ]]
			then
				echo -e """$RS""Shortcut '""$CHECKKS""' is already in use by ""$TITLE""""$CE"""
				GOOD=0
				sleep 3
			fi
		fi
		num=$(( num+1 ))
		done
		nn="$BACKUPNN"
		TITLE="$BACKUPTITLE"
	fi
	clear
}	

function interface_menu
{
	WLANN=$(cat "$LPATH"/wlan.txt)
	WLANNM=$(cat "$LPATH"/wlanmon.txt)
	echo -e "Your current wireless interface names are $WLANN and $WLANNM"
	sleep 2
	echo -e "Do you want to change you interface names?""$YNYES"": "
	read INAG
	if [[ "$INAG" = "n" ]]
	then
		clear
		echo -e "Then why did you come here? lol"
		sleep 3
		exec bash "$0"
	else
		clear
		rm "$LPATH"/wlan.txt
		rm "$LPATH"/wlanmon.txt
		set_interface_number
	fi
}

function start_menu
{
	O1=0
	O2=0
	O3=0
	echo -e "Enabling $WLANNM..."
	enable_wlan
	echo -e "Killing services..."
	airmon-ng check kill &> /dev/null && echo -e """$YS""Done""$CE""" && O1=1
	echo -e "Starting monitor mode..."
	if [[ "$ALFA" = "yes" ]]
	then
		ip link set "$WLANN" down
		iw dev "$WLANN" set type monitor &> /dev/null && echo -e """$YS""Done""$CE""" && O2=1
		ip link set "$WLANN" up
	else
		airmon-ng start "$WLANN" | grep "monitor mode" | awk -F "(" '{print $2}' | cut -d ')' -f1 &> /dev/null && echo -e """$YS""Done""$CE""" && O2=1
	fi
	if [[ -f "$LPATH"/settings/startmac.txt ]]
	then
		read STARTMAC < "$LPATH"/settings/startmac.txt
	else
		STARTMAC="$DEFMAC"
	fi
	echo -e "Changing mac address of $WLANNM to ""$STARTMAC""..."
	ip link set "$WLANNM" down
	macchanger -m "$STARTMAC" "$WLANNM" | grep "New MAC:" &> /dev/null && O3=1
	ip link set "$WLANNM" up && echo -e """$YS""Done""$CE""" 
	if [[ "$O1" = 1 && "$O2" = 1 && "$O3" = 1 && "$O4" = 1 ]]
	then
		BACKL=1
	fi
}

function stop_menu
{
	O1=0
	O2=0
	O3=0
	stop_monitor
	echo -e "Changing mac address of $WLANN to the original one..."
	ip link set "$WLANN" down
	macchanger -p "$WLANN" | grep "Current MAC:" && O1=1
	ip link set "$WLANN" up
	echo -e """$YS""Done""$CE"""
	if [[ "$O1" = 1 && "$O2" = 1 && "$O3" = 1 ]]
	then
		BACKL=1
	fi
}

function stop_monitor
{
	echo -e "Disabling $WLANNM..."
	echo -e "Stopping monitor mode..."
	if [[ "$ALFA" = "yes" ]]
	then
		A1=0
		A2=0
		A3=0
		ip link set "$WLANN" down && A1=1
		iw dev "$WLANN" set type managed && A2=1
		ip link set "$WLANN" up && A3=1
		if [[ "$A1" = 1 && "$A2" = 1 && "$A3" = 1 ]]
		then
			echo -e """$YS""Done""$CE""" && O2=1
		else
			echo -e """$RS""Error stoping monitor mode.""$CE"""
		fi
	else
		airmon-ng stop "$WLANNM" &>/dev/null && echo -e """$YS""Done""$CE""" && O2=1 || echo -e """$RS""Error stoping monitor mode.""$CE"""
	fi
	echo -e "Starting network-manager service..."
	service network-manager start && echo -e """$YS""Done""$CE""" && O3=1 || echo -e """$RS""Error starting network-manager service""$CE"""
}

function new_terminal
{
	while true
	do
	clear
	if [[ "$ALFA" = "yes" ]]
	then
		CHECKMON=$(iw dev "$WLANN" info 2>/dev/null | grep "type monitor")
	else
		CHECKMON=$(ip addr | grep "$WLANNM")
	fi
	clear
	if [[ "$CHECKMON" = "" ]]
	then
		echo -e "Monitor mode is not enabled."
		echo -e ""
		echo -e "Do you want to enable monitor mode? ""$YNYES"": "
		read MONITOREN
		clear
		if [[ "$MONITOREN" = "n" ]]
		then
		#~ echo -e "Select 'start' or '2' to enable it"
			echo -e "$PAKTGB"
			$READAK
			clear
			exec bash "$0"
		else
			CHECKWL=$(ip addr | grep "$WLANN")
			if [[ "$CHECKWL" == "" ]]
			then
				echo -e """$RS""""$WLANN"" was not found""$CE"""
				sleep 2
				BACKL=1
				break
			fi
			start_menu
			continue
		fi
	else
		if [[ "$YORNAA" = "10" ]]
		then
			echo -e "Moving into new terminal..."
			sleep 1
			FJC=0
			export FJC
			open_terminal "87x35+9999+0" "handshake-menu"
			sleep 1
			exec bash "$0"
		elif [[ "$YORNAA" = "11" ]]
		then
			clear
			echo -e "Moving into new terminal..."
			sleep 1
			open_terminal "80x25+9999+0" "wps-menu"
			sleep 1
			exec bash "$0"
		elif [[ "$YORNAA" = "12" ]]
		then
			echo -e "Moving into new terminal..."
			sleep 1
			open_terminal "80x25+9999+0" "wep-menu"
			sleep 1
			exec bash "$0"
		fi
	fi
	done
}
