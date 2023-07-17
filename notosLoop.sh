#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 12
#SBATCH --mem 48G

module load r

for genus in $(cat faList.txt)
do
        perl ~/path/to/notos-master/CpGoe.pl -f $genus.fa -a 1 -c CpG -o $genus.cpgoe.csv
        Rscript ~/path/to/notos-master/KDEanalysis.r "$genus" $genus.cpgoe.csv -B \
                -p $genus.modes_basic_stats.csv -k $genus.KDE.pdf \
                -s $genus.modes_bootstrap.csv -H $genus.modes_bootstrap.csv \
                -C $genus.modes_bootstrap.csv
done
