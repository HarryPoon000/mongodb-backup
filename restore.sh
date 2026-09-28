#!/bin/bash

## DATABASE RESTORE

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

source .env
mongorestore --version
echo ""

cd backups
BACKUP_TAG=""
BACKUP_TAG_LIST="$(ls -r)"
select tag in $BACKUP_TAG_LIST;
do
	BACKUP_TAG="$tag"
	echo $BACKUP_TAG
	break
done
cd $BACKUP_TAG
BACKUP_DIR=""
BACKUP_LIST="$(ls -r)"
select dir in $BACKUP_LIST;
do
	BACKUP_DIR="$dir"
	echo "$BACKUP_TAG | $BACKUP_DIR"
	break
done

# mongodump --uri="$DATABASE_URI" --db="$DB" 

