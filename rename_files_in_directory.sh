#!/bin/bash
# vim: tw=0

set -eo pipefail

if [[ $# -ne 4 && $# -ne 5 ]]; then
  echo -n "usage $0 <directory> <file_pattern> <search_pattern>"
  echo " <replace_pattern> [true]"
  exit 64
fi

if [[ ! -e "$1" ]]; then
  echo "cannot find '$1'"
  exit 65
fi

if [[ ! -z $5 && $5 =~ "true" ]]; then
  echo "got $5"
else
  echo -e "The following would be renamed <original> > <new>\n"
  find "$1" -maxdepth 1 -type f -name "$2" | while read fname; do
    echo -n "${fname} > "; 
    echo "${fname}" | sed "s/$3/$4/"; 
  done
  echo -e "\nTo perform rename,\
 repeat previous command including true at the end"
fi

