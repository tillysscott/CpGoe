#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 12
#SBATCH --mem 48G

module load r

for genus in $(cat faList.txt)
do
        Rscript ~/sharedscratch/apps/notos-master/notos-master/KDEanalysis.r "$genus" $genus.cpgoe.csv -B \
                -p $genus.modes_basic_stats.csv -k $genus.KDE.pdf \
                -s $genus.modes_bootstrap.csv -H $genus.modes_bootstrap.csv \
                -C $genus.modes_bootstrap.csv
done
