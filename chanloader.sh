#!/bin/bash

#################################
#           Coded by            #
# 33ndgr - d3v1lgr33n@gmail.com #
# https://github.com/33ndgr     #
#################################

GREEN='\033[0;34m'
NC='\033[0m'
YELL='\033[1;33m'

# Data from keyboard. Haven't made an input check, won't work if not $
echo -n -e "${GREEN}Board (i.e., wg, b, g, etc.):${NC} "
read board

echo -n -e "${GREEN}Thread id (i.e., http://boards.4chan.org/wg/*** This num ***/):${NC} "
read thread

echo -n -e "${GREEN}Files? (i.e., webm, png, jpg, etc.):${NC} "
read format

echo -e "${YELL}Working...${NC}"
# URL html downloader and filter
wget -q -O chanlines http://boards.4chan.org/$board/thread/$thread/
# That awk erases odd lines. Duplicated data from the html.
grep -E -o "i.4cdn.org/$board/[0-9]{13}.$format" chanlines | awk 'NR $
rm chanlines

# End directory creator.
mkdir "$board"_"$thread"_"$format"
mv chanlines_filtered "$board"_"$thread"_"$format"
cd "$board"_"$thread"_"$format"

# Loop (Travels each processed file line and directly downloads the U$
lines=$(cat chanlines_filtered | wc -l)

for ((i=1; i<=$lines; i++))
do
        img=$(sed -n "$i"p chanlines_filtered)
        echo -e "${YELL}$i/$lines downloaded${NC}"
        wget -q $img
done

rm chanlines_filtered
cd      

exit 0
