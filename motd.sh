#!/bin/sh

# Dynamically find the first Ethernet interface
primary_interface=$(ip -br link | grep -v 'lo' | grep -v 'wl' | cut -d' ' -f1 | head -n1)

# Define dynamic content
hostname=$(hostname)
load=$(uptime | cut -d ' ' -f 9-)
uptime=$(awk '{print int($1/86400)" days "int(($1%86400)/3600)" hours "int(($1%3600)/60)" minutes "int($1%60)" seconds"}' /proc/uptime)
ip_address=$(ip addr show $primary_interface | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
local_date=$(date "+%B %d, %Y") # Date format: "January 5, 1980"
local_time=$(date "+%I:%M:%S %p") # Time format: "8:32:33 PM"

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
echo "         .+. .  :.       .    .:-:    .#  .+.   =-          "
echo "        -=   -:.               .*:     :+   :=:  :=:        "
echo "       +:  .-::                -#      .#     .=--:-+*+:    "
echo "      +:  :::                 .#        =-        .:.       "
echo "     -=  .        .        . :+:       .:+=                 "
echo "    .* :=:   -:-+  =    :==-:.            =-                "
echo "    .#=.   .+..=+     -*-                  :=               "
echo "     #    =#---   ..=#-                      +.             "
echo -e "     .-=+=.      .:#+                         =-         "
echo -e "        +-   .:.    #-            ::.          :+           Hostname: ${hostname}"
echo -e "          ----::---=-%          .+.            +:           Load: ${load}"
echo -e "                   -+*.        .*            -=             Uptime: ${uptime}"
echo -e "                   #+:      :+          .==                 Ethernet IP: ${ip_address}"
echo "                   +#      -:       .---:                 "
echo "                   *.    .:   .-----:                     "
echo "                  -=      :---:                           "
echo "                  *    :--.                               "
echo "                 *: .::                                   "
echo "                 #.:                                      "

