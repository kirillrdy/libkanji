#!/bin/sh
set -e
wget -c http://ftp.monash.edu.au/pub/nihongo/edict2.gz
gunzip edict2.gz
iconv -f euc-jp -t utf-8 edict2 > edict2_utf8
rm edict2
