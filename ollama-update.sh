#!/bin/bash

source HELPERS.sh

notify i "Updating ollama by running the installer again"
curl -fsSL https://ollama.com/install.sh | sh
