*The lazy script has not been updated for a while due to me being very busy with my life. I will try my best to upload an update when I find the time*

## Welcome to the LAZY script  v2.1.4
<p align="center">
<img src="https://i.imgur.com/awIplS6.jpg"/>
<img src="https://i.imgur.com/pbq0DuE.jpg"/>
<img src="https://i.imgur.com/QgTLKxR.jpg"/>
<img src="https://i.imgur.com/oJIk2oG.jpg"/>
<img src="https://i.imgur.com/icT4x55.jpg"/>
<img src="https://i.imgur.com/sSf1JcI.jpg"/>
<img src="https://i.imgur.com/MlDFWax.jpg"/>
<img src="https://i.imgur.com/rbdUIQI.jpg"/>
</p>
A video Hackersploit made : https://www.youtube.com/watch?v=oBpo5sElrMY

A video sstec made:         https://www.youtube.com/watch?v=gSO7c2MN7TY

**For feature-recommendation , add it on the "Issues" tab. NOW!**

**I AM NOT RESPONSIBLE HOW YOU USE THIS TOOL.BE LEGAL AND NOT STUPID.**

**This script will make your life easier, and of course faster.**

**Its not only for noobs.Its for whoever wants to type less and do actually more.**

### What is this
This is a script for Kali Linux that automates many procedures about wifi penetration and hacking.
I actually made it for fun for me just to save some time, but i don't mind publicing it.

### Changes in this version (compared to the original arismelachroinos/lscript)

This fork went through a maintenance/cleanup pass focused on correctness and keeping up
with current tooling, without changing the menus or workflow you already know:

- **`ifconfig`/`iwconfig` replaced with `ip`/`iw`** (net-tools is deprecated upstream and
  isn't installed by default on several current distros anymore; iproute2 is).
- **Several real bugs fixed**, found while cleaning up ShellCheck warnings:
  - WPS pin-found detection in the pixie/bully flow had a typo (`$TT3` instead of `$TTT3`)
    that made it never recognize a successful crack.
  - A missing `$` in two places meant a handshake-status check and a colored status
    message were comparing/printing the literal variable name instead of its value.
  - The Dr0p1t-Framework builder's "disable UAC" option built its flag into the wrong
    variable name, so it was never actually passed to the tool.
  - The MorphHTA (morph-hta.py) integration had its technique picker (mshta/explorer/
    wmiprvse) silently dropped and every other flag shifted by one slot.
  - Old `.csv`/`.netxml` handshake files were never cleaned up on opening the handshake
    menu because of a glob that can't match inside a quoted `-f` test.
  - A `rm -r` on the keyboard-shortcuts folder had no guard against the target variable
    ever being empty.
- **~3700 ShellCheck warnings resolved** (quoting bugs, dead/unused variables, a
  malformed `awk` program block, an `ls | grep` replaced with a direct file test, etc.),
  down to a small, documented list of "feature looks unfinished" cases left for a human
  decision rather than guessed at.
- **Added a ShellCheck GitHub Actions workflow** so future changes get checked automatically.
- **Fedora/RHEL-family (dnf) support.** The script auto-detects `apt-get` vs `dnf` and
  translates package names where they differ. Most of the tools that aren't packaged
  for Fedora at all (beef-xss, msfpc, metasploit-framework, websploit, shellter) now get
  a real install path instead (git clone + build, the official Rapid7 installer, Wine,
  etc. - whatever each project's own docs recommend). OpenVAS/Greenbone genuinely has no
  safe way to automate on Fedora (upstream only supports Docker Compose or a source
  build), so that one just points you at Greenbone's own docs. Every package name this
  maps to dnf has been checked live against Fedora 44's actual repos with
  `dnf repoquery --whatprovides` (read-only, no installs) - `bcrypt` was also installed
  and round-tripped for real: `dnf install bcrypt` pulls a build with encryption fully
  enabled, unlike Debian's decrypt-only one. `sqlmap`, `wifite` and `netdiscover` turned
  out to have no Fedora package at all (my first guess was wrong) and now build from
  source instead; `netdiscover`'s upstream build has known issues on current systems and
  may still need manual fixing. Installing the git-clone-based tools themselves is still
  untested on a real run - please report any issues you hit.
- **Helper scripts renamed to say what they do.** `lh1`/`lh2`/`lh21`/`lh3`/`lh4` are now
  `handshake-menu`/`deauth-menu`/`deauth-autocheck`/`wps-menu`/`wep-menu`, and
  the `ls/` directory (and its `l131.sh`/`l132.sh`/`l133.sh`) is now `mitm-helpers/`
  (`dns2proxy.sh`/`arpspoof-poison-target.sh`/`arpspoof-poison-gateway.sh`). Four other
  `lhNN` files (`lh31`, `lh41`, `lh42`, `lh43`) turned out to be dead leftovers nothing
  actually called anymore and were removed rather than renamed.
- **KDE support (`konsole`).** lscript used to hard-depend on `gnome-terminal` for every
  pop-up window (deauth helper, handshake capture, etc.). It now also supports `konsole`
  (confirmed working live on KDE Plasma/Fedora 44 - opens, runs a compound shell command
  correctly, closes itself when done), falling back further to `xterm` if neither GNOME
  nor KDE's terminal is present. `install.sh` only pulls in `gnome-terminal` if the
  system has none of the three already.

None of this changes how you use the script day to day - it's the same menus and
keyboard shortcuts as before. The `ip`/`iw` migration was reviewed line by line and
sanity-checked against sample output, but (lacking real wireless hardware to test
against) hasn't been field-tested yet - if you hit anything odd with monitor mode or
local-IP detection, please open an issue.

### Features

   ### NEW FEATURE: Custom keyboard shortcuts!! Launch any tool within lscript , with your own shortcuts!!! (type ks to set your shortcuts)
	
Enabling-Disabling interfaces faster
Changing Mac faster
Anonymizing yourself faster
View your public IP faster
View your MAC faster
	
**TOOLS**

	You can install whichever tool(s) you want from within lscript! 
	Fluxion                         by Deltaxflux
	WifiTe                          by derv82
	Wifiphisher                     by George Chatzisofroniou
	Zatacker                        by LawrenceThePentester
	Morpheus                        by Pedro ubuntu  [ r00t-3xp10it ]
	Osrframework                    by i3visio
	Hakku                           by 4shadoww
	Trity                           by Toxic-ig
	Cupp                            by Muris Kurgas
	Dracnmap                        by Edo -maland-
	Fern Wifi Cracker               by Savio-code
	Kichthemout                     by Nikolaos Kamarinakis & David Schütz
	BeeLogger                       by Alisson Moretto - 4w4k3
	Ghost-Phisher                   by Savio-code
	Mdk3-master                     by Musket Developer
	Anonsurf                        by Und3rf10w
	The Eye                         by EgeBalci
	Airgeddon                       by v1s1t0r1sh3r3
	Xerxes                          by zanyarjamal
	Ezsploit                        by rand0m1ze
	Katana framework                by PowerScript
	4nonimizer                      by Hackplayers
	Sslstrip2                       by LeonardoNve
	Dns2proxy                       by LeonardoNve
	Pupy                            by n1nj4sec
	Zirikatu                        by pasahitz
	TheFatRat                       by Sceetsec
	Angry IP Scanner                by Anton Keks
	Sniper                          by 1N3
	ReconDog                        by UltimateHackers
	RED HAWK                        by Tuhinshubhra
	Routersploit                    by Reverse shell
	CHAOS                           by Tiagorlampert
	Winpayloads                     by Ncc group 
	Infoga                          by m4ll0k
	nWatch                          by Suraj
	Eternal scanner                 by Peterpt
	Eaphammer                       by S0lst1c3
	Dagon                           by Ekultek
	LALIN                           by Screetsec
	Ngrok                           by inconshreveable + more
	Kwetza                          by Chris Le Roy
	Bleachbit                       by Andrew Ziem
	Operative framework             by Tristan Granier
	Netattack2                      by Christian Klein
	Findsploit                      by 1N3
	Howdoi                          by Benjamin Gleitzman
	Dr0p1t-Framework                by Karim Shoair
	FakeImageExploiter              by r00t-3xp10it
	Leviathan                       by Utku Sen, Ozge Barbaros
	WiFi-Pumpkin                    by P0cL4bs
	Avet                            by govolution
	Meterpreter_Paranoid_Mode-SSL   by r00t-3xp10it
	Koadic                          by zerosum0x0
	Empire                          by Will Schroeder,
                                           Justin Warner, 
                                           Matt Nelson,
                                           Steve Borosh,
                                           Alex Rymdeko-harvey, 
                                           Chris Ross
	Veil                            by ChrisTruncer
	SecHub                          by JoshDelta
	DKMC                            by Mr.Un1k0d3r RingZer0 Team
	Demiguise                       by Richard Warren
	UniByAv                         by Mr.Un1k0d3r RingZer0 Team
	LFISuite                        by D35m0nd142
	Faraday                         by Infobyte
	MSFPC                           by g0tmi1k
	NoSQLMap                        by codingo, tcsstool
	Evil-Droid                      by Mascerano Bachir
	Iftop                           by Paul Warren, Chris Lightfoot
	MORE ARE BEING ADDED ON EVERY UPDATE
	
**Wifi password scripts**

	Handshake       (WPA-WPA2)
	Find WPS pin    (WPA-WPA2)
	WEP hacking     (WEP)    
	
**Others**

	Email spoofing
	Metasploit automation (create payloads,listeners,save listeners for later etc...)
	Auto eternalblue exploiting (check on ks) -> hidden shortcuts
	Browser auto-expoiting with BeEF and MITMf
	SQLmap automated
	+more
		
# How to install (Kali Linux)
(make sure you are a root user)

<p>
	Official Installation Tutorial on Kali Linux 2020.5:
	https://youtu.be/xcb5uwP5nSU
</p>

**Be carefull.If you download it as a .zip file, it will not run.Make sure to follow these simple instructions.**

**MADE FOR KALI LINUX**

```
cd
apt-get update
git clone https://github.com/arismelachroinos/lscript.git
cd lscript
chmod +x install.sh
./install.sh
```

### How to run it

(make sure you are a root user)

```
open terminal
type  "l"
press enter
```
**(Not even "lazy"!! Just "l"! The less you type , the better!)**

### How to uninstall
``` 
cd /root/lscript
./uninstall.sh
rmdir -r /root/lscript 
```

### How to update
``` 
Run the script
Type "update"
```

### Shoutouts

##### [OpenSource Projects](https://www.facebook.com/opensourceprojects/)

OpenSource Projects is a Facebook community page who's goal is to give developers, new and old, a easy and simple place to share their opensource contributions and projects. I personally think this is an awesome idea, I know how hard it is to get your code noticed by people and support these guys 100%. Go ahead and give them a like [here](https://www.facebook.com/opensourceprojects/). They will share any opensource project you send them for free. Thank you OpenSource Projects for giving developers a place to share work with one another!

### Donate
If you like my work, consider buying me a coffee :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=GC9RSY4CS6KAY)

