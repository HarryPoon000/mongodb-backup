#!/bin/bash

## DATABASE RESTORE

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

source .env
mongorestore --version
echo ""

cd backups
ls

# mongodump --uri="$DATABASE_URI" --db="$DB" 

