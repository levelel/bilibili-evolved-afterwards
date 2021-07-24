#!/bin/bash
#Author: levelel
#Date: 2021-07-01
#Github: https://github.com/levelel/bilibili-evolved-afterwards
#Filename: mergeflv.sh
#Description: Merge video files that downloaded via bilibili-evolved
#   The orignal names are like: 02 - 影子籃球員27-在冬季選拔賽上 - 06.flv
#   after running the program, they should be combined and renamed as 02 - 影子籃球員27-在冬季選拔賽上.flv
#Usage:
    # download the mergeflv.sh file
    # copy it to the target folder
    # run it by: sudo bash mergeflv.sh

if ! ls * | grep -sqm1 '\- 02.flv'; then #grep 不报错，静默，找到一个即停止, '-'需要escape
	exit
elif [ ! -x "/usr/bin/ffmpeg" ]; then # -x to check if ffmpeg is executable
	echo "Could not execute /usr/bin/ffmpeg"
	exit
else
	:
fi

processed=/tmp/processed.tmp
input_file_list=./input_file_list.tmp
finished_folder=./finished_folder

:>$processed # null command (:) redirect (> filename) trick (:>), this will truncate to zero or create the named file. # same as 'touch somefile'
:>$input_file_list

mkdir $finished_folder &> /dev/null # &> or >& /dev/null, to throw the output away if any error
set -x # set - Set or unset values of shell options and positional parameters. - x,
        # to print commands and their arguments as they are executed.


SAVEIFS=$IFS
IFS=$(echo -en "\n\b")  # change delimiter from \s to \n\b, otherwise F would be part of the whole name if file name has spaces
for F in `find . -maxdepth 1 -type f -regex '.\/.* - [0-9]+\.flv'`; do
    # 去头去尾
    output_file_name="${F% - *[0-9][0-9].flv}"         # ${F%pattern}, remove '- xx.flv' from the end, shortest match
    output_file_name="${output_file_name#.\/}"         # ${F#pattern}, remove './' from the beginning, shortet match
    count=`ls *.flv | grep -Fc "$output_file_name"`

    # check if the video has only one part, if yes, it does not need to merge
    if [ ${count} -le 1 ]; then
		continue
	fi

    # if it has multiple parts, and 
    # if it is not in the processed file list, write it into the processed list
    if ! cat $processed | grep -Fsqm1 "$output_file_name"; then
        # put file name in processed list
        echo $output_file_name >> $processed

        # put to-be-combined file names into input file
        file_list=()
        set +x
        for line in `ls --sort version *.flv | grep -F "$output_file_name"`; do
            echo "file '$line'" >> $input_file_list
            file_list+=($line)
        done
        set -x
        echo file_list

        # merge files to single flv. Not converting to mp4 or mkv for best compatibility
        if [ ! -f "${output_file_name}.flv" ]; then
            # -safe 0, for file names that contain special characters
            # -n, means don't overwrite existed file
            /usr/bin/ffmpeg -f concat -safe 0 -i "${input_file_list}" -n -c copy "${output_file_name}.flv"
            # move part files to finished folder. so you can simply delete the folder
            for file in ${file_list[@]}; do
                mv "$file" "$finished_folder"
            done
        fi
        
        # clear file_list
        unset file_list


        # clear the input file
        :>$input_file_list
    fi
done
IFS=$SAVEIFS # change delimiter back

# clean up temp file
rm $input_file_list

# turn off "set -x"
set +x