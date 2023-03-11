#!/usr/bin/env bash

if [ ! -d ./.venv ]; then
  virtualenv --python=python3.10 .venv
fi

./.venv/bin/python -m pip install -r requirements.txt
