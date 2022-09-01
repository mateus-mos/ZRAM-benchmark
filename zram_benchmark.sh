#!/usr/bin/env bash

cat ./zram_art.txt
echo 
echo

while getopts s: flag
do
    case "${flag}" in
        s) zram_size=${OPTARG};;
        *) error "Invalid option ${flag}" ;;
    esac
done

if [ -z "$zram_size" ];
then
    echo "[zram benchmark] Invalid size for ZRAM! -s argument "
    exit 1
fi

echo 
echo "[zram benchmark] Preparing ZRAM benchmark... "
echo
echo "[zram benchmark] ZRAM SIZE: $zram_size "

# Reset Swap space 
sudo swapoff -a
sudo swapon -a

# Create a ZRAM space with specified size
unused_zram_device=$(sudo zramctl --find --size $zram_size) # find a new zram device and initialize it based on zram size flag 

echo "[zram benchmark] ZRAM DEVICE: $unused_zram_device " 

sudo mkswap $unused_zram_device # set up a Linux swap area

echo "[zram benchmark] $unused_zram_device set up " 

sudo swapon $unused_zram_device 

echo "[zram benchmark] $unused_zram_device enabled! " 




