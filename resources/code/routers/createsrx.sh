#! /bin/bash
# syntax is
# ./createsrx.sh 1.1.1.1 2.2.2.2 configfile 
sed "s/tun1address/$1/g" srxtemplate.txt > $3
sed -i "s/tun2address/$2/g" $3

