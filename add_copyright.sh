#!/bin/bash

ME="Miguel Ángel Domínguez Coloma"
YEAR=$(date +%Y)

for FILE in $(find -E . -regex '.*\.(jpg|png|gif|jpeg|webp|webm|mp4)'); do
  exiftool -overwrite_original -all:all= -r "$FILE" 
  exiftool -overwrite_original -artist="$ME" -author="$ME" -copyright="© 2007-$YEAR $ME, eridem.net" -ownername="$ME" "$FILE"
done

for FILE in $(find . -name "*_original"); do
  rm "$FILE"
done
