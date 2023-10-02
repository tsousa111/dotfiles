#!/usr/bin/bash

creds=~/.bb-creds
username=$(awk -F '=' '/username/ {print $2}' $creds)
password=$(awk -F '=' '/password/ {print $2}' $creds)

wget --user="$username" --password="$password" "$1"
