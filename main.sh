#!/bin/bash
# Bash Script to create, search and delete records

function help_menu() {
  # Function to print out the help menu
  echo "Consider:"
  echo "    --create: To Add a New Record"
  echo "    --delete: To Delete a Record"
  echo "    --search: To Search for a Record"
}

function check_dir() {
  # Function to check if there's an available directory for storing records
  BASEDIR="db_records"
  if [[ -d "$BASEDIR" ]]; then
    true
  else
    mkdir $BASEDIR
  fi
}
check_dir

function create_records() {
  echo "Enter the Author:"
  read -r AUTHOR
  echo "Enter the Title:"
  read -r TITLE
  echo "Enter the Pages:"
  read -r PAGES
  echo "Enter the Year:"
  read -r YEAR

  local RECORDNAME=$(echo "$TITLE $PAGES$YEAR.txt" | tr 'A-Z' 'a-z' | tr ' ' '_')

  # Outputting Records to a file
  echo "Author: $AUTHOR" >>$BASEDIR/$RECORDNAME
  echo "Title: $TITLE" >>$BASEDIR/$RECORDNAME
  echo "Pages: $PAGES" >>$BASEDIR/$RECORDNAME
  echo "Year: $YEAR" >>$BASEDIR/$RECORDNAME

  echo "Records Successfully Created"
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
    create_records
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
