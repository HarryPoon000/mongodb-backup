#!/bin/bash

## DATABASE BACKUP

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

source .env
mongodump --version
echo ""

set +e
mkdir backups 2> /dev/null # make directory, ignore if exists
set -e

CURTIME="$(date +%Y-%m-%-d_%H:%M:%S)"
cd backups && mkdir "$CURTIME"
cd "$CURTIME"


echo "Starting backup. Dir: $(pwd)"
mongodump --uri="$DATABASE_URI" --db="$DB" 

