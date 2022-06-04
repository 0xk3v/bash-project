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

# function to Create Records
function create_records() {
  local RECORDNAME=$(echo "$RANDOM$RANDOM$RANDOM.txt" | tr 'A-Z' 'a-z' | tr ' ' '_')

  while [[ true ]]; do
    echo "Enter the Author:"
    read -r AUTHOR
    echo "Would you like to Add another Author?(y/n)"
    read -r ANS
    if [[ $ANS == "n" ]]; then
      break
    fi
    echo "Author: $AUTHOR" >>$BASEDIR/$RECORDNAME
  done

  echo "Enter the Title:"
  read -r TITLE
  echo "Enter the Pages:"
  read -r PAGES
  echo "Enter the Year:"
  read -r YEAR

  local RECORDNAME2=$(echo "$TITLE $PAGES$YEAR$RANDOM.txt" | tr 'A-Z' 'a-z' | tr ' ' '_')

  # Outputting Records to a file
  echo "Author: $AUTHOR" >>$BASEDIR/$RECORDNAME
  echo "Title: $TITLE" >>$BASEDIR/$RECORDNAME
  echo "Pages: $PAGES" >>$BASEDIR/$RECORDNAME
  echo "Year: $YEAR" >>$BASEDIR/$RECORDNAME

  mv $BASEDIR/$RECORDNAME $BASEDIR/$RECORDNAME2

  echo "Records Successfully Created"
}

# Function to Search Records
function search_records() {
  echo "Enter Book Author or Title:"
  read -r SEARCH
  # grep "$SEARCH" $BASEDIR
  # grep -iRl "$SEARCH" db_records
  for REC in $(grep -iRl "$SEARCH" $BASEDIR); do
    echo "-----------------------------------------"
    awk -F ":" '{ print $1 ":" $2 }' $REC
  done
}

# Function to Delete
# To be Done
function delete_records() {
  echo "Enter The record to delete"
  read -r REC_
  grep -iRl "$REC_" $BASEDIR
  echo "Do you want to delete the file(s) above? (y/n)"
  read CHOICE
  if [[ $CHOICE == "y" ]]; then
    rm -fr $(grep -iRl "$REC_" $BASEDIR)
  fi
}

if [[ -z "$1" ]]; then
  echo "No arguments supplied :( "
  help_menu
else
  case "$1" in
  "--help")
    help_menu
    ;;
  "--create")
    create_records
    ;;
  "--delete")
    delete_records
    ;;
  "--search")
    search_records
    ;;
  *)
    echo ":( Invalid Argument"
    help_menu
    ;;
  esac

fi
