#!/bin/bash


#gdive get from
# https://github.com/prasmussen/gdrive
# 

gdrive="./gdrive"
LOGFILE="./gdrive.log"
PATH_TO_SOURCE_DIR="/home/user/Arc"
LISTFILE="/tmp/mylist.txt"
COUNT_DAY=30 


# TESTING=YES
TESTING=NO
 


function upload2gooledrive 
{
local my_file=$1
local my_folder_ID=$2
 echo $my_file
# echo $my_folder_ID

#for testing
if [[ $TESTING == "YES" ]]; then
	 touch $my_file
fi
	
	
 
if [ -f $my_file ] ; then
    #echo "file exist..."
    # echo $my_file
  	# option --delete : Delete local file when upload is successful  
    $gdrive upload -p $my_folder_ID $my_file --delete >> $LOGFILE
# else
# 	echo "file not exist...  :("
fi

}


function removeoldfiles {

COUNTSEC=$((60*60*24*$COUNT_DAY))
TODAY=$(date +%Y-%m-%d)



if [ -f $LISTFILE ] ; then
    rm $LISTFILE
fi

$gdrive list > $LISTFILE

# IFS=" "
while read var0 var1 var2 var3 var4 var5 var6 var7
do
	# 
	s=$var0$var1$var2$var3$var4$var5$var6$var7
	# echo $s

		# DD=$((`date -d "$var3" '+%s'`))
		# [[ "$DD" ]] && echo "$DD" || echo "Empty var!";
		# echo $var0
		# echo $var3


	if [[ (${var1: -3} = "zip") || (${var1: -2} = "dt")    ]]; then   # zip and dt only

		
		DATE_FILE=${s: -18:10}
		if [[ $TESTING == "YES" ]]; then
			echo $DATE_FILE
		fi	
			SDIFF=$((`date -d "$TODAY" '+%s'` - `date -d "$DATE_FILE" '+%s'`  - $COUNTSEC ))
			if [[ "$SDIFF" -gt '0'  ]]; then
				if [[ $TESTING == "YES" ]]; then
	 				echo УДАЛЯЕМ
	 				echo $var1
				fi
		 		
		 		$gdrive delete var0 >> $LOGFILE
 			else
 				if [[ $TESTING == "YES" ]]; then
 					echo НЕ УДАЛЯЕМ
					echo $var1
				fi
 			fi
			 
		# fi
	fi

done < $LISTFILE


if [ -f $LISTFILE ] ; then
    rm $LISTFILE
fi




}





echo $(date -R) " start upload">> $LOGFILE


#1c83

##################################################
#Name of file 1c 8 without date
name_file="lph83"
#Name of directory, where is nust be file 1c 8 

# id of foler in google drive (get it run in cosole "gdrive -list"
ID="0B1aaCP_qcOxoVE1vaWczblJEeHM"  


file_for_copy=$PATH_TO_SOURCE_DIR/$name_file'_'$(date +%Y-%m-%d).dt
upload2gooledrive $file_for_copy $ID


###################################################



# 1c77

###################################################

name_file="lph77"

ID="0B1aaCP_qcOxoUVFhMlFlanFacUk"


file_for_copy=$PATH_TO_SOURCE_DIR/$name_file'_'$(date +%Y-%m-%d).zip
upload2gooledrive $file_for_copy $ID


###################################################



# 1c lF Traide

###################################################

name_file="lt"

ID="0B1aaCP_qcOxoQkZzZWxPcXd2Sms"


file_for_copy=$PATH_TO_SOURCE_DIR/$name_file'_'$(date +%Y-%m-%d).zip
upload2gooledrive $file_for_copy $ID

###################################################


echo $(date -R) " finish upload">> $LOGFILE



removeoldfiles