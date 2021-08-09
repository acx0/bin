#!/usr/bin/env bash

bat_bin=batcat
if [[ $OSTYPE == "darwin"* ]]; then
    bat_bin=/usr/local/bin/bat
fi
$bat_bin "$@"
