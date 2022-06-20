#!/bin/bash

if [[ ! -f "$1" || "" == "$2" ]]; then
    echo -e "Usage:\n\tencrypt.sh <your-jar-file> <your-main-class>\n"
    exit 1
fi

BOOTORIGINAL=$1.bootoriginal.jar
FLATJAR=$1.flat.jar
TARGET=$1
COREDIR=corejars/

# backup original jar
cp "$TARGET" "$BOOTORIGINAL"
mv "$TARGET" "$FLATJAR"
mkdir -p $COREDIR

# find your own -core- jar files to be encrypted
#
# TODO: replace 'simple' to your project name, in order to find your own jar files
#
COREJARS=$(unzip -Z1 $FLATJAR | grep simple | grep core | grep jar)
#echo $COREJARS

# extract your core jar
unzip -o $FLATJAR $COREJARS -d $COREDIR

# delete your core jar
zip -d $FLATJAR $COREJARS

# to embed
EMBED=""
for CJAR in $COREJARS
do
    EMBED="$EMBED -embed $COREDIR/$CJAR,protect"
done
#echo $EMBED

wine /usr/local/bin/j2ewiz.exe \
    -o $TARGET \
    -m "$2" \
    -jar "(empty-jar)" \
    -encrypt \
    -keepflat "$FLATJAR" \
    $EMBED \
    -amd64 \
    -platform linux

chmod +x $TARGET
