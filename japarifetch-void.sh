#!/bin/sh

while getopts ":si" opt; do
	case "$opt" in
		i) install -Dm755 japarifetch-void.sh "${PKG}/usr/bin/japarifetch"
			exit;;
		s) scrot -d 1 japarifetch-"$(date "+%H:%M:%S-%Y-%m-%d")".png &;;
		\?) echo "invalid paramter: -$OPTARG" >&2
			exit;;
	esac
done

host="$(hostname)"
os="$(lsb_release -si)"
uptime="$(uptime | awk -F, '{sub(".*up ",x,$1);print $1}' | sed -e 's/^[ \t]*//')"
#packages="$(pkg_info -A | wc -l | sed -e 's/^[ \t]*//')"
packages="$(xbps-query -l | wc -l)"
shell="$(basename ${SHELL})"
wm="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"

bc="$(tput bold)"
rc="$(tput sgr0)"

cat << EOF
${rc} 			${bc}${USER}@${host}
${rc} ds. ./osso+- .sd	${bc}OS:	    ${os}
${rc} hMMNMMNmmmNMMMMd	${bc}UPTIME:	    ${uptime}
${rc} \`mMMd:^^\`^-sMMM:	${bc}PACK:	    ${packages}
${rc} \`MMM. /NMh  MMMo	${bc}TERM:	    ${TERM}
${rc}  yMMs+NMMy ,MMM:	${bc}SHELL:	    ${SHELL}
${rc}   +dNMNh/  shy: 	${bc}WM:	    ${wm}
${rc}
EOF
