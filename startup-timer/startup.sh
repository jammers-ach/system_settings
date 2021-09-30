#!/bin/bash

set -euo pipefail

LOGFILE=~/.startuplog

echo "$(date +%Y-%m-%d): $1" >> $LOGFILE
