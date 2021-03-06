#!/bin/bash

# Directory where the repo is stored locally.
target="/srv/repo"

# Directory where the repo is downloaded to
tmp="/srv/tmp"

# Lockfile path
lock="/var/run/syncrepo.lck"

# bandwidth limit
bwlimit=0

# https://www.archlinux.org/mirrors/1/
source_url=''

# lastupdate link from the t1 mirror
lastupdate_url=''

#### END CONFIG

[ ! -d "${target}" ] && mkdir -p "${target}"
[ ! -d "${tmp}" ] && mkdir -p "${tmp}"

exec 9>"${lock}"
flock -n 9 || exit

rsync_cmd() {
	local -a cmd=(rsync -rtlH --safe-links --delete-after ${VERBOSE} "--timeout=600" "--contimeout=60" -p \
		--delay-updates --no-motd "--temp-dir=${tmp}")

	if stty &>/dev/null; then
		cmd+=(-h -v --progress)
	else
		cmd+=(--quiet)
	fi

	if ((bwlimit>0)); then
		cmd+=("--bwlimit=$bwlimit")
	fi

	"${cmd[@]}" "$@"
}

# if we are called without a tty (cronjob) only run when there are changes
if ! tty -s && [[ -f "$target/lastupdate" ]] && diff -b <(curl -Ls "$lastupdate_url") "$target/lastupdate" >/dev/null; then
	# keep lastsync file in sync for statistics generated by the Arch Linux website
	rsync_cmd "$source_url/lastsync" "$target/lastsync"
	exit 0
fi

rsync_cmd \
	--exclude='*.links.tar.gz*' \
	--exclude='/other' \
	--exclude='/sources' \
	"${source_url}" \
	"${target}"

#echo "Last sync was $(date -d @$(cat ${target}/lastsync))"
