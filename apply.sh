#!/usr/bin/env bash

# make links to the files and folders in the utilities directory, from the
# appropriate places

UTILITIES_DIR=$(realpath "$(dirname $0)")

VIMRC="$UTILITIES_DIR/configs/.vimrc"
BASHRC="$UTILITIES_DIR/configs/.bashrc"
TMUX_CONF="$UTILITIES_DIR/configs/.tmux.conf"
BIN_FOLDER="$UTILITIES_DIR/bin"

VIMRC_LINK="$HOME/.vimrc"
BASHRC_LINK="$HOME/.bashrc"
TMUX_CONF_LINK="$HOME/.tmux.conf"
BIN_FOLDER_LINK="$HOME/bin"

usage() {
    echo "$(basename $0) [force]"
    exit 1
}

# return 0 (true) for yes, 1 (false) for no
read_yes_no() {
    PROMPT="$1"
    read -p "$PROMPT [y/n] " ans
    case "$(echo $ans | tr '[:upper:]' '[:lower:]')" in
    y | yes) return 0 ;;
    n | no) return 1 ;;
    *)
        echo "Invalid answer '$ans'"
        exit 1
        ;;
    esac
}

link_file() {
    TARGET=$1
    LINK=$2
    FORCE=$3
    if [[ ! -z $FORCE ]]; then
        MODE="-f"
    else
        MODE="-i"
    fi
    ln $MODE -s "$TARGET" "$LINK"
}

link_dir() {
    TARGET=$1
    LINK=$2
    FORCE=$3
    if [[ -d "$LINK" ]]; then
        if [[ ! -z $FORCE ]]; then
            # dir exists and force is enabled
            rm -rf "$LINK"
        else
            PROMPT="Directory $LINK already exists. Do you want to replace it (remove existing)?"
            if read_yes_no "$PROMPT"; then
                # dir exists and user chose to override
                rm -rf "$LINK"
            else
                echo "Skipping $LINK"
                return
            fi
        fi
    fi

    ln -s "$TARGET" "$LINK"
}

FORCE=$1

if [[ ! -z "$FORCE" ]] && [[ $FORCE != "force" ]]; then
    usage
fi

link_file "$BASHRC" "$BASHRC_LINK" "$FORCE"
link_file "$VIMRC" "$VIMRC_LINK" "$FORCE"
link_file "$TMUX_CONF" "$TMUX_CONF_LINK" "$FORCE"
link_dir "$BIN_FOLDER" "$BIN_FOLDER_LINK" "$FORCE"
