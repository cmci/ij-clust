#!/bin/sh
#script for single image file procesing by Fiji (Fiji is just ImageJ)
#two arguments required for full path to each of 
#     (1) a jython script (maybe javascript also possible, but not tested)
#     (2) an image file (this could be a directory as well)
# so the command should look like
#     sh doFJ.sh <path-to-script> <path-to-directory or a file>
#Kota Miura (cmci.embl.de)
#201120208
echo "*** Processing with Fiji ***"
filepath=$2
#if test -f ${filepath}
if [ -e "${filepath}" ]
then
	echo ${filepath}" ...input file path" 
else
	echo ${filepath}" ...file path missing in argument, or no such file or directory"
	exit 1
fi
script=$1
#if test -f ${script}
if [ -e "${script}" ]
then
	echo ${script}" ...macro to be used"
else
	echo ${script}" ...no such script file."
	exit 1
fi
# path to Fiji
FIJI="/g/almf/software/bin2/fiji"

#echo "IJ full-path ${IJJARS}/headless.jar"
echo "Fiji full-path ${FIJI}"

# Preparing Log file in your almf Home 
logfilename="CLlog"`date +%Y%m%d`"_"`date +%H%M`".txt"
#logfilename=${HOME}/${logfilename}
logfilename="/home/"`whoami`"/"${logfilename}
echo ${logfilename}
echo `date` > ${logfilename}
echo "========== ImageJ Processsing Log ========== "
echo "Macro File... "${macrofile} >>  ${logfilename}
echo "Image File... "${imgfile} >>  ${logfilename}

#timer
jobstart=$(date +%s)
#jobstartN=$(date +%N)
#/usr/struct/bin/java -cp ${IJJARS}/headless.jar:${IJJARS}/ij-1.44h.jar -Djava.awt.headless=true ij.ImageJ -batch ${script} ${filepath}
#/usr/struct/bin/java -cp ${IJJARS}/headless.jar:${IJJARS}/ij-1.44h.jar -Djava.awt.headless=true ij.ImageJ -ijpath ${IJJARS} -batch ${script} ${filepath}
${FIJI} --headless -batch ${script} ${filepath} >> ${logfilename}
# timer
jobend=$(date +%s)
jobendN=$(date +%N)
echo "Time: $((jobend-jobstart)) secs."
#echo "Time: $((jobendN-jobstartN)) nano-sec."
