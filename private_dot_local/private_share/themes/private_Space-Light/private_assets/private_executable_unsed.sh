#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#FBF8EF/g' \
         -e 's/rgb(100%,100%,100%)/#655370/g' \
    -e 's/rgb(50%,0%,0%)/#e7e5eb/g' \
     -e 's/rgb(0%,50%,0%)/#d3d3e7/g' \
 -e 's/rgb(0%,50.196078%,0%)/#d3d3e7/g' \
     -e 's/rgb(50%,0%,50%)/#FBF8EF/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#FBF8EF/g' \
     -e 's/rgb(0%,0%,50%)/#655370/g' \
	"$@"
