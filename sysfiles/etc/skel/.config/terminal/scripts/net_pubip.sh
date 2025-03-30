#!/bin/bash
curl -s https://ipinfo.io/${ip} > /tmp/ipinfo
ip=$(curl -s http://ident.me)
city="$(cat /tmp/ipinfo | grep -i city | awk -F '"' '{print $4}')"
region="$(cat /tmp/ipinfo | grep -i region | awk -F '"' '{print $4}')"
country="$(cat /tmp/ipinfo | grep -i country | awk -F '"' '{print $4}')"
date="$(date)"

if [ -x "$(command -v tput)" ]; then
	bold="$(tput bold)"
	black="$(tput setaf 0)"
	red="$(tput setaf 1)"
	green="$(tput setaf 2)"
	yellow="$(tput setaf 3)"
	blue="$(tput setaf 4)"
	magenta="$(tput setaf 5)"
	cyan="$(tput setaf 6)"
	white="$(tput setaf 7)"
    gray="$(tput setaf 8)"
	reset="$(tput sgr0)"
fi

lc="${reset}${bold}${white}"
nc="${reset}${bold}${white}"
ic="${reset}"
c0="${reset}${yellow}"

## OUTPUT

cat <<EOF

${c0} AVDELNING:13:PUBLIK IP-ADRESS
${c0} ${date}
${c0} ${lc}IP-ADRESS           ${ic}${ip}${reset}
${c0} ${lc}STADSNAMN           ${ic}${city}${reset}
${c0} ${lc}REGION              ${ic}${region}${reset}
${c0} ${lc}LANDSKOD            ${ic}${country}${reset}

EOF

rm /tmp/ipinfo
