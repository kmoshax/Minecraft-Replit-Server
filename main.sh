#!/bin/bash
FILE=backup.me
if [ -f $FILE ]; then
   echo -e "\e[1;33mkmosha@script~\e[0m" Starting backup script...
   bash backup.sh
   rm backup.me
else
   echo 
fi

FILE=server.sh
if [ -f $FILE ]; then
   bash server.sh
else
   bash installer.sh
fi