#!/bin/sh
# qdoIJ.sh is CLUSTER version of doIJ. 
# two arguments (macrofile and imgfile) are passed via -v option of qsub.
# ImageJ command out put will be redirected to /g/almf/<your username>/CLlog......txt
# script for single image file procesing by ImageJ 
# two arguments for full paths to (1) a macro file & (2) an image file is required 
# Author: Kota Miura (cmci.embl.de)
# First Release: 20101125
echo "*** Single Image File Processing with ImageJ ***"
#macrofile=$1
if [ -e "${macrofile}" ]
then
	echo ${macrofile}" ...macro to be used"
else
	echo ${macrofile}" ...no such macro file."
	exit 1
fi
#imgfile=$2
#if test -f ${imgfile}
if [ -e "${imgfile}" ]
then
	echo ${imgfile}" ...input image file"
else
	echo ${imgfile}" ...no such image file."
	exit 1
fi

# path to IJ jar file
IJJARS="/g/almf/software/ij"

#echo "IJ full-path ${IJJARS}/headless.jar"
echo "IJ full-path ${IJJARS}"

# Preparing Log file in your almf Home 
logfilename="CLlog"`date +%Y%m%d`"_"`date +%H%M`".txt"
#logfilename=${HOME}/${logfilename}
logfilename="/g/almf/"`whoami`"/"${logfilename}
echo ${logfilename}
echo `date` > ${logfilename}
echo "========== ImageJ Processsing Log ========== "
echo "Macro File... "${macrofile} >>  ${logfilename}
echo "Image File... "${imgfile} >>  ${logfilename}

#timer
jobstart=$(date +%s)
#jobstartN=$(date +%N)
#/usr/struct/bin/java -cp ${IJJARS}/headless.jar:${IJJARS}/ij-1.44h.jar -Djava.awt.headless=true ij.ImageJ -batch ${macrofile} ${imgfile}
/usr/struct/bin/java -cp ${IJJARS}/headless.jar:${IJJARS}/ij-1.44h.jar -Djava.awt.headless=true ij.ImageJ -ijpath ${IJJARS} -batch ${macrofile} ${imgfile} >> ${logfilename}
# timer
jobend=$(date +%s)
jobendN=$(date +%N)
echo "Time: $((jobend-jobstart)) secs."
echo "Time: $((jobendN-jobstartN)) nano-sec."
