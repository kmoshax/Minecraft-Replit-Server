#!/bin/bash

oldfile=mc_srv
newfile=backup.zip

month=`date +%B`
year=`date +%Y`

prefix="backup"

archivefile=$prefix.$month.$year.tar

# Check for existence of a compressed archive matching the naming convention
if [ -e $archivefile.gz ]
then
    echo -e "\e[1;33mkmosha@script~\e[0m" Backup $archivefile arlready exist...
    echo -e "\e[1;33mkmosha@script~\e[0m" Adding file $oldfile to existing backup
    gunzip $archivefile.gz
    tar --append --file=$archivefile $oldfile
    gzip $archivefile

else
    echo -e "\e[1;33mkmosha@script~\e[0m" Creating new backup file '$archivefile'...
    tar --create --file=$archivefile $oldfile
    gzip $archivefile
fi

mv $newfile $oldfile