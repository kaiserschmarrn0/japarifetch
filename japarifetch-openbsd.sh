#!/bin/sh

while getopts ":si" opt; do
	case "$opt" in
		i) install -Dm755 japarifetch.sh "${PKG}/usr/bin/japarifetch"
			exit;;
		s) scrot -d 1 japarifetch-"$(date "+%H:%M:%S-%Y-%m-%d")".png &;;
		\?) echo "invalid paramter: -$OPTARG" >&2
			exit;;
	esac
done

host="$(hostname -s)"
os="$(uname -sr)"
uptime="$(uptime | awk -F, '{sub(".*up ",x,$1);print $1}' | sed -e 's/^[ \t]*//')"
packages="$(pkg_info -A | wc -l | sed -e 's/^[ \t]*//')"
shell="$(basename ${SHELL})"
wm="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"

bc="$(tput bold)"
rc="$(tput sgr0)"

cat << EOF
${rc} 			${rc}${USER}@${host}
${rc} ds. ./osso+- .sd	${rc}OS:		${os}
${rc} hMMNMMNmmmNMMMMd	${rc}UPTIME:	${uptime}
${rc} \`mMMd:^^\`^-sMMM:	${rc}PACKAGES:	${packages}
${rc} \`MMM. /NMh  MMMo	${rc}TERMINAL:	${TERM}
${rc}  yMMs+NMMy ,MMM:	${rc}SHELL:	${SHELL}
${rc}   +dNMNh/  shy: 	${rc}WM:		${wm}
${rc}
EOF
