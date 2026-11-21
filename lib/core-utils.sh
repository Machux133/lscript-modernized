#!/bin/bash
# This file is sourced by `l`, not run directly. Generic helpers used throughout the menus: the dashboard/header
# drawing (dash_calc, banner), local-IP/gateway lookups, IP-format
# validation, interface spacing, the one-time changelog display,
# and lscript's own global defaults (defaults_l).

function defaults_l
{
#path for lscript
	LPATH="/root/lscript"
	export LPATH
#path for keyboard shortcuts
	KSPATH="${LPATH}/ks"
	export KSPATH
#making sure the kspath is set
	if [[ ! -d "$KSPATH" ]]
	then
		mkdir "$KSPATH"
	fi
#wififb file
	wififbfile="${LPATH}/wififb.txt"
	wififbfileall="${LPATH}/wififball.txt"
	wififbpassfile="${LPATH}/wififbpasswords.txt"
	wififbpassfileall="${LPATH}/wififbpasswordsall.txt"
	export wififbfile 
	export wififbfileall
	export wififbpassfile
	export wififbpassfileall
#ALFA SUPPORT SETTING
	if [[ -f "$LPATH"/settings/AWUS036ACH.txt ]]
	then
		read ALFA < "$LPATH"/settings/AWUS036ACH.txt
	else
		ALFA="no"
	fi
#yellow start 
	YS="\e[1;33m"
#blue start 
	BS="\e[0;34m"
#color end
	CE="\e[0m"
#red start
	RS="\e[1;31m"
#black start
	BLS="\e[0;30m"
#dark gray start
	DGYS="\e[1;30m"
#light blue start
	LBS="\e[1;34m"
#green start
	GNS="\e[0;32m"
#light green start
	LGNS="\e[1;32m"
#cyan start
	CYS="\e[0;36m"
#light cyan start
	LCYS="\e[1;36m"
#light red start
	DRS="\e[0;31m"
#purple start
	PS="\e[0;35m"
#light purple start
	LPS="\e[1;35m"
#brown start
	BRS="\e[0;33m"
#light gray start
	LGYS="\e[0;37m"
#white start
	WHS="\e[1;37m"
#setting custom color for logo
	if [[ -f "$LPATH"/settings/logocolor.txt ]]
	then
		read COL < "$LPATH"/settings/logocolor.txt
	else
		COL="$RS"
	fi
#tools
toolarray=(
"fluxion" "sniffer" "wifite" "wifiphisher" "morpheus" "osrframework" "hakku" "trity" "cupp" "dracnmap" "fern" "kickthemout" "ghostphisher" "theeye" "xerxes"
"mdk3" "katana" "airgeddon" "4nonimizer" "beelogger" "ezsploit" "pupy" "zirikatu" "wifiautopwner" "bully" "anonsurf" "anonym8" "thefatrat" "angryip" "sniper"
"recondog" "redhawk" "winpayloads" "chaos" "routersploit" "infoga" "nwatch" "eternalscanner" "eaphammer" "dagon" "lalin" "knockmail" "kwetza" "ngrok" "netdiscover"
"websploit" "openvas" "shellter" "geany" "bleachbit" "vmr" "hashbuster" "findsploit" "howdoi" "operative" "netattack2" "koadic" "empire" "meterpreter_paranoid_mode"
"dropit_frmw" "wifi_pumpkin" "veil" "leviathan" "fake_image" "avet" "gloom" "arcanus" "msfpc" "morphhta" "lfi" "unibyav" "demiguise" "dkmc" "sechub" "beef" "mitmf"
"fsociety" "arp_scan" "netool" "sqlmap" "patator" "zeus" "evil_droid" "nosqlmap" "eggshell" "zerodoor" "cromos" "yuki-chan" "socialfish" "autosploit" "blazy"
"striker" "hyprpulse" "instaburst" "instagram-py" "datasploit" "sitebroker" "enigma"
)
#setting frequent stings
	YNYES="(${YS}y${CE}/${YS}n${CE})(${YS}Enter${CE}=yes)"
	YNNO="(${YS}y${CE}/${YS}n${CE})(${YS}Enter${CE}=no)"
	YNONLY="(${YS}y${CE}/${YS}n${CE})"
	PAKTC="Press ${YS}any key$CE to continue..."
	PAKTGB="Press ${YS}any key$CE to go back..."
	TNI="${RS}Tool is not installed. To install it type '${CE}${YS}install${CE}${RS}'.${CE}"
#code to read from keyboard without return
	READAK="read -n 1"
#default MAC when starting monitor
	DEFMAC="00:11:22:33:44:55"
	
	wififb="wififb"
}

function local_ips()
{
	iffile="${LPATH}/iftemp.txt"
	#passing an interface if any
	LF="$1"
	GREPP=$(ip addr)
	if [[ "$LF" = "" ]]
	then
		echo -e """$BS""Local IPs""$CE"": "
		TEST=$(echo "$GREPP" | grep "$ETH:")
		n=0
		if [[ $TEST != "" ]]
		then
			ip addr show "$ETH" > $iffile
			LOCALETH=$(cat $iffile | awk '/inet /{print $2}' | cut -d '/' -f1)
			cho=$(is_it_an_ip "$LOCALETH")
			if [[ "$cho" = 1 ]]
			then
				echo -e """$ETH"" = ""$YS""$LOCALETH""$CE"""
				n=1
			fi
		fi
		TEST=$(echo "$GREPP" | grep "$WLANN:")
		if [[ $TEST != "" ]]
		then
			ip addr show "$WLANN" > $iffile
			LOCALMA=$(cat $iffile | awk '/inet /{print $2}' | cut -d '/' -f1)
			cho=$(is_it_an_ip "$LOCALMA")
			if [[ "$cho" = 1 ]]
			then
				echo -e "$WLANN = ""$YS""$LOCALMA""$CE"""
				n=1
			fi
		fi
		TEST=$(echo "$GREPP" | grep "$WLANNM:")
		if [[ $TEST != "" ]]
		then
			ip addr show "$WLANNM" > $iffile
			LOCALMO=$(cat $iffile | awk '/inet /{print $2}' | cut -d '/' -f1)
			cho=$(is_it_an_ip "$LOCALMO")
			if [[ "$cho" = 1 ]]
			then
				echo -e "$WLANNM = ""$YS""$LOCALMO""$CE"""
				n=1
			fi
		fi
		if [[ "$n" = 0 ]]
		then
			echo -e """$RS""No known interfaces found available""$CE"""
		fi
		echo -e ""
		find_gateways
	else
		TEST=$(echo "$GREPP" | grep "$LF:")
		if [[ $TEST != "" ]]
		then
			ip addr show "$LF" > $iffile
			LOCALM=$(cat $iffile | awk '/inet /{print $2}' | cut -d '/' -f1)
			cho=$(is_it_an_ip "$LOCALM")
			if [[ "$cho" = 1 ]]
			then
				OUTPUT="$LOCALM"
				echo -e "$OUTPUT"
			fi
		fi
	fi
}

function give_ip_take_zero()
{
	#passing an ip
	GI1="$1"
	GI2="$2"
	if [[ "$GI1" = "" ]]
	then
		echo -e """$RS""Error 7. No parameters passed""$CE"""
		sleep 3
	else
		ip1=$(echo -e "$GI1" | cut -d '.' -f1)
		ip2=$(echo -e "$GI1" | cut -d '.' -f2)
		ip3=$(echo -e "$GI1" | cut -d '.' -f3)
		if [[ "$GI2" = "" ]]
		then
			OUTPUT="${ip1}.${ip2}.${ip3}.0"
		else
			OUTPUT="${ip1}.${ip2}.${ip3}."
		fi
			echo "$OUTPUT"
	fi
}

function is_it_an_ip()
{
	IIA=$1
	IIAI=${#IIA}
	if [[ "$IIA" = "" ]]
	then
		echo -e """$RS""Error 9. No parameteres passed""$CE"""
		sleep 2
	else
		if [[ "$IIAI" -le 15 && "$IIAI" -ge 7 ]]
		then
			echo 1
		else
			echo 0
		fi
	fi
}

function latest_changelog
{
	clear
	printf '\033]2;LATEST CHANGELOG\a'
	echo -e """$BS""Wellcome to version $VERSION""$CE"""
	echo -e "What is included in this update: "
	cat "$LPATH"/Changelog | head -n $LATESTCHANGELOGLINES
	echo -e "$PAKTC"
	$READAK
}

function finish 
{
  echo -e """$RS""Hard kill detected..""$CE"""
}

function dash_calc
{
	
	size=${#TERMINALTITLE}
	calc=$(( 65-size ))
	calc=$(( calc/2 ))
	numcalc=1
	DASHESN="-"
	while [ $numcalc != $calc ]
	do
		DASHESN="${DASHESN}-"
		numcalc=$(( numcalc+1 ))
	done
	echo -e "$DASHESN""$RS""$TERMINALTITLE""$CE""$DASHESN"
}

function managed_spaces
{
	size=${#WLANN}
	calc=$(( 11-size ))
	numcalc=1
	SPACESN=" "
	while [ $numcalc != $calc ]
	do
		SPACESN="${SPACESN} "
		numcalc=$(( numcalc+1 ))
	done
}

function monitor_spaces
{
	size=${#WLANNM}
	calc=$(( 11-size ))
	numcalc=1
	SPACESM=" "
	while [ $numcalc != $calc ]
	do
		SPACESM="${SPACESM} "
		numcalc=$(( numcalc+1 ))
	done
}

function check_wlans
{
	WLANCHECKING=$(ip addr | grep "$WLANN" )
	WLANMCHECKING=$(ip addr | grep "$WLANNM" )
}

function banner
{
	check_wlans
	echo -e ""
	echo -e "$COL         ██╗      █████╗ ███████╗██╗   ██╗$CE v$VERSION"
	echo -e "$COL         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝$CE"
	echo -e "$COL         ██║     ███████║  ███╔╝  ╚████╔╝ $CE   by ""$COL""ARIS MELACHROINOS$CE"
	echo -e "$COL         ██║     ██╔══██║ ███╔╝    ╚██╔╝  $CE"
	echo -e "$COL    The  ███████╗██║  ██║███████╗   ██║  script$CE"
	echo -e "$COL         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   $CE"
	echo -e """$YS""if""$CE"") Ifconfig           ""$YS""l""$CE"") Local IPs & gateways ""$RS""|""$CE""  ""$YS""scan""$CE"") Arp-scan network"
	if [[ "$WLANCHECKING" = "" ]]
	then
		echo -e """$RS"" 1""$CE"") Enable ""$RS""$WLANN""$CE""${SPACESN}""$RS""d1""$CE"") Disable ""$RS""$WLANN""$CE""${SPACESN}  ""$RS""|""$CE"" ""$YS""start""$CE"") Start monitor mode"
		echo -e """$RS"" 2""$CE"") Enable ""$RS""$WLANNM""$CE""${SPACESM}""$RS""d2""$CE"") Disable ""$RS""$WLANNM""$CE""${SPACESM}  ""$RS""|""$CE""  ""$YS""stop""$CE"") Stop monitor mode"
	else
		echo -e """$YS"" 1""$CE"") Enable $WLANN${SPACESN}""$YS""d1""$CE"") Disable $WLANN${SPACESN}  ""$RS""|""$CE"" ""$YS""start""$CE"") Start monitor mode"
		echo -e """$YS"" 2""$CE"") Enable $WLANNM${SPACESM}""$YS""d2""$CE"") Disable $WLANNM${SPACESM}  ""$RS""|""$CE""  ""$YS""stop""$CE"") Stop monitor mode"
	fi
	echo -e """$YS"" 3""$CE"") Change MAC        ""$YS""d3""$CE"") Restore original MAC ""$RS""|""$CE""""$YS""update""$CE"") Check for updates"
	if [[ -f /usr/bin/anonym8 ]]
	then
	echo -e """$YS"" 4""$CE"") Enable anonym8    ""$YS""d4""$CE"") Disable anonym8      ""$RS""|""$CE""""$YS""errors""$CE"") Fix some errors"
	else
	echo -e """$RS"" 4""$CE"") Enable anonym8    ""$RS""d4""$CE"") Disable anonym8      ""$RS""|""$CE""""$YS""errors""$CE"") Fix some errors"
	fi
	if [[ -f /usr/bin/anonsurf ]]
	then
	echo -e """$YS"" 5""$CE"") Enable anonsurf   ""$YS""d5""$CE"") Disable anonsurf     ""$RS""|""$CE""    ""$YS""ks""$CE"") Keyboard shortucts"
	echo -e """$YS"" 6""$CE"") Anonsurf's status ""$YS""d6""$CE"") Restart anonsurf     ""$RS""|""$CE""""$YS""     d""$CE"") Buy me a coffee"
	else
	echo -e """$RS"" 5""$CE"") Enable anonsurf   ""$RS""d5""$CE"") Disable anonsurf     ""$RS""|""$CE""    ""$YS""ks""$CE"") Keyboard shortucts"
	echo -e """$RS"" 6""$CE"") Anonsurf's status ""$RS""d6""$CE"") Restart anonsurf     ""$RS""|""$CE""     ""$YS""d""$CE"") Buy me a coffee"
	fi
	echo -e """$YS"" 7""$CE"") View public IP                             ""$RS""|""$CE""     ""$YS""s""$CE"") Go to settings menu"
	echo -e """$YS"" 8""$CE"") View MAC"
	echo -e """$YS"" 9""$CE"") TOOLS             ""$YS""15""$CE"") Spoof EMAIL           ""$YS""22""$CE"") Show bandwidth"
	if [[ -f /root/ngrok ]]
	then
		echo -e """$YS""10""$CE"") Handshake         ""$YS""16""$CE"") Ngrok port forward"
	else
		echo -e """$YS""10""$CE"") Handshake         ""$RS""16""$CE"") ""$RS""Ngrok""$CE"" port forward"
	fi
	if [[ -f /usr/local/bin/howdoi ]]
	then
		echo -e """$YS""11""$CE"") Find WPS pin      ""$YS""17""$CE"") Ask (Howdoi tool)"
	else
		echo -e """$YS""11""$CE"") Find WPS pin      ""$RS""17""$CE"") Ask (""$RS""Howdoi""$CE"" tool)"
	fi
	echo -e """$YS""12""$CE"") WEP menu          ""$YS""18""$CE"") Auto-exploit browser"
	echo -e """$YS""13""$CE"") MITM              ""$YS""19""$CE"") Geolocate an IP"
	echo -e """$YS""14""$CE"") Metasploit        ""$YS""20""$CE"") Bruteforce login"   
	echo -e """$YS"" 0""$CE"") Exit              ""$YS""21""$CE"") Sqlmap automated"
	echo "Choose: "
	read -e YORNAA
	#~ echo "$YORNNA"
	#~ history -s "$YORNNA"
	clear
}

function public_ip
{
	clear
	echo -e """$BS""Please wait...""$CE"""
	CHECKMON=$(ip addr | grep "mon")
	if [[ "$CHECKMON" = "" ]]
	then
		clear
		PUBLICIP=$(curl -s ipinfo.io/ip)
		if [[ "$PUBLICIP" = "" ]]
		then
			PUBLICIP=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
			if [[ "$PUBLICIP" = "" ]]
			then
				clear
				PUBLICIP="Connection error."
			fi
		fi
		echo "Your public IP is: ""$PUBLICIP"""
		#~ curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
	else
		echo -e "When monitor mode is enabled, you don't have internet access."
		echo -e "Select 'd2' to disable monitor mode"
		echo -e "$PAKTGB"
		$READAK
		clear
		exec bash "$0"
	fi
}

function find_gateways()
{
	#example: find_gateways wlan0 interface
	FG1="$1"
	FG2="$2"
	if [[ "$FG1" = "" ]]
	then
		echo -e """$BS""Gateways""$CE"": "
		n=0
		ethr=$(ip addr | grep "$ETH")
		if [[ "$ethr" != "" ]]
		then
			ethd=$(route -n | awk -v int1="$ETH" '{if(int1~$8 && $2!="IP" && $2!="0.0.0.0"){print $2}}')
			chi=$(is_it_an_ip "$ethd")
			if [[ "$ethd" != "" && "$chi" = 1 ]]
			then
				echo -e """$ETH"" = ""$YS""""$ethd""""$CE"""
				n=1
			fi
		fi
		wlanr=$(ip addr | grep "$WLANN")
		if [[ "$wlanr" != "" ]]
		then
			wland=$(route -n | awk -v int1="$WLANN" '{if(int1~$8 && $2!="IP" && $2!="0.0.0.0"){print $2}}')
			chi=$(is_it_an_ip "$wland")
			if [[ "$wland" != "" && "$chi" = 1 ]]
			then
				echo -e """$WLANN"" = ""$YS""""$wland""""$CE"""
				n=1
			fi
		fi
		wlanmr=$(ip addr | grep "$WLANNM")
		if [[ "$wlanmr" != "" ]]
		then
			wlanmd=$(route -n | awk -v int1="$WLANNM" '{if(int1~$8 && $2!="IP" && $2!="0.0.0.0"){print $2}}')
			chi=$(is_it_an_ip "$wlanmd")
			if [[ "$wlanmd" != "" && "$chi" = 1 ]]
			then
				echo -e """$WLANNM"" = ""$YS""""$wlanmd""""$CE"""
				n=1
			fi
		fi
		if [[ "$n" = 0 ]]
		then
			echo -e """$RS""No known interfaces found available""$CE"""
		fi
	else
		if [[ "$FG2" = "interface" ]]
		then
			inttos=$(ip addr | grep "$FG1")
			if [[ "$inttos" != "" ]]
			then
				gate=$(route -n | awk -v int1="$FG1" '{if(int1~$8 && $2!="IP" && $2!="0.0.0.0"){print $2}}')
				cho=$(is_it_an_ip "$gate")
				if [[ "$cho" = 1 ]]
				then
					echo "$gate"
				fi
			else
				echo 0
			fi
		#~ elif [[ "$FG2" = "ip" ]]
		#~ then
			#~ iptos=$(ip addr | grep "$FG1")
			#~ if [[ "$iptos" != "" ]]
			#~ then
				#~ dot=$(give_ip_take_zero "$FG1" "dot")
				#~ gate=$(route -n | awk -v int1="$dot" '{if(int1~$8 && $2!="IP" && $2!="0.0.0.0"){print $2}}')
				#~ echo "$gate"
				#~ cho=$(is_it_an_ip "$gate")
				#~ if [[ "$cho" = 1 ]]
				#~ then
					#~ echo "$gate"
				#~ fi
			#~ else
				#~ echo 0
			#~ fi
		#~ else
			#~ echo -e ""$RS"Could not identify 2nd parameter"$CE""
			#~ sleep 4
		fi		
	fi
}

function select_interface
{
	while true
	do
		clear
		TERMINALTITLE="Select interface"
		dash_calc
		printf '\033]2;SELECT INTERFACE\a'
		TT=$(ip addr | grep "$WLANN:")
		if [[ "$TT" != "" ]]
		then
			echo -e """$YS"" 1""$CE"") ""$WLANN"""
		else
			echo -e """$RS"" 1""$CE"") ""$RS""""$WLANN""""$CE"""
		fi
		TT=$(ip addr | grep "$ETH:")
		if [[ "$TT" != "" ]]
		then
			echo -e """$YS"" 2""$CE"") ""$ETH"""
		else
			echo -e """$RS"" 2""$CE"") ""$RS""""$ETH""""$CE"""
		fi
		echo -e """$YS"" 3""$CE"") Manually type an interface"
		echo -e """$YS"" b""$CE"") Go back"
		echo -e "Choose: "
		read CI
		if [[ "$CI" = 1 ]]
		then
			TT=$(ip addr | grep "$WLANN:")
			if [[ "$TT" != "" ]]
			then
				SINT="$WLANN"
				OUTPUT="$SINT"
				inter=0
				break
			else
				inter=1
				OUTPUT=0
				echo -e """$RS""Could not find this interface""$CE"""
				sleep 2
				continue
			fi
		elif [[ "$CI" = 2 ]]
		then
			TT=$(ip addr | grep "$ETH:")
			if [[ "$TT" != "" ]]
			then
				SINT="$ETH"
				OUTPUT="$SINT"
				inter=0
				break
			else
				inter=1
				OUTPUT=0
				echo -e """$RS""Could not find this interface""$CE"""
				sleep 2
				continue
			fi
		elif [[ "$CI" = 3 ]]
		then
			echo -e "Interface to use: "
			read ITU
			TT=$(ip addr | grep "$ITU:")
			if [[ "$TT" != "" ]]
			then
				SINT="$ITU"
				OUTPUT="$SINT"
				inter=0
				break
			else
				echo -e """$RS""Could not find this interface""$CE"""
				echo -e "Do you still want to use it?""$YNNO"": "
				read SU
				if [[ "$SU" = "y" ]]
				then
					SINT="$ITU"
					OUTPUT="$SINT"
					inter=0
					break
				else
					OUTPUT=0
					continue
				fi
			fi
		elif [[ "$CI" = "b" ]]
		then
			clear
			break
		fi
	done
}

function geolocate_ip()
{
	locbool=1
	echo -e """$BS""Please wait...""$CE"""
	A1="$1"
	AA1=$(is_it_an_ip "$A1")
	if [[ "$AA1" = 1 ]]
	then
		country=$(curl ipinfo.io/"$A1"/country 2>/dev/null)
		if [[ "$country" = "" ]]
		then
			country="${RS}Not found${CE}"
		fi
		loc=$(curl ipinfo.io/"$A1"/loc 2>/dev/null)
		if [[ "$loc" = "" ]]
		then
			locbool=0
			loc="${RS}Not found${CE}"
		fi
		city=$(curl ipinfo.io/"$A1"/city 2>/dev/null)
		if [[ "$city" = "" ]]
		then
			city="${RS}Not found${CE}"
		fi
		org=$(curl ipinfo.io/"$A1"/org 2>/dev/null)
		if [[ "$org" = "" ]]
		then
			org="${RS}Not found${CE}"
		fi
		postal=$(curl ipinfo.io/"$A1"/postal 2>/dev/null)
		if [[ "$postal" = "" ]]
		then
			postal="${RS}Not found${CE}"
		fi
		region=$(curl ipinfo.io/"$A1"/region 2>/dev/null)
		if [[ "$region" = "" ]]
		then
			region="${RS}Not found${CE}"
		fi
		hostname=$(curl ipinfo.io/"$A1"/hostname 2>/dev/null)
		if [[ "$hostname" = "" ]]
		then
			hostname="${RS}Not found${CE}"
		fi
		echo -e "     Country: $country"
		echo -e "      Region: $region"
		echo -e "    Location: $loc"
		echo -e "        City: $city"
		echo -e "      Postal: $postal"
		echo -e "    Hostname: $hostname"
		echo -e "Organization: $org"
		if [[ "$locbool" = 0 ]]
		then
			echo -e """$RS"" m""$CE"") Open google maps location"
		else
			echo -e """$YS"" m""$CE"") Open google maps location"
		fi
		echo -e """$YS"" *""$CE"") Go back"
		echo -e "Choose: "
		read ge
		if [[ "$ge" = "m" ]]
		then
			if [[ "$locbool" = 0 ]]
			then
				echo -e """$RS""Location was not found""$CE"""
				sleep 3
			else
				gio open https://www.google.gr/maps/search/"$loc"/
			fi
		else
			clear
			BACKL=1
		fi
	else
		echo 0
	fi
}

function ip_scan()
{
	
while true
do
	#passing interface
	IPF=$1
	#passing mode if any  (1=choosable   2=only rescanable)
	#Mode 1 is for choosing and returning the IP.
	#Mode 2 is for echoing the scan, not choosing.
	MODE=$2
	export IPF
	if [[ "$IPF" = "" ]]
	then
		echo -e """$RS""Error 6. No parameters passed""$CE"""
		sleep 3
		break
	fi
	#getting local ip
	LLL=$(local_ips "$IPF")
	#getting zero ip
	ZERO=$(give_ip_take_zero "$LLL")
	export ZERO
	echo -e """$BS""Scanning, please wait...""$CE"""
	tempfile="/root/lscript/tempscan.txt"
	xterm -geometry 1x1+9999+999999 -e bash -c "arp-scan -I ""$IPF"" ""$ZERO""/24 | tee $tempfile"
	#gnome-terminal -- arp-scan -I "$IPF" "$ZERO"/24 | tee $tempfile
	clear
	######
	T1=$(cat $tempfile | grep "Ending arp-scan")
	if [[ "$T1" = "" ]]
	then
		lines=$(cat $tempfile | awk 'END{print NR}')
		hosts=$((lines-3))
	else
		lines=$(cat $tempfile | awk 'END{print NR}')
		hosts=$((lines-5))
	fi
	hostsbackup="$hosts"
		if [[ "$hosts" -le 0 ]]
		then
			echo -e """$RS""No hosts found""$CE"""
			sleep 1
		else
			echo -e """$BS""Host(s) found:""$CE"""
			##########
			n=1
			n2=2
			while [[ "$n" -le "$hosts" ]]
			do
				#Hosts start from line 3
				n1=$((n2+n))
				host[$n]=$(cat "$tempfile" | awk -v an1="$n1" '{if(NR==an1 && $0 !~ /DUP:/){print $1}}')
				if [[ "${host[$n]}" = "" ]]
				then
					#sometimes there are duplicate IPs.This should remove them.
					n2=$((n2+1))
					hosts=$((hosts-1))
					#~ n=$((n+1))
					continue
				fi
				size=${#host[$n]}
				sized=$((20-size))
				SPACESN=" "
				numcalc=1
				while [ $numcalc != $sized ]
				do
					SPACESN="${SPACESN} "
					numcalc=$(( numcalc+1 ))
				done
				mi[$n]=$(cat "$tempfile" | awk -v an1="$n1" '{if(NR==an1){print $2}}')
				im[$n]=$(cat "$tempfile" | awk -v an1="$n1" '{if(NR==an1){print $3}}')
				if [[ "$MODE" = 1 ]]
				then
					echo -e """$YS"" $n""$CE"") ""${host[$n]}""${SPACESN}""${mi[$n]}""       ""${im[$n]}"""
				else
					echo -e """${host[$n]}""${SPACESN}""${mi[$n]}""       ""${im[$n]}"""
				fi
				n=$((n+1))
			done
			if [[ "$MODE" = 1 ]]
			then
				echo -e """$YS"" r""$CE"") Rescan"
				echo -e """$YS"" b""$CE"") Go back"
				echo -e "Choose: "
				read sch
				if [[ "$sch" = "b" ]]
				then
					echo ""
				elif [[ "$sch" = "r" ]]
				then
					clear
					continue
				elif [[ "$sch" -le "$hosts" && "$sch" -ge 1 ]]
				then
					OUTPUT="${host[$sch]}"
					export OUTPUT
					#~ echo "$OUTPUT"
				fi
			else
				echo -e """$YS"" e""$CE"") Check eternalblue exploit on IPs"
				echo -e """$YS"" r""$CE"") Rescan"
				echo -e "Press ""$YS""any other key""$CE"" to go back"
				read -n 1 ko
				if [[ "$ko" = "r" ]]
				then
					clear
					continue
				elif [[ "$ko" = "e" ]]
				then
					n=1
					totalhosts=""
					while [[ "$n" -le "$hostsbackup" ]]
					do
						totalhosts="${totalhosts} ${host[${n}]}"
						n=$((n+1))
					done
					clear
					if [[ "$totalhosts" = "" || "$totalhosts" = " " ]]
					then
						echo -e """$RS""No hosts found to check""$CE"""
						sleep 2
						continue
					fi
					echo -e """$BS""RHOSTS""$CE"" <- ""$totalhosts"""
					sleep 2
					if [[ ! -d "$LPATH"/rce ]]
					then
						mkdir	"$LPATH"/rce
					fi
					echo "use auxiliary/scanner/smb/smb_ms17_010" > "$LPATH"/rce/eternalbluerc.rc
					echo "set RHOSTS ""$totalhosts""" >> "$LPATH"/rce/eternalbluerc.rc
					echo "exploit" >> "$LPATH"/rce/eternalbluerc.rc
					echo -e """$BS""Launching msfconsole. Please wait...""$CE"""
					msfconsole -r "$LPATH"/rce/eternalbluerc.rc
				else
					BACKL=1
					break
				fi
			fi
			##########
		fi
		break
	#~ fi
	######
done

}
