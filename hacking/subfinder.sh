#!/usr/bin/env bash

source config
isinstalled assetfinder amass httprobe || exit

clear
url="$1"
mkdir -p "$url"

echoBlue "Harvesting subdomains with assetfinder and amass"
assetfinder "$url" | 
    grep ".$url" | 
    sort -u | 
    tee -a "$url/final.tmp"

amass enum -d "$url" | tee -a "$url/final.tmp"
sort -u "$url/final.tmp" >> "$url/final"
rm "$url/final.tmp"

echoBlue -n "Compiling 3rd lvl domains"
cat "$url/final" | 
    grep -Po '(\w+\.\w+\.\w+)$' | 
    sort -u >> "$url/3rd-lvl-domains"

for line in $(cat "$url/3rd-lvl-domains"); do
    echo "$line" | sort -u | tee -a "$url/final"
done

echoBlue -n "Probing for alive domains"
cat "$url/final" | 
    sort -u | 
    httprobe -s -p https:443 | 
    sed 's/https\?:\/\///' | 
    tr -d ':443' | 
    sort -u >> "$url/alive"
