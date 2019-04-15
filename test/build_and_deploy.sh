#!/usr/bin/env bash

set -e

files=("src/bin"/*)
bin_dir=to_send
mkdir -p $bin_dir 

for item in ${files[*]}
do
	file=$(basename $item .rs)
	printf ">> Build and deploy %s? " $file
	read -p "(y/n) " choice
	case "$choice" in 
	  y|Y ) cargo build --bin $file --target=armv7-unknown-linux-gnueabihf; \cp target/armv7-unknown-linux-gnueabihf/debug/$file $bin_dir ;;
  	  n|N ) echo "Skipping";;
  	  * ) echo "invalid. Skipping";;
	esac
	echo ""
done

scp $bin_dir/* pi@192.168.1.135:
rm -rf $bin_dir 
