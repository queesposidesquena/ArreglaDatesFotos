#!/bin/bash

# Desactiva la distinció entre majúscules i minúscules al 'for'.
# Això no aplica a l'if, on cal transformar cada nom de fitxer a minúscules
shopt -s nocaseglob

atributExifFotos="DateTimeOriginal"
atributExifVideos="CreationDate"

for fitxer in *.{jp*g,png,heic,mov,mp4}
do
    nomMinuscules=$(echo "$fitxer" | tr '[:upper:]' '[:lower:]')
    if [[ $nomMinuscules == *.mov || $nomMinuscules == *.mp4 ]]; then
        atributExif=$atributExifVideos
    else
        atributExif=$atributExifFotos
    fi

    data=$(exiftool -$atributExif -d "%Y%m%d%H%M" "$fitxer" | awk -F ': ' '{print $2}')

    if [ -n "$data" ]; then
        touch -t "$data" "$fitxer"
        echo "Data de creació modificada per a $fitxer: $data"
    else
        echo "No s'ha trobat la data EXIF per a: $fitxer"
    fi
done
