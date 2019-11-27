#!/bin/bash

source ~/scripts/vars.sh

rclone sync --size-only --no-update-modtime --exclude-if-present .ignore --drive-use-trash=false --fast-list -vv --tpslimit=5 $backupfolder"/" $remote
