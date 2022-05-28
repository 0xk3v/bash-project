#!/bin/bash
# Bash Script to create, search and delete records

function help_menu() {
  # Function to print out the help menu
  echo "Consider:"
  echo "    --create: To Add a New Record"
  echo "    --delete: To Delete a Record"
  echo "    --search: To Search for a Record"
}

if [[ -z "$1" ]]; then
  echo "No arguments supplied :( "
  help_menu
else
  echo $#
  case "$1" in
  "--help")
    help_menu
    ;;
  "--create")
    echo "create records"
    ;;
  "--delete")
    echo "delete records"
    ;;
  "--search")
    echo "search records"
    ;;
  *)
    echo ":( Invalid Argument"
    ;;
  esac

fi
