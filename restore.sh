#!/bin/bash

## DATABASE RESTORE

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

source .env
mongorestore --version
echo ""

cd backups
BACKUP_LIST="$(ls -r)"
BACKUP_DIR=""
select dir in $BACKUP_LIST;
do
	BACKUP_DIR="$dir"
	echo $BACKUP_DIR
	break
done


# mongodump --uri="$DATABASE_URI" --db="$DB" 

