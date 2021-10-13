#!/bin/sh

read -p "Who would you like to greet? "

if [[ -z $REPLY ]] ; then
  recipient="World"
else
  recipient="$REPLY"
fi

echo -e "Hello\n$recipient\n"
