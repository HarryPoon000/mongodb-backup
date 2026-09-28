#!/bin/bash

## DATABASE BACKUP

set -e

## Read args

POSITIONAL_ARGS=()

TAG="manual"

while [[ $# -gt 0 ]]; do
  case $1 in
    -t|--tag)
      TAG="$2"
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

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR"

source .env
mongodump --version
echo ""

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

