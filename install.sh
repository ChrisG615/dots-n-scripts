#!/bin/bash

# We are going to write this out in psudo code and then go back and fill it in with real code
# Step 1; We need to check to see if a disk(s) partition(s) are mounted at /mnt already
# This is due to there being an option to create your own partition table using cgdisk

# enter code here


# Step 2; Check for network connectivity

if ping -q -c 1 -W 1 www.google.com > /dev/null; then
    echo "The netowrk is up"
else
    echo "No network connection detected"
    echo "Please ensure you are connected before re-running this script"
fi

# Set the system clock

echo "Would you like to enable NTP?"
echo "1: Yes"
echo "2: No"
echo "Please enter 1 or 2"

read CLOCK_VAL

if [ $CLOCK_VAL == 1 ]; then 
    timedatectl set-ntp true
else
    echo "Bypassing NTP option"
fi

# No for partitioning the disks
# The code will do the following:
#   Show a listing of all disks attached to the system
lsblk

# Ask the user if they want a default single partition with a swap partition or to create a custom layout

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
echo "${BOLD}Would you like to use a default drive configuration or to create a custom layout?

The default partition layout is:
${NORMAL}100M   - boot partition           /dev/sdX1
\$SWAP - user specified swap file /dev/sdX2
root   - remainder of the drive   /dev/sdX3"
echo ""
echo "${BOLD}Choosing a custom layout will launch cgdisk.
After configuring the partitions you will need to mount the partitions manually and re-run this script.
"

# This function will set a default layout for a selected disk

function DEFAULT_PART() {
    read -p "Disk to use: ex /dev/sda" DISK


