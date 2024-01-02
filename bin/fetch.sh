#!/usr/bin/env bash

CONFIG_DIRECTORY=${HOME}/.config/ics-fetch
mkdir -p -v $CONFIG_DIRECTORY

if [ -f ${CONFIG_DIRECTORY}/calendars ]; then
  printf "Using calendars from ${CONFIG_DIRECTORY}\n"
  if [[ $1 = "-e" ]]; then
    printf "EDITING!"
  fi
else
  touch ${CONFIG_DIRECTORY}/calendars
  echo "# Example of format:" >> ${CONFIG_DIRECTORY}/calendars
  echo "# Name of user|https://link-to-ical/calendar.ics" >> ${CONFIG_DIRECTORY}/calendars
  $EDITOR ${CONFIG_DIRECTORY}/calendars
fi

SCRIPT_DIR=$(dirname "$0")
/usr/bin/env ruby "${SCRIPT_DIR}/../lib/parser.rb" | column -t -s $'\t'
