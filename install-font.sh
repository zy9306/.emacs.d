#!/usr/bin/env bash

# FontDir=$HOME/.local/share/fonts
FontDir=/usr/share/fonts/

mkdir -p $FontDir

cp ./theme/all-the-icons.el/fonts/* $FontDir

fc-cache -vf
