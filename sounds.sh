#!/usr/bin/env bash

source _scripts_config

mpv --volume=80 "$LOW_BAT_SOUND" 1>/dev/null || notify-send --critical "$0" "$LOW_BAT_SOUND not found."
