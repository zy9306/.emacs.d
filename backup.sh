#!/usr/bin/env bash

set -e

EMACS_VERSION=$(emacs --version | head -n 1 | tr ' ' '\n' | tail -n 1 | awk -F '.' '{print $1"."$2}')

tar --exclude="*.elc" -Jcvf  elpa-${EMACS_VERSION}.tar.xz elpa-${EMACS_VERSION}

tar --exclude="*.elc" -Jcvf  quelpa.tar.xz quelpa
