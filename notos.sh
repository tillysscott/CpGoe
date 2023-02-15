#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 12
#SBATCH --mem 48G

export genome="Genome"

perl ~/sharedscratch/apps/notos-master/notos-master/CpGoe.pl -f $genome.fa -a 1 -c CpG -o $genome.csv

module load r

Rscript ~/sharedscratch/apps/notos-master/notos-master/KDEanalysis.r "$genome" $genome.csv -B
