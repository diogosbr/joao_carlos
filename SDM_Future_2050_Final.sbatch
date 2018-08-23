#!/bin/sh 

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH -p mesca2
#SBATCH -J sdm.future
#SBATCH --time=48:00:00

module load R/3.4.3_gnu
module load openmpi/1.10_gnu

export R_LIBS_USER='/scratch/ebiodiv/diogo.rocha/R_gnu'  

export LD_LIBRARY_PATH="/scratch/ebiodiv/diogo.rocha/geos/lib:$LD_LIBRARY_PATH" 
export PATH="/scratch/ebiodiv/diogo.rocha/geos/bin:$PATH" 

module load gdal/2.1.2 
module load proj-4/9.3 
module load java/jdk-8u102 

export JAVA_HOME="/scratch/app/java/jdk1.8.0_102/jre" 
export JAVA="/scratch/app/java/jdk1.8.0_102/jre/bin/java" 
export JAVAC="/scratch/app/java/jdk1.8.0_102/bin/javac" 
export JAVAH="/scratch/app/java/jdk1.8.0_102/bin/javah" 
export JAR="/scratch/app/java/jdk1.8.0_102/bin/jar" 
export JAVA_INCLUDE_DIR="/scratch/app/java/jdk1.8.0_102/include"
export JAVA_LD_LIBRARY_PATH="/scratch/app/java/jdk1.8.0_102/lib" 
export _JAVA_OPTIONS="-XX:ParallelGCThreads=2 -Xmx20g"
ulimit -c unlimited

export PATH=/scratch/app/java/jdk1.8.0_102/bin:$PATH
export LD_LIBRARY_PATH=/scratch/app/java/jdk1.8.0_102/jre/lib/amd64:/scratch/app/java/jdk1.8.0_102/jre/lib/amd64/server:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH="/scratch/ebiodiv/diogo.rocha/geos/lib:$LD_LIBRARY_PATH"
export PATH="/scratch/ebiodiv/diogo.rocha/geos/bin:$PATH"

${PWD}/SDM_Future_2050_Final.R