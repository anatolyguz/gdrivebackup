#!/bin/bash


#gdive get from
# https://github.com/prasmussen/gdrive
# 



grive="/home/user/BASH/gdrive"
LOGFILE="/home/user/BASH/gdrive.log"
 


function upload2gooledrive 
{
local my_file=$1
local my_folder_ID=$2
# echo $my_file
# echo $my_folder_ID

#for testing
# touch $my_file

if [ -f $my_file ] ; then
    #echo "file exist..."
  	# option --delete : Delete local file when upload is successful  
    $grive upload -p $my_folder_ID $my_file --delete >> $LOGFILE
# else
# 	echo "file not exist...  :("
fi

}



echo $(date -R) " start upload">> $LOGFILE

#Name of file 1c 8 without date
lph8="lph83"
#Name of directory, where is nust be file 1c 8 
dirlph8="/home/user"
# id of foler in google drive (get it run in cosole "gdrive -list"
ID8="0B1aaCP_qcOxoVE1vaWczblJEeHM"  


file_for_copy=$dirlph8/$lph8-$(date +%Y-%m-%d).dt
upload2gooledrive $file_for_copy $ID8



lph7="lph77"
dirlph7="/home/user"
ID7="0B1aaCP_qcOxoUVFhMlFlanFacUk"


file_for_copy=$dirlph7/$lph7-$(date +%Y-%m-%d).zip
upload2gooledrive $file_for_copy $ID7




echo $(date -R) " finish upload">> $LOGFILE
