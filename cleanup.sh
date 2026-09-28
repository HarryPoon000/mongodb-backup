#!/bin/bash

## CLEAN BACKUPS

time_between() {
	START_SECS="$([ "$(uname)" = Linux ] && date -d $1 +%s || date -ju -f '%Y-%m-%d_%H:%M:%S' $1 +%s )"
	END_SECS="$([ "$(uname)" = Linux ] && date -d $2 +%s || date -ju -f '%Y-%m-%d_%H:%M:%S' $2 +%s )"
	# START_SECS=$(date -r $1 +%s)
	# END_SECS=$(date -r $2 +%s)
	DIFF_SECS=$(($END_SECS - $START_SECS))
	echo $DIFF_SECS
}

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

## Read args

POSITIONAL_ARGS=()

TAG=""
DIR="$SCRIPT_DIR"
while [[ $# -gt 0 ]]; do
	case $1 in
		-t|--tag)
			TAG="$2"
			shift # past argument
			shift # past value
			;;
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
echo ""

cd "$DIR/backups" # Relative to where this is executed from

if [[ $TAG == "" ]]; then
	echo "\`--tag\` not specified. Please select."

	BACKUP_TAG_LIST="$(ls -r)"
	select tag in $BACKUP_TAG_LIST;
	do
		TAG="$tag"
		echo $BACKUP_TAG
		break
	done
fi

cd $TAG

CURTIME="$(date +%Y-%m-%-d_%H:%M:%S)"

echo "Current time: $CURTIME"
pwd
echo ""

echo "Folders to delete:"
for _BACKUPTIME in $(ls); do 
	DELETE_FILE=$(( $(time_between $_BACKUPTIME $CURTIME) / 3600 / 24 >= 90 ))
	if [[ $DELETE_FILE == 1 ]] ;then
		echo $_BACKUPTIME
	fi
done
