#!/bin/bash
# This file is sourced by `l`, not run directly. It holds every
# install_<tool> function (the "Reinstall/install a tool" menu) plus
# install_default, the shared git-clone helper most of them call.
#----------------TOOLS---------------
	function install_default
	{
		if [[ "$foldname" == "" ]]
		then
			testgit=$(echo "$gitlink" | grep ".git")
			if [[ "$testgit" == "" ]]
			then
				foldname=$(echo "$gitlink" | cut -d '/' -f5)
			else
				foldname=$(echo "$gitlink" | cut -d '/' -f2 | cut -d '.' -f1)
			fi
		fi
		if [[ -d "/root/${foldname}" ]]
		then
			if [[ "$NOCONFIRM" == 1 ]]
			then
					if [[ "$foldname" != "" ]]
					then
						echo -e """$YS""Removing: ""$foldname""""$CE"""
						rm -r /root/"$foldname"
						cd || exit
						git clone "$gitlink"	
						cd "$foldname" || exit
						return 1
					fi
			else
				echo -e """$YS""Removing old and install again?""$CE"" (""$YS""y""$CE""/""$YS""n""$CE"")"
				read ROIN
				if [[ "$ROIN" == "y" ]]
				then
					if [[ "$foldname" != "" ]]
					then
						echo -e """$YS""Removing: ""$foldname""""$CE"""
						rm -r /root/"$foldname"
						cd || exit
						git clone "$gitlink"	
						cd "$foldname" || exit
						return 1
					fi
				else
					return 0
				fi
			fi
		else 
			cd || exit
			git clone "$gitlink"	
			cd "$foldname" || exit
			return 1
		fi
	}
	function install_fluxion
	{
		foldname="fluxion"
		gitlink="--recursive  https://github.com/FluxionNetwork/fluxion.git"
		install_default
		#~ wget https://fluxion.tk/fluxion-unstable.zip
		#~ apt-get install -y unzip
		#~ clear
		#~ unzip /root/fluxion*.zip -d /root
		#~ cd /root/fluxion/install
		#~ chmod +x install.sh
		#~ ./install.sh	
	}
	function install_wifite
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			#confirmed via `dnf repoquery`: no "wifite" package or
			#virtual provide exists on Fedora. wifite2's own README
			#installs system-wide via setup.py, placing the `wifite`
			#executable on PATH (at /usr/sbin/wifite) - matching what
			#the rest of this script expects to just run.
			foldname="wifite2"
			gitlink="https://github.com/derv82/wifite2.git"
			install_default
			cloned=$?
			if [[ "$cloned" == 1 ]]
			then
				python3 setup.py install
			fi
		else
			pkg_install wifite
		fi
	}
	function install_wifiphisher
	{
		foldname="wifiphisher"
		gitlink="https://github.com/wifiphisher/wifiphisher.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			sudo python setup.py install
		fi
	}
	function install_zatacker
	{
		echo -e "I cannot install Zatacker. Please google how to do that yourself."
		echo -e "$PAKTGB"
		read
	}
	function install_morpheus
	{
		foldname="morpheus"
		gitlink="https://github.com/r00t-3xp10it/morpheus.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x morpheus.sh
		fi
	}
	function install_osrframework
	{
		pip install osrframework
	}
	function install_hakku
	{
		foldname="hakkuframework"
		gitlink="https://github.com/4shadoww/hakkuframework.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x hakku
			chmod +x install
		fi
	}
	function install_trity
	{
		foldname="Trity"
		gitlink="https://github.com/toxic-ig/Trity.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			sudo python install.py	
		fi
	}
	function install_cupp
	{
		foldname="cupp"
		gitlink="https://github.com/Mebus/cupp.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x cupp.py
		fi
	}
	function install_dracnmap
	{
		foldname="Dracnmap"
		gitlink="https://github.com/Screetsec/Dracnmap.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x Dracnmap.sh
		fi
	}
	function install_fern
	{
		if [[ -d "/root/Fern-Wifi-Cracker" ]]
		then
			echo -e "Removing old..."
			echo -e "$PAKTC"
			$READAK
			rm -r /root/Fern-Wifi-Cracker
		fi		
		echo -e "Installing Fern"
		echo -e "Tool by Savio-code"
		sleep 1
		cd || exit 
		svn checkout http://github.com/savio-code/fern-wifi-cracker/trunk/Fern-Wifi-Cracker/
		cd Fern-Wifi-Cracker || exit
		chmod +x execute.py	
	}
	function install_kickthemout
	{
		pkg_install nmap
		foldname="kickthemout"
		gitlink="https://github.com/k4m4/kickthemout.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			sudo python -m pip install -r requirements.txt
		fi
	}
	function install_ghostphisher
	{
		foldname="ghost-phisher"
		gitlink="https://github.com/savio-code/ghost-phisher.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x /root/ghost-phisher/Ghost-Phisher/ghost.py
		fi
	}
	function install_theeye
	{
		foldname="The-Eye"
		gitlink="https://github.com/EgeBalci/The-Eye.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x TheEye	
		fi
	}
	function install_xerxes
	{
		foldname="xerxes"
		gitlink="https://github.com/zanyarjamal/xerxes.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			gcc xerxes.c -o xerxes	
		fi
	}
	function install_mdk3
	{
		foldname="mdk3-master"
		gitlink="https://github.com/wi-fi-analyzer/mdk3-master.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			make
			make install
		fi
	}
	function install_katana
	{
		foldname="KatanaFramework"
		gitlink="https://github.com/PowerScript/KatanaFramework.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			sh dependencies
			python install
		fi
	}
	function install_airgeddon
	{
		foldname="airgeddon"
		gitlink="https://github.com/v1s1t0r1sh3r3/airgeddon.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x airgeddon.sh
		fi
	}
	function install_4nonimizer
	{
		foldname="4nonimizer"
		gitlink="https://github.com/Hackplayers/4nonimizer.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x 4nonimizer
			./4nonimizer install
			clear
			cd || exit
			pkg_install python-pip php-curl
			gem install pcaprub
			gem install packetfu	
		fi
	}
	function install_beelogger
	{
		foldname="BeeLogger"
		gitlink="https://github.com/4w4k3/BeeLogger.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x install.sh
			./install.sh
			cd || exit
			pkg_install python-pip php-curl
			gem install pcaprub
			gem install packetfu
		fi
	}
	function install_ezsploit
	{
		foldname="ezsploit"
		gitlink="https://github.com/rand0m1ze/ezsploit.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x ezsploit.sh
		fi
	}
	function install_pupy
	{
		foldname="pupy"
		gitlink="https://github.com/n1nj4sec/pupy.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			git submodule init
			git submodule update
			cd pupy || exit
			pip install -r requirements.txt
		fi
	}
	function install_zirikatu
	{
		foldname="zirikatu"
		gitlink="https://github.com/pasahitz/zirikatu.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x zirikatu.sh
		fi
	}
	function install_wifiautopwner
	{
		foldname="WiFi-autopwner"
		gitlink="https://github.com/Mi-Al/WiFi-autopwner.git"
		install_default
	}
	function install_bully
	{
		foldname="bully"
		gitlink="https://github.com/aanarchyy/bully.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			cd src || exit
			make
			sudo make install
		fi		
	}
	function install_anonsurf
	{
		foldname="kali-anonsurf"
		gitlink="https://github.com/Und3rf10w/kali-anonsurf.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x installer.sh
			./installer.sh
		fi
	}
	function install_anonym8
	{
		foldname="anonym8"
		gitlink="https://github.com/HiroshiManRise/anonym8.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x INSTALL.sh
			./INSTALL.sh
		fi
	}
	function install_thefatrat
	{
		foldname="TheFatRat"
		gitlink="https://github.com/Screetsec/TheFatRat.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x setup.sh && ./setup.sh	
		fi
	}
	function install_angryip
	{
		cd || exit
		if [[ -f "/root/ipscan_*" ]]
		then
			echo -e "Removing old file"
			sleep 2
			rm -f /root/ipscan_*
		fi
		echo -e "Downloading angryipscanner"
		sleep 2
		wget https://github.com/angryip/ipscan/releases/download/3.5.2/ipscan_3.5.2_amd64.deb
		echo -e "Installing..."
		dpkg -i ipscan_3.5.2*
		echo -e "Done"
		sleep 1
	}
	function install_sniper
	{
		foldname="Sn1per"
		gitlink="https://github.com/1N3/Sn1per.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x install.sh
			./install.sh
		fi
	}
	function install_recondog
	{
		foldname="ReconDog"
		gitlink="https://github.com/UltimateHackers/ReconDog.git"
		install_default
	}
	function install_redhawk
	{
		foldname="RED_HAWK"
		gitlink="https://github.com/Tuhinshubhra/RED_HAWK.git"
		install_default
	}
	function install_winpayloads
	{
		foldname="Winpayloads"
		gitlink="https://github.com/nccgroup/Winpayloads.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x setup.sh
			./setup.sh
		fi
	}
	function install_chaos
	{
		apt install golang upx-ucl -y
		cd || exit
		foldname="CHAOS"
		gitlink="https://github.com/tiagorlampert/CHAOS.git"
		install_default
	}
	function install_routersploit
	{
		foldname="routersploit"
		gitlink="https://github.com/reverse-shell/routersploit.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pkg_install python3-pip
			python3 -m pip install -r requirements.txt
			python setup.py install
		fi
	}
	function install_infoga
	{
		foldname="Infoga"
		gitlink="https://github.com/m4ll0k/Infoga.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
		fi
	}
	function install_nwatch
	{
		foldname="nWatch"
		gitlink="https://github.com/suraj-root/nWatch.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install scapy
			pip install colorama
			pip install nmap
			pip install ctypes
			pip2.7 install scapy
			pip2.7 install colorama
			pip2.7 install nmap
			pip2.7 install ctypes
		fi
	}
	function install_metasploit_framework
	{
		#metasploit-framework isn't packaged for Fedora/dnf at all; Rapid7's
		#own official installer is distro-agnostic (bundles its own deps)
		#and is the documented way to get it on any non-Debian system.
		if [[ "$PKGMGR" = "dnf" ]]
		then
			pkg_install curl
			curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /root/msfinstall && chmod 755 /root/msfinstall && /root/msfinstall
		else
			pkg_install metasploit-framework
		fi
	}
	function install_eternalscanner
	{
		foldname="eternal_scanner"
		gitlink="https://github.com/peterpt/eternal_scanner.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pkg_install masscan
			install_metasploit_framework
		fi
	}
	function install_eaphammer
	{
		foldname="eaphammer"
		gitlink="https://github.com/s0lst1c3/eaphammer.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x kali-setup
			./kali-setup
			pkg_install python-tqdm
		fi
	}
	function install_dagon
	{
		foldname="dagon"
		gitlink="https://github.com/ekultek/dagon.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
			pip2.7 install -r requirements.txt
			pkg_install bcrypt
		fi
	}
	function install_lalin
	{
		foldname="LALIN"
		gitlink="https://github.com/Screetsec/LALIN.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x Lalin.sh
		fi
	}
	function install_knockmail
	{
		foldname="KnockMail"
		gitlink="https://github.com/4w4k3/KnockMail.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requeriments.txt
		fi
	}
	function install_kwetza
	{
		foldname="kwetza"
		gitlink="https://github.com/sensepost/kwetza.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install beautifulsoup4
			pip2.7 install beautifulsoup4
		fi
	}
	function install_ngrok
	{
		if [[ -f /root/ngrok || -f /root/ngrok.zip ]]
		then
			echo -e "Removing old..."
			echo -e "$PAKTC"
			$READAK
			rm -f /root/ngrok
			rm -f /root/ngrok.zip
		fi
		rm -f /root/ngrok.zip
		cd || exit
		echo -e "Downloading Ngrok"
		wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip --output-document=/root/ngrok.zip
		echo -e "Unzipping Ngrok"
		unzip /root/ngrok.zip
	}
	function install_netdiscover
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			#confirmed via `dnf repoquery`: no "netdiscover" package or
			#virtual provide on Fedora. Its build (autotools, needs
			#libnet/libpcap) is reported flaky upstream (broken OUI
			#database URL, libpcap-version build breaks), so this is
			#attempted but may need manual fixing - not a one-line fix
			#that can be guessed from here.
			pkg_install autoconf automake libtool libnet-devel libpcap-devel hwdata
			foldname="netdiscover"
			gitlink="https://github.com/netdiscover-scanner/netdiscover.git"
			install_default
			cloned=$?
			if [[ "$cloned" == 1 ]]
			then
				echo -e """$RS""netdiscover's build has reported issues upstream on recent systems (e.g. an expired OUI-database URL). Attempting the build now; if it fails, check https://github.com/netdiscover-scanner/netdiscover for current build instructions.""$CE"""
				autoreconf -fiv && ./configure && make && make install
			fi
		else
			pkg_install netdiscover
		fi
	}
	function install_websploit
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			echo -e """$RS""websploit has no Fedora package and is unmaintained upstream (abandoned since ~2015, last Debian packaging in 2022). Cloning the Debian/Kali packaging source instead - run it with: python3 websploit""$CE"""
			pkg_install python3 python3-requests python3-scapy
			foldname="websploit"
			gitlink="https://gitlab.com/kalilinux/packages/websploit.git"
			install_default
		else
			pkg_install websploit
		fi
	}
	function install_openvas
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			echo -e """$RS""OpenVAS/Greenbone has no native Fedora/dnf package. Greenbone themselves recommend either their official container setup (https://greenbone.github.io/docs/latest/22.4/container/) or a source build (https://greenbone.github.io/docs/latest/22.4/source-build/index.html) - this needs to be done manually, lscript can't automate it safely.""$CE"""
		else
			pkg_install openvas
			openvas-setup
		fi
	}
	function install_shellter
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			pkg_install wine
			echo -e """$YS""Shellter is a Windows PE tool. Wine is installed - download Shellter yourself from https://www.shellterproject.com and run it with: wine Shellter.exe""$CE"""
		else
			pkg_install shellter
		fi
	}
	function install_geany
	{
		pkg_install geany
	}
	function install_bleachbit
	{
		pkg_install bleachbit
	}
	function install_vmr
	{
		if [[ -d /root/mdk3-v6 || -d /root/VMR ]]
		then
			echo -e "Removing old..."
			echo -e "$PAKTC"
			$READAK
			rm -r /root/mdk3-v6
			if [[ -f /root/VMR-MDK-K2-2017R-012x2.zip ]]
			then
				rm /root/VMR-MDK-K2-2017R-012x2.zip
			fi
			if [[ -d /root/VMR ]]
			then
				rm -r /root/VMR
			fi
		fi
		cd || exit
		wget https://github.com/musket33/VMR-MDK-Kali2-Kali2016/raw/master/VMR-MDK-K2-2017R-012x2.zip
		unzip /root/VMR-MDK-K2-2017R-012x2.zip -d /root/VMR
		cp -r /root/VMR/mdk3-v6 /root/
		cd /root/mdk3-v6 || exit
		make
		make install
		chmod 755 /root/mdk3-v6/*
		chmod +x /root/VMR/*.sh
		cd || exit
	}
	function install_hashbuster
	{
		foldname="Hash-Buster"
		gitlink="https://github.com/UltimateHackers/Hash-Buster.git"
		install_default
	}
	function install_findsploit
	{
		foldname="Findsploit"
		gitlink="https://github.com/1N3/Findsploit.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x install.sh
			./install.sh
		fi
	}
	function install_howdoi
	{
		pip install howdoi
		pip2.7 install howdoi
	}
	function install_operative
	{
		foldname="operative-framework"
		gitlink="https://github.com/graniet/operative-framework.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
			pip2.7 install -r requirements.txt
		fi
	}
	function install_netattack2
	{

		foldname="netattack2"
		gitlink="https://github.com/chrizator/netattack2.git"
		install_default
	}
	function install_koadic
	{
		foldname="koadic"
		gitlink="https://github.com/zerosum0x0/koadic.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
			pip2.7 install -r requirements.txt
		fi
	}
	function install_empire
	{
		foldname="Empire"
		gitlink="https://github.com/EmpireProject/Empire.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x setup/install.sh
			cd setup || exit
			./install.sh
			./setup_database.py
		fi
	}
	function install_meterpreter_paranoid_mode
	{
		foldname="Meterpreter_Paranoid_Mode-SSL"
		gitlink="https://github.com/r00t-3xp10it/Meterpreter_Paranoid_Mode-SSL.git"
		install_default
	}
	function install_dropit_frmw
	{
		foldname="Dr0p1t-Framework"
		gitlink="https://github.com/D4Vinci/Dr0p1t-Framework.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			cd || exit
			git clone $gitlink
			chmod 777 -R Dr0p1t-Framework
			cd Dr0p1t-Framework || exit
			chmod +x install.sh
			./install.sh
		fi
	}
	function install_wifi_pumpkin
	{
		foldname="WiFi-Pumpkin"
		gitlink="https://github.com/P0cL4bs/WiFi-Pumpkin.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			./installer.sh --install
		fi
	}
	function install_veil
	{
		foldname="Veil"
		gitlink="https://github.com/Veil-Framework/Veil.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			cd setup || exit
			./setup.sh -c
		fi
	}
	function install_leviathan
	{
		foldname="leviathan"
		gitlink="https://github.com/leviathan-framework/leviathan.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements
			pip2.7 install -r requirements
		fi
	}
	function install_fake_image
	{
		foldname="FakeImageExploiter"
		gitlink="https://github.com/r00t-3xp10it/FakeImageExploiter.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x *.sh
		fi
	}
	function install_avet
	{
		foldname="avet"
		gitlink="https://github.com/govolution/avet.git"
		install_default
	}
	function install_gloom
	{
		foldname="Gloom-Framework"
		gitlink="https://github.com/StreetSec/Gloom-Framework.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			python install.py
		fi
	}
	function install_arcanus
	{
		foldname="ARCANUS"
		gitlink="https://github.com/EgeBalci/ARCANUS.git"
		install_default
	}
	function install_msfpc
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			foldname="msfpc"
			gitlink="https://github.com/g0tmi1k/msfpc.git"
			install_default
			cloned=$?
			if [[ "$cloned" == 1 ]]
			then
				chmod +x msfpc.sh
				ln -sf /root/msfpc/msfpc.sh /usr/local/bin/msfpc
				echo -e """$YS""msfpc is installed, but needs the Metasploit Framework installed separately to actually work (see the 'metasploit-framework' install option).""$CE"""
			fi
		else
			pkg_install msfpc
		fi
	}
	function install_morphhta
	{
		foldname="morphHTA"
		gitlink="https://github.com/vysec/morphHTA.git"
		install_default
	}
	function install_lfi
	{
		foldname="LFISuite"
		gitlink="https://github.com/D35m0nd142/LFISuite.git"
		install_default
	}
	function install_unibyav
	{
		foldname="UniByAv"
		gitlink="https://github.com/Mr-Un1k0d3r/UniByAv.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			if [[ "$PKGMGR" = "dnf" ]]
			then
				#"mingw-w64" isn't a real package name on Fedora
				#(confirmed via dnf repoquery) - the actual
				#cross-compiler packages are mingw64-gcc/mingw32-gcc
				dnf -y install mingw64-gcc mingw32-gcc
			else
				pkg_install mingw-w64
			fi
		fi
	}
	function install_demiguise
	{
		foldname="demiguise"
		gitlink="https://github.com/nccgroup/demiguise.git"
		install_default
	}
	function install_dkmc
	{
		foldname="DKMC"
		gitlink="https://github.com/Mr-Un1k0d3r/DKMC.git"
		install_default
	}
	function install_sechub
	{
		foldname="secHub"
		gitlink="https://github.com/cys3c/secHub.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			python installer.py
			chmod +x /usr/bin/sechub
		fi
	}
	function install_beef
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			pkg_install ruby rubygem-bundler nodejs make gcc-c++ git
			foldname="beef"
			gitlink="https://github.com/beefproject/beef"
			install_default
			cloned=$?
			if [[ "$cloned" == 1 ]]
			then
				gem install bundler
				chmod +x install
				./install
			fi
		else
			pkg_install beef-xss
		fi
	}
	function install_mitmf
	{
		pkg_install python-dev python-setuptools libpcap0.8-dev libnetfilter-queue-dev libssl-dev libjpeg-dev libxml2-dev libxslt1-dev libcapstone3 libcapstone-dev libffi-dev file
		foldname="MITMf"
		gitlink="https://github.com/byt3bl33d3r/MITMf"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			git submodule init
			git submodule update --recursive
			pip install -r requirements.txt
			pip2.7 install -r requirements.txt
		fi
	}
	function install_arp_scan
	{
		pkg_install arp-scan
	}
	function install_netool
	{
		foldname="opensource"
		gitlink="https://github.com/r00t-3xp10it/netool-toolkit"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x INSTALL.sh && ./INSTALL.sh
		fi
	}
	function install_sqlmap
	{
		if [[ "$PKGMGR" = "dnf" ]]
		then
			#confirmed via `dnf repoquery`: no "sqlmap" package or
			#virtual provide exists on Fedora. sqlmap's own README says
			#to just clone and run sqlmap.py, no build/install step -
			#the rest of this script expects a plain `sqlmap` command
			#and checks for /usr/bin/sqlmap, so wrap it the same way
			#Debian's package does.
			foldname="sqlmap"
			gitlink="https://github.com/sqlmapproject/sqlmap.git"
			install_default
			cloned=$?
			if [[ "$cloned" == 1 ]]
			then
				printf '#!/bin/sh\nexec python3 /root/sqlmap/sqlmap.py "$@"\n' > /usr/bin/sqlmap
				chmod +x /usr/bin/sqlmap
			fi
		else
			pkg_install sqlmap
		fi
	}
	function install_patator
	{
		foldname="patator"
		gitlink="https://github.com/lanjelot/patator.git"		
		install_default
	}
	function install_zeus
	{
		foldname="Zeus-Scanner"
		gitlink="https://github.com/Ekultek/Zeus-Scanner.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
			pip2.7 install -r requirements.txt
		fi
	}
	function install_evil_droid
	{
		foldname="Evil-Droid"
		gitlink="https://github.com/M4sc3r4n0/Evil-Droid.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x evil-droid
		fi
	}
	function install_nosqlmap
	{
		foldname="NoSQLMap"
		gitlink="https://github.com/codingo/NoSQLMap.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			python setup.py install
		fi
	}
	function install_eggshell
	{
		foldname="EggShell"
		gitlink="https://github.com/neoneggplant/EggShell.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			easy_install pycrypto
			python eggshell.py
		fi
	}
	function install_zerodoor
	{
		foldname="Zerodoor"
		gitlink="https://github.com/Souhardya/Zerodoor.git"
		install_default
		cloned=$?
	}
	function install_objection
	{
		pip3 install objection
		foldname="objection"
		gitlink="https://github.com/sensepost/objection.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			python setup.py
		fi
	}
	function install_cromos
	{
		foldname="cromos"
		gitlink="https://github.com/evilsocketbr/cromos.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			python setup.py
		fi
	}
	function install_fsociety
	{
		foldname="fsociety"
		gitlink="https://github.com/Manisso/fsociety.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x install.sh
			./install.sh
		fi
	}
	function install_yuki-chan
	{
		foldname="Yuki-Chan-The-Auto-Pentest"
		gitlink="https://github.com/Yukinoshita47/Yuki-Chan-The-Auto-Pentest.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod 777 wafninja joomscan install-perl-module.sh yuki.sh
			chmod 777 Module/WhatWeb/whatweb
			pip install -r requirements.txt
			chmod +x *.sh
			./install-perl-module.sh
		fi
	}
	function install_socialfish
	{
		foldname="SocialFish"
		gitlink="https://github.com/UndeadSec/SocialFish.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
			pip2.7 install -r requirements.txt
		fi
	}
	function install_autosploit
	{
		foldname="AutoSploit"
		gitlink="https://github.com/NullArray/AutoSploit.git"
		install_default
	}
	function install_blazy
	{
		foldname="Blazy"
		gitlink="https://github.com/UltimateHackers/Blazy.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
		fi
	}
	function install_striker
	{
		foldname="Striker"
		gitlink="https://github.com/UltimateHackers/Striker.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
		fi
	}
	function install_hyprpulse
	{
		foldname="hyprPulse"
		gitlink="https://github.com/Ethical-H4CK3R/hyprPulse.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x install.sh
			pip2.7 install -r requirements.txt
			./install.sh
			
		fi
	}
	function install_instaburst
	{
		foldname="InstaBurst"
		gitlink="https://github.com/Ethical-H4CK3R/InstaBurst.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			chmod +x install.sh
			pip2.7 install -r requirements.txt
			./install.sh
			
		fi
	}
	function install_sitebroker
	{
		foldname="SiteBroker"
		gitlink="https://github.com/Anon-Exploiter/SiteBroker"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install -r requirements.txt
			pip2.7 install -r requirements.txt
		fi
	}
	function install_enigma
	{
		foldname="Enigma"
		gitlink="https://github.com/UndeadSec/Enigma.git"
		install_default
	}
	function install_datasploit
	{
		foldname="datasploit"
		gitlink="https://github.com/DataSploit/datasploit.git"
		install_default
		cloned=$?
		if [[ "$cloned" == 1 ]]
		then
			pip install --upgrade --force-reinstall -r requirements.txt
			pip2.7 install --upgrade --force-reinstall -r requirements.txt
		fi
	}
	function install_instagram-py
	{
		if [[ -f /usr/local/bin/instagram-py ]]
		then
			echo -e """$YS""Upgrading...""$CE"""
			pip3 install instagram-py --upgrade
		else
			echo -e """$YS""Installing...""$CE"""
			easy_install3 -U pip
			pip3 install requests --upgrade
			pip3 install requests[socks]
			pip3 install stem
			pip3 install instagram-py
			instagram-py --create-configuration
		fi
	}
