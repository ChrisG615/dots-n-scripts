#! /bin/bash
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

echo "${BOLD}Would you like to use a default drive configuration or to create a custom layout?

${NORMAL}The default partition layout is:
100M   - boot partition           /dev/sdX1
\$SWAP  - user specified swap file /dev/sdX2
root   - remainder of the drive   /dev/sdX3"
echo ""
echo "${BOLD}Choosing a custom layout will launch cgdisk or exit to use the tool of your choosing.
After configuring the partitions you will need to mount the partitions manually and re-run this script.

Please choose from the options below:
1. Default Partition Layout
2. Custom Partition Layout
"
# Prompt for choice
function 
read -p "Make your selection by entering the number " CHOICE
echo "You have chosen $CHOICE"
if [ $CHOICE == 1 ]; then
    DEFAULT_PART
elif [ $CHOICE == 2 ]; then
    read -p "Which partitioning app would you like to use? Enter it here (eg. cfdisk):" PART_APP
    echo "You have chosen $PART_APP. Launching now..."
    exec $PART_APP
else 
    echo "Invalid selection."
fi


function DEFAULT_PART() {
    read -p "Disk to use: eg. /dev/sda" DISK
    echo "${BOLD}WARNING!! ${NORMAL}You have selected $DISK!
    Continuing will completely delete all data and partitions on the selected drive.
    Default option is to continue"
    read -p "Continue? (Y/n)" CONT
    echo "$DISK
