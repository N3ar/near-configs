#!/bin/bash

which frida
if [[ $? -eq 1 ]]; then
    pip install frida-tools
fi

