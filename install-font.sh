#!/usr/bin/env bash

set -e

case "$(uname -s)" in
    Linux)
        # $HOME/.local/share/fonts
        FONT_DIR=/usr/share/fonts/
        ;;
    Darwin)
        # /usr/share/fonts/
        FONT_DIR=$HOME/Library/Fonts
        ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*)
        echo 'Only Support Linux and OSX.'
        exit 0
        ;;
    *)
        echo 'Only Support Linux and OSX'
        exit 0
        ;;
esac

mkdir -p $FONT_DIR

cp ./theme/all-the-icons.el/fonts/* $FONT_DIR

fc-cache -vf
