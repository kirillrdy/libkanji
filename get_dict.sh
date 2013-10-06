wget -c http://ftp.monash.edu.au/pub/nihongo/edict2.gz
zcat edict2.gz > edict2
iconv -feuc-jp -tutf-8 edict2 > edict2_utf8
