#!/bin/sh

# Get the current user's login name
user=$(whoami)

# Attempt to extract the first name, fall back to the username if not available
first_name=$(getent passwd "$user" | cut -d ':' -f 5 | cut -d ',' -f 1 | awk '{print $1}')
if [ -z "$first_name" ]; then
    first_name=$user
fi

# Generate a bar that matches the terminal width and center the welcome message
cols=$(tput cols)
welcome_message="Welcome Back, $first_name"
message_length=${#welcome_message}
spaces=$((($cols - $message_length) / 2)) # Calculate spaces needed for centering
bar_left=$(printf '='%.0s $(seq 1 $spaces))
bar_right=$(printf '='%.0s $(seq 1 $(($cols - $spaces - $message_length))))
echo "$bar_left$welcome_message$bar_right"
echo ""  # This adds the line of whitespace as requested


# Dynamically find the first Ethernet interface
primary_interface=$(ip -br link | grep -v 'lo' | grep -v 'wl' | cut -d' ' -f1 | head -n1)

# Define dynamic content
hostname=$(hostname)
cpu_info=$(awk -F': ' '/model name/ {model=$2} END {print model}' /proc/cpuinfo)
cpu_cores=$(grep -c ^processor /proc/cpuinfo)
load=$(uptime | cut -d ' ' -f 9-)
uptime=$(awk '{print int($1/86400)" days "int(($1%86400)/3600)" hours "int(($1%3600)/60)" minutes "int($1%60)" seconds"}' /proc/uptime)
ip_address=$(ip addr show $primary_interface | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
local_date=$(date "+%B %d, %Y")
local_time=$(date "+%I:%M:%S %p")

# Extracting memory information
mem_info=$(free -m | awk '/Mem:/ {print $3"MiB / "$2"MiB"}')

# ASCII Art and dynamic content
echo "                           -----  ..                        "
echo "                    .==--=+.   .=----=                      "
echo -e "                 :--*   .:           ==--                   Date: ${local_date}"
echo -e "                +-  - ::.-----::--=.    .+:                 Time: ${local_time}"
echo "                +.  .= ==  :--- ---#=     *                 "
echo "               =::  *:*=-==.. .-    =::---:-=:              "
echo "               *.  .*:      :-----:.    .+: .+:             "
echo "               =:  =      ===------=:    +-  -=-.           "
echo "               -#+.      *+-    :-*--=.    :+. .+.          "
echo "               *-+       *#----:. *   =-    :*  +::         "
echo "              +.         .: :.:  ++-   +:   =**.  .*        "
echo "           :-=   :.      :..:  .=.  ==  *    .=*=-.   ..--= "
echo "          :+-  .+:==-=              .*: :+    -=  :----=--. "
echo "          =    ::-++-:                +: :=    :=           "
echo -e "         .+. .  :.       .    .:-:    .#  .+.   =-          Hostname: ${hostname}"
echo -e "        -=   -:.               .*:     :+   :=:  :=:        CPU: ${cpu_info} (${cpu_cores}) @ GHz"
echo -e "       +:  .-::                -#      .#     .=--:-+*+:    Load: ${load}"
echo -e "      +:  :::                 .#        =-        .:.       Memory: ${mem_info}"
echo "     -=  .        .        . :+:       .:+=                 "
echo "    .* :=:   -:-+  =    :==-:.            =-                "
echo "    .#=.   .+..=+     -*-                  :=               "
echo "     #    =#---   ..=#-                      +.             "
echo -e "     .-=+=.      .:#+                         =-            "
echo -e "        +-   .:.    #-            ::.          :+           Uptime: ${uptime}"
echo -e "          ----::---=-%          .+.            +:           Ethernet IP: ${ip_address}"
echo "                   -+*.        .*            -=             "
echo "                   #+:      :+          .==               "
echo "                   +#      -:       .---:                 "
echo "                   *.    .:   .-----:                     "
echo "                  -=      :---:                           "
echo "                  *    :--.                               "
echo "                 *: .::                                    "
echo "                 #.:                                      "
