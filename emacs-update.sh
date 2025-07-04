#!/bin/bash
set -euo pipefail

guix pull && guix upgrade emacs-next
