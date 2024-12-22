#!/bin/bash

for foto in *.{jp*g,JP*G,PNG,HEIC}
do
    data=$(exiftool -DateTimeOriginal -d "%Y%m%d%H%M" $foto | awk -F ': ' '{print $2}' )

    if [ -n "$data" ]; then
        touch -t "$data" "$foto"
        echo "Data de creació modificada per a $foto: $data"
    else
        echo "No s'ha trobat la data EXIF per a: $foto"
    fi
done

for video in *.{mov,MOV,mp4,MP4}
do
    data=$(exiftool -CreationDate -d "%Y%m%d%H%M" $video | awk -F ': ' '{print $2}')

    if [ -n "$data" ]; then
        touch -t "$data" "$video"
        echo "Data de creació modificada per a $video: $data"
    else
        echo "No s'ha trobat la data EXIF per a: $video"
    fi
done
