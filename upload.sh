#!/bin/bash
# Load configuration
. "$(dirname "$0")"/config.sh

# Set constants
FTP_COMMAND="wput -R -u"
CURR_DATE=`date +%Y%m%d`

# Loop through directory
for d in "$BASE_DIR"*
do
    # Check item is a directory
    if [ -d "$d" ] && [ "$(basename "$d")" -ne "$CURR_DATE" ]; then
        #echo $FTP_COMMAND $d $FTP_URL;
        # FTP to server
        $FTP_COMMAND "$d" $FTP_URL;
        # Check exit status from FTP, 0 = success
        if [ $? -eq 0 ]; then
            # Remove directory
            rm -r "$d";
        else
            echo "$d" failed to upload;
        fi
    fi
done
