#!/bin/bash
set -e

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
source lib/core-utils.sh
source lib/recon-and-exploit.sh
source lib/wlan-interface.sh
source uninstall.sh

temp_dir=$(mktemp -d)
trap 'rm -r -- "$temp_dir"' EXIT

[[ $(installed_version version.txt) == "$(<version.txt)" ]]
[[ $(installed_version "$temp_dir/version.txt") == unknown ]]
printf '%s\n' 'invalid version' > "$temp_dir/version.txt"
[[ $(installed_version "$temp_dir/version.txt") == unknown ]]

bin_dir="$temp_dir/bin"
bashrc="$temp_dir/bashrc"
mkdir "$bin_dir"
touch "$bin_dir/l" "$bin_dir/unrelated"
printf '%s\n' 'export PATH=/bin/lscript:$PATH' '# export PATH=/bin/lscript:$PATH' > "$bashrc"
ln -s "$bin_dir" "$temp_dir/bin-link"
if remove_installation_files "$temp_dir/bin-link" "$bashrc" 2>/dev/null; then
	exit 1
fi
[[ -f "$bin_dir/l" ]]
remove_installation_files "$bin_dir" "$bashrc" >/dev/null
[[ ! -e "$bin_dir/l" && -f "$bin_dir/unrelated" ]]
[[ $(<"$bashrc") == '# export PATH=/bin/lscript:$PATH' ]]

clear() { :; }
dash_calc() { :; }
check_wlans() { :; }
sleep() { :; }

(
	LPATH="$temp_dir"
	READAK='read -r -n 1'
	printf '%s\n' 'saved-wireless' > "$LPATH/wlan.txt"
	printf '%s\n' 'saved-monitor' > "$LPATH/wlanmon.txt"
	if interface_menu <<< $'y\nreplacement' >/dev/null; then
		exit 1
	fi
	[[ $(<"$LPATH/wlan.txt") == saved-wireless ]]
	[[ $(<"$LPATH/wlanmon.txt") == saved-monitor ]]
	[[ ! -e "$LPATH/eth.txt" ]]
	printf '%s\n' 'keep this file' > "$LPATH/unrelated.txt"
	ln -s unrelated.txt "$LPATH/eth.txt"
	if output=$(set_interface_number <<< $'new-wifi\nnew-monitor\nnew-wired' 2>&1); then
		exit 1
	fi
	[[ "$output" == *'is not a regular file.'* ]]
	[[ $(<"$LPATH/wlan.txt") == saved-wireless ]]
	[[ $(<"$LPATH/unrelated.txt") == 'keep this file' ]]
	terms_of_use </dev/null >/dev/null
	[[ ! -e "$LPATH/IAGREE.txt" ]]
)

if banner </dev/null >/dev/null; then
	printf '%s\n' 'Expected the main menu prompt to report closed input.' >&2
	exit 1
fi
banner <<< exit >/dev/null
[[ "$YORNAA" == exit ]]

# The menu must return immediately when its input closes.
timeout 5 bash -c "$(declare -f clear dash_calc errors_menu); errors_menu" </dev/null >/dev/null

systemctl() {
	printf '%s\n' "$*"
	return 3
}

pkg_install() { exit 99; }
diagnostics="$(declare -f clear dash_calc errors_menu systemctl pkg_install); errors_menu"
output=$(PKGMGR=dnf timeout 5 bash -c "$diagnostics" <<< 3)
[[ "$output" == *'display resolution in the guest desktop settings'* ]]
output=$(PKGMGR=dnf timeout 5 bash -c "$diagnostics" <<< 1)
[[ "$output" == *'wpctl status'* ]]
[[ "$output" != *'--user enable'* ]]
output=$(PKGMGR=dnf timeout 5 bash -c "$diagnostics" <<< 5)
[[ "$output" == *'--no-pager status httpd.service'* ]]
output=$(PKGMGR=apt timeout 5 bash -c "$diagnostics" <<< 5)
[[ "$output" == *'--no-pager status apache2.service'* ]]
output=$(PKGMGR=dnf timeout 5 bash -c \
	"$(declare -f clear dash_calc errors_menu); PATH=\$1; errors_menu" bash "$temp_dir" <<< 5)
[[ "$output" == *'Cannot check httpd.service: systemctl is unavailable'* ]]

VERSION=$(installed_version version.txt)
output=$(update_lscript </dev/null)
[[ "$output" == *"Installed version: $VERSION"* ]]
[[ "$output" == *"In-place updates are retired."* ]]
