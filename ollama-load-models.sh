#!/bin/bash

MDL_DIR=ollama-modelfiles

# NOTE Create models
ollama create qwen3.5:9k-8b -f ${MDL_DIR}/Modelfile-qwen3.5:9b-8k
