#!/bin/sh
rm FILES outputs
for f in `ls Pexels*` ; do
    echo "processing $f" ;
    echo "$f" >> FILES ;
    python3 dvr-scan.py -so -i "$f" | tail -n 1 >> outputs ;
done
