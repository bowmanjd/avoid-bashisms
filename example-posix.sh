#!/bin/sh

printf "Who would you like to greet? "
read -r recipient

if [ -z "$recipient" ] ; then
  recipient="World"
fi

printf "Hello\n%s\n\n" "$recipient"
