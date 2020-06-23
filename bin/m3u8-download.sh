#!/usr/bin/env bash

url="$1"
quality="$2"
output="$3"

if [[ -z "$url" ]]; then
    echo "
Usage: $(basename $0) URL [QUALITY OUTFILE_FILE]

If only url is given, print the available qualities
If QUALITY is given, download this quality and save in OUTFILE_FILE
"
    exit 1
fi


if [[ -z "$quality" ]]; then
    youtube-dl -F "$url"
else
    youtube-dl -f "$quality" "$url" --output "$output"
fi

