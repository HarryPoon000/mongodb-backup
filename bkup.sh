#!/bin/bash

## DATABASE BACKUP

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

## Read args

POSITIONAL_ARGS=()

TAG="manual"
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
mongodump --version
echo ""

cd $DIR # Relative to where this is executed from

set +e
mkdir backups 2> /dev/null # make directory, ignore if exists
cd backups && mkdir "$TAG" 2> /dev/null # make directory, ignore if exists
cd "$TAG"
set -e

CURTIME="$(date +%Y-%m-%-d_%H:%M:%S)"
mkdir "$CURTIME"
cd "$CURTIME"


echo "Starting backup. Dir: $(pwd)"
mongodump --uri="$DATABASE_URI" --db="$DB" 

