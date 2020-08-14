#!/usr/bin/env bash

usage() {
    echo "$(basename $0): GENERAL INFO ABOUT THE PROGRAM

Usage: $(basename $0) [options]

Options:
    -d, --dir DIR       the directory
    -s, --style STYLE   the style
    -l                  enable some option
    "
    exit 1
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
        -d | --dir)
            DIR="$2"
            shift 2
            ;;
        -s | --style)
            SORT_STYLE="$2"
            shift 2
            ;;
        -l)
            L_MODE="true"
            shift 1
            ;;
        -h | --help)
            usage
            ;;
        *)
            echo "Unrecognized parameter $key"
            exit 1
            ;;
        esac
    done
}

if [[ $# -eq 0 ]]; then
    # No arguments provided"
    usage
fi

parse_args "$@"

# ------------------------------

infile="$1"
outfile="$2"

if [[ -z "$outfile" ]]; then
    outfile="$(basename --suffix='.svg' "$infile").pdf"
fi
