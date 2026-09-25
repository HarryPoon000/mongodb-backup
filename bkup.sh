#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/.env"
CURTIME="$(date +%Y-%m-%-d_%H:%M:%S)"
echo "$CURTIME $(mongodump --version)"
echo ""

mkdir backups 2> /dev/null # make directory, ignore if exists
cd backups && mkdir "$CURTIME"

ls
