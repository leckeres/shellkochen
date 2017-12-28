#!/usr/bin/env bash
echo "expects two parameters, first one the parent folder, second one the folder to actually rename"
echo "cannot be really used, it is just a snippet for demo purposes"

# we need to have this parent directory and the directory to rename, otherwise we must do so many string operations to find out the directory name.
# there must be a better way!
cd $1 || exit 1

echo "work on parent folder $1"

cd $2 || exit 1
echo "working on folder $2 which will be renamed in the process"

#now we store all files of the folder in the 'files' variable, cleanly sorted!
files=$(ls -t -r -m)
echo "files sorted by oldest file first, comma separated"
echo $files
filesarray=( $files )

#read out the first file from the array (it is the oldest!) and cut away the ugly trailing comma.
#did I mention that I expect that there are better ways to do all of this?
echo "oldest file"
oldestfile=${filesarray[0]}
oldestfile_without_trailing_comma=${oldestfile:: -1}
echo $oldestfile_without_trailing_comma

#now put the change date of the file into a variable and only use the date part of it
#maybe there is a formatting option to only have the yyyy-mm-dd format of the change date? Didn't find it quickly enough...
changedate=$(stat -c %y  $oldestfile_without_trailing_comma)
onlydate=${changedate:0:10}
echo "oldest file is from: $onlydate"

#now be bold: rename the folder!
newfoldername=$onlydate"_"$2
echo "renaming folder $2 to $newfoldername..."
cd ..
mv $2 $newfoldername
echo "done."
