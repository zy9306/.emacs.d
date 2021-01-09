#!/usr/bin/env bash

case $1 in
    "-n"|"--normal")
        emacs &
        ;;

    "-p"|"--proxychains")
        proxychains4 -q emacs &
        ;;
    *)
        echo '-n | --normal for normal start; -p | --proxychains for start with proxy'
        ;;
esac
