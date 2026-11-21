#!/bin/bash
# This file is sourced by `l`, not run directly. The keyboard-shortcuts system (`ks`): creating/listing/managing
# shortcuts to launch any tool with a custom key.

function createshortcut
{
if [[ ! -d "${KSPATH}/$TITLE" ]]
then
	mkdir "$KSPATH"/"$TITLE"
fi
clear
echo -e "Enter the keyboard shortcut that will open ""$TITLE"" from lscript's main menu"
echo -e "(e.g: ""$YS""""$TITLE""""$CE"")"
echo -e "To delete it , type:   ""$YS""delete""$CE"""
echo -e """$YS"" b""$CE"") Go back"
read CHECKKS
if [[ "$CHECKKS" = "back" || "$CHECKKS" = "b" ]]
then
	clear
	BACKKS=1
	return
else
	BACKKS=0
	if [[ "$BACKKS" == 0 ]]
	then
		CHECKKSBACKUP="$CHECKKS"
		NAMECDBACKUP="$NAMECD"
		KSSETBACKUP="$KSSET"
		checkifalready
		CHECKKS="$CHECKKSBACKUP"
		NAMECD="$NAMECDBACKUP"
		KSSET="$KSSETBACKUP"
		if [[ "$GOOD" = "1" ]]
		then
			echo -e "Shortcut is ok.Setting it up..."
			sleep 1
			echo "$CHECKKS" > "$KSPATH"/"$TITLE"/"$TITLE"ks.txt
			echo "$NAMECD" > "$KSPATH"/"$TITLE"/"$TITLE".txt
			echo "$KSSET" > "$KSPATH"/"$TITLE"/"$TITLE"2.txt
			echo -e "Done!"
			echo -e "$PAKTGB"
			$READAK
			clear
			#break
		else
			clear
			echo -e "Removing shortcut for ""$TITLE""..."
			rm -r "${KSPATH:?}"/"$TITLE"
			sleep 1
			echo -e "Done."
			echo -e "$PAKTGB"
			$READAK
			clear
			#break
		fi
	else
		return
	fi
fi
}

function listshortcuts
{
	if [[ "$nn" = "1" ]]
	then
		TITLE="Fluxion"
		NAMECD="cd /root/fluxion"
		KSSET="./fluxion*"
	elif [[ "$nn" = "2" ]]
	then
		TITLE="Zirikatu"
		NAMECD="cd /root/zirikatu"
		KSSET="./zirikatu.sh"
	elif [[ "$nn" = "3" ]]
	then
		TITLE="Wifite"
		NAMECD=""
		KSSET="wifite"
	elif [[ "$nn" = "4" ]]
	then
		TITLE="Wifiphisher"
		NAMECD=""
		KSSET="wifiphisher"
	elif [[ "$nn" = "5" ]]
	then
		TITLE="Zatacker"
		NAMECD="cd /root/Zatacker"
		KSSET="./ZT.sh"
	elif [[ "$nn" = "6" ]]
	then
		TITLE="Morpheus"
		NAMECD="cd /root/morpheus"
		KSSET="./morpheus.sh"
	elif [[ "$nn" = "7" ]]
	then
		TITLE="Hakku"
		NAMECD="cd /root/hakkuframework"
		KSSET="./hakku"
	elif [[ "$nn" = "8" ]]
	then
		TITLE="Trity"
		NAMECD=""
		KSSET="trity"
	elif [[ "$nn" = "9" ]]
	then
		TITLE="Cupp"
		NAMECD="cd /root/cupp"
		KSSET="python cupp.py -i"
	elif [[ "$nn" = "10" ]]
	then
		TITLE="Dracnmap"
		NAMECD="cd /root/Dracnmap"
		KSSET="./dracnmap-v*.sh"
	elif [[ "$nn" = "11" ]]
	then
		TITLE="Fern"
		NAMECD=""
		KSSET="fern-wifi-cracker"
	elif [[ "$nn" = "12" ]]
	then
		TITLE="KickThemOut"
		NAMECD="cd /root/kickthemout"
		KSSET="python kickthemout.py"
	elif [[ "$nn" = "13" ]]
	then
		TITLE="Ghost-Phisher"
		NAMECD=""
		KSSET="ghost-phisher"
	elif [[ "$nn" = "14" ]]
	then
		TITLE="Xerxes"
		NAMECD="cd /root/xerxes"
		KSSET="./xerxes"
	elif [[ "$nn" = "15" ]]
	then
		TITLE="Katana"
		NAMECD=""
		KSSET="ktf.console"
	elif [[ "$nn" = "16" ]]
	then
		TITLE="Airgeddon"
		NAMECD="cd /root/airgeddon"
		KSSET="./airgeddon.sh"
	elif [[ "$nn" = "17" ]]
	then
		TITLE="Websploit"
		NAMECD=""
		KSSET="websploit"
	elif [[ "$nn" = "18" ]]
	then
		TITLE="BeeLogger"
		NAMECD="cd /root/BeeLogger"
		KSSET="python bee.py"
	elif [[ "$nn" = "19" ]]
	then
		TITLE="Ezsploit"
		NAMECD="cd /root/exsploit"
		KSSET="./ezsploit.sh"
	elif [[ "$nn" = "20" ]]
	then
		TITLE="Pupy"
		NAMECD="cd /root/pupy/pupy"
		KSSET="./pupysh.py"
	elif [[ "$nn" = "21" ]]
	then
		TITLE="TheFatRat"
		NAMECD="cd /root/TheFatRat"
		KSSET="./fatrat"
	elif [[ "$nn" = "22" ]]
	then
		TITLE="Angry_IP_Scanner"
		NAMECD=" "
		KSSET="ipscan"
	#~ elif [[ "$nn" = "23" ]]
	#~ then
		#~ TITLE="Sniper"
		#~ NAMECD='read -p 'DOMAIN:' DOMAIN'
		#~ KSSET="sniper $DOMAIN"
	elif [[ "$nn" = "23" ]]
	then
		TITLE="ReconDog"
		NAMECD="cd /root/ReconDog"
		KSSET="python dog.py"
	elif [[ "$nn" = "24" ]]
	then
		TITLE="RED_HAWK"
		NAMECD="cd /root/RED_HAWK"
		KSSET="php rhawk.php"
	elif [[ "$nn" = "25" ]]
	then
		TITLE="Winpayloads"
		NAMECD="cd /root/Winpayloads"
		KSSET="./WinPayloads.py"
	elif [[ "$nn" = "26" ]]
	then
		TITLE="CHAOS"
		NAMECD="cd /root/CHAOS"
		KSSET="go run CHAOS.go"
	elif [[ "$nn" = "27" ]]
	then
		TITLE="Routersploit"
		NAMECD="cd /root/routersploit"
		KSSET="./rsf.py"
	elif [[ "$nn" = "28" ]]
	then
		TITLE="nWatch"
		NAMECD="cd /root/nWatch"
		KSSET="python nwatch.py"
	elif [[ "$nn" = "29" ]]
	then
		TITLE="Eternal_scanner"
		NAMECD="cd /root/eternal_scanner"
		KSSET="./escan"
	elif [[ "$nn" = "30" ]]
	then
		TITLE="LALIN"
		NAMECD="cd /root/LALIN"
		KSSET="./Lalin.sh"
	elif [[ "$nn" = "31" ]]
	then
		TITLE="Shellter"
		NAMECD=""
		KSSET="shellter"
	elif [[ "$nn" = "32" ]]
	then
		TITLE="Netattack2"
		NAMECD="cd /root/netattack2"
		KSSET="python2 netattack2.py"
	elif [[ "$nn" = "33" ]]
	then
		TITLE="Operative-framework"
		NAMECD="cd /root/operative-framework"
		KSSET="python operative.py"
	elif [[ "$nn" = "34" ]]
	then
		TITLE="Koadic"
		NAMECD="cd /root/koadic"
		KSSET="./koadic"
	elif [[ "$nn" = "35" ]]
	then
		TITLE="Empire"
		NAMECD="cd /root/Empire"
		KSSET="./empire"
	elif [[ "$nn" = "36" ]]
	then
		TITLE="Meterpreter_Paranoid_Mode"
		NAMECD="cd /root/Meterpreter_Paranoid_Mode-SSL"
		KSSET="./Meterpreter_Paranoid_Mode.sh"
	elif [[ "$nn" = "37" ]]
	then
		TITLE="Wifi-Pumpkin"
		NAMECD=""
		KSSET="wifi-pumpkin"
	elif [[ "$nn" = "38" ]]
	then
		TITLE="Veil"
		NAMECD="cd /root/Veil"
		KSSET="./Veil.py"
	elif [[ "$nn" = "39" ]]
	then
		TITLE="Leviathan"
		NAMECD="cd /root/leviathan"
		KSSET="python leviathan.py"
	elif [[ "$nn" = "40" ]]
	then
		TITLE="Gloom-Framework"
		NAMECD="cd /root/Gloom-Framework"
		KSSET="python gloom.py"
	elif [[ "$nn" = "41" ]]
	then
		TITLE="Arcanus"
		NAMECD="cd /root/ARCANUS"
		KSSET="./ARCANUS"
	elif [[ "$nn" = "42" ]]
	then
		TITLE="LFISuite"
		NAMECD="cd /root/LFISuite"
		KSSET="python lfisuite.py"
	elif [[ "$nn" = "43" ]]
	then
		TITLE="DKMC"
		NAMECD="cd /root/DKMC"
		KSSET="python dkmc.py"
	elif [[ "$nn" = "44" ]]
	then
		TITLE="SecHub"
		NAMECD=""
		KSSET="sechub"
	elif [[ "$nn" = "45" ]]
	then
		TITLE="Beef-xss"
		NAMECD="cd /usr/share/beef-xss"
		KSSET="./beef"
	elif [[ "$nn" = "46" ]]
	then
		TITLE="Evil-Droid"
		NAMECD="cd /root/Evil-Droid"
		KSSET="./evil-droid"
	elif [[ "$nn" = "47" ]]
	then
		TITLE="NoSQLMap"
		NAMECD="cd /root/NoSQLMap"
		KSSET="python nosqlmap.py"
	elif [[ "$nn" = "48" ]]
	then
		TITLE="EggShell"
		NAMECD="cd /root/EggShell"
		KSSET="python eggshell.py"
	elif [[ "$nn" = "49" ]]
	then
		TITLE="Zerodoor"
		NAMECD="cd /root/Zerodoor"
		KSSET="python zerodoor.py"
	elif [[ "$nn" = "50" ]]
	then
		TITLE="AutoSploit"
		NAMECD="cd /root/AutoSploit"
		KSSET="python autosploit.py"
	elif [[ "$nn" = "51" ]]
	then
		TITLE="Enigma"
		NAMECD="cd /root/Enigma"
		KSSET="python enigma.py"
	elif [[ "$nn" = "52" ]]
	then
		TITLE="SocialFish"
		NAMECD="cd /root/SocialFish"
		KSSET="python SocialFish.py"
	elif [[ "$nn" = "53" ]]
	then
		TITLE="Yuki-Chan-The-Auto-Pentest"
		NAMECD="cd /root/Yuki-Chan-The-Auto-Pentest"
		KSSET="./yuki.sh"
	fi
}

function keyboard_shortcuts
{
if [[ ! -d "${KSPATH}" ]]
then
	mkdir "$KSPATH"
fi
while true
do
TERMINALTITLE="KEYBOARD SHORTCUTS"
dash_calc
printf '\033]2;KEYBOARD SHORTCUTS\a'
echo -e """$YS"" 1""$CE"") Tools"
echo -e """$YS"" 2""$CE"") See hidden shortcuts"
echo -e """$YS"" b""$CE"") Go back"
#~ echo -e ""$YS"00"$CE") Main menu"
echo -e """$YS"" 0""$CE"") EXIT"
read KS
clear
if [[ "$KS" = "1" ]]
then
	while true
	do
		echo -e "Available shortcuts:                        ""$YS""reset""$CE"") Delete all shortcuts"
		nn=1
		#start sorting out all the available shortcuts
		HOWADD=$(( HOWMANYTOOLS + 1 )) 
		while [ "$nn" != "$HOWADD" ]
		do
		listshortcuts
		#adding a space where needed on the output,so it will be sorted correctly
		if [[ "$nn" -lt "10" ]]
		then
			n=" $nn"
		else
			n="$nn"
		fi
		if [[ ! -f "${KSPATH}/${TITLE}/${TITLE}.txt" ]]
		then
			echo -e """$YS""""$n""""$CE"") ""$TITLE"""
		else
			read KSKS < "$KSPATH"/"$TITLE"/"$TITLE"ks.txt
			if [[ "$KSKS" = "" ]]
			then
				KSKS="ERROR(fix=recreate the shortcut)"
			else
				size=${#TITLE}
				calc=$(( 35-size ))
				numcalc=1
				SPACES=""
				while [ $numcalc != $calc ]
				do
					SPACES="${SPACES}_"
					numcalc=$(( numcalc+1 ))
				done
				#~ read SPACES < "$KSPATH"/spaces.txt
				echo -e "${YS}${n}${CE}) ${TITLE}${SPACES}${KSKS}"
			fi
		fi
		nn=$(( nn+1 ))
		done
		echo -e """$YS"" b""$CE"") Go back"
		#echo -e ""$YS" 0"$CE") EXIT"
		echo -e "Choose: "
		#nn=""
		read nn
		clear
		listshortcuts
		if [[ "$nn" = "" ]]
		then
			continue
		fi
		if [[ "$nn" = "back" || "$nn" = "b" ]]
		then
			clear
			break
		elif [[ "$nn" = "0" ]]
		then
			clear
			exit
		elif [[ "$nn" = "00" ]]
		then
			exec bash "$0"
		elif [[ "$nn" = "reset" ]]
		then
			rm -r "${KSPATH:?}"/*
		elif [[ "$nn" -le "$HOWMANYTOOLS" ]]
		then
			createshortcut
		fi
		done
	elif [[ "$KS" = "2" ]]
	then
		hidden_shortcuts
	elif [[ "$KS" = "back" || "$KS" = "b" ]]
	then
		BACKL="1"
		clear
		break
	elif [[ "$KS" = "0" ]]
	then
		clear
		exit
	elif [[ "$KS" = "00" ]]
	then
		exec bash "$0"
	fi
done
}

function hidden_shortcuts
{
	clear
	TERMINALTITLE="HIDDEN SHORTCUTS"
	dash_calc
	printf '\033]2;HIDDEN SHORTCUTS\a'
	echo -e """$YS""  interface""$CE"") Change your interface"
	echo -e """$YS""     wififb""$CE"") Create open wifi access point and get fb passwords with wifiphisher"
	echo -e """$YS""eternalblue""$CE"") Launch msfconsole with eternalblue exploit on target"
	echo -e """$YS""  etercheck""$CE"") Check if a target is vulnerable to eternalblue exploit"
	echo -e """$YS""  changelog""$CE"") View the changelog of the lscript versions"
	echo -e """$YS""     pstart""$CE"") Service postgresql start"
	echo -e """$YS""      pstop""$CE"") Service postgresql stop"
	echo -e """$YS""     nstart""$CE"") Service network-manager start"
	echo -e """$YS""      nstop""$CE"") Service network-manager stop"
	echo -e """$YS""     astart""$CE"") Service apache2 start"
	echo -e """$YS""      astop""$CE"") Service apache2 stop"
	echo -e """$YS""nessusstart""$CE"") Start Nessus"
	echo -e """$YS"" nessusstop""$CE"") Stop Nessus"
	echo -e "$PAKTGB"
	$READAK
	clear
}

function one_time_per_launch_ks
{
	if [[ -d "${KSPATH}/nums" ]]
	then
		rm -r "${KSPATH:?}"/nums
	fi
	mkdir "$KSPATH"/nums
	nn=1
	ff=1
	HOWMANY=0
	HOWADD=$(( HOWMANYTOOLS + 1 )) 
	while [[ "$nn" != "$HOWADD" ]]
	do
		listshortcuts
		if [[ -f "${KSPATH}/${TITLE}/${TITLE}ks.txt" ]]
		then
				echo -e "$TITLE" > "$KSPATH"/nums/"$ff".txt
				ff=$(( ff+1 ))
				HOWMANY=$(( HOWMANY+1 ))		
		fi
		nn=$(( nn+1 ))

	done
	ONETIMEPERLAUNCH="1"
}

function check_if_ks
{
	while [ $var1 -le "$HOWMANY" ]
	do
		if [[ -f "$KSPATH"/nums/"$var1".txt ]]
		then
			read TITLE < "$KSPATH"/nums/"$var1".txt
			read YORNAKS < "$KSPATH"/"$TITLE"/"$TITLE"ks.txt
			if [[ "$YORNAA" = "$YORNAKS" ]]
			then
				read COMMAND1 < "${KSPATH}/${TITLE}/${TITLE}.txt"
				read COMMAND2 < "${KSPATH}/${TITLE}/${TITLE}2.txt"
				$COMMAND1
				#~ if [[ -f ""$KSPATH"/"$TITLE"/"$TITLE"3.txt" ]]
				#~ then
					#~ read $COMMAND3 < ""$KSPATH"/"$TITLE"/"$TITLE"3.txt"
					#~ $COMMAND3
				#~ fi
				$COMMAND2
				BACKL="1"
			fi
		fi
		var1=$(( var1+1 ))
	done
}
