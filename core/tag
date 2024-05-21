#!/usr/bin/env bash

# shellcheck disable=SC1091

source config
isinstalled id3 || exit

args=("$@")

[[ -z ${args[0]} || ${args[0]} == "-help" ]] && echo "Options:
--clear
--update-all (album, artist, title)
--help" && exit 1

if [[ ${args[0]} == "--clear" ]]; then
    id3 --delete "*"
    echo "Tags cleared."

elif [[ ${args[0]} == "--update-all" ]]; then
    echo -n "Do you want to update album names? [y/N]"
    read ans

    if [[ "$ans" == "y" ]]; then
        echo "Type the album's name: "
        read album

        echo "Updating album names."

        id3 --album "$album"  -- "*.mp3"
    fi

    echo -n "Do you want to update artist names? [y/N]"
    read ans

    if [[ "$ans" == "y" ]]; then
        echo -n "Type the artist's name: "
        read artist

        echo "Updating artist names."
        id3 --artist "$artist" -- "*.mp3"
    fi

    echo -n "Do you want to update every song's title? Every file should have only one '-' symbol after artist's name. [y/N]"
    read ans

    if [[ "$ans" == "y" ]]; then
        echo "Updating song titles."

        echo 
        for f in *mp3; do
            export TITLE=$(echo "$f" | sed 's/.*\- //g;s/.\mp3*$//g')
            id3 --title "$TITLE" -- "$f"
        done
    fi
fi


