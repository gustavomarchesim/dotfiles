#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#0f121c/g' \
         -e 's/rgb(100%,100%,100%)/#47add6/g' \
    -e 's/rgb(50%,0%,0%)/#181b28/g' \
     -e 's/rgb(0%,50%,0%)/#47add6/g' \
 -e 's/rgb(0%,50.196078%,0%)/#47add6/g' \
     -e 's/rgb(50%,0%,50%)/#131621/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#131621/g' \
     -e 's/rgb(0%,0%,50%)/#47add6/g' \
	"$@"