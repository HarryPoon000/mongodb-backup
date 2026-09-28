#!/bin/bash

## DATABASE RESTORE

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DIR="$SCRIPT_DIR"
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--directory)
      DIR="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

source "$SCRIPT_DIR/.env"
mongorestore --version
echo ""

cd $DIR # Relative to where this is executed from

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

cd $BACKUP_DIR

mongorestore --uri="$DATABASE_URI" --nsInclude="$DB.*" --dryRun --verbose --bypassDocumentValidation 

