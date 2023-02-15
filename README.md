# CpG observed/expected

## Manual mean CpG observed/expected calculations
From http://htmlpreview.github.io/?https://github.com/hputnam/EastOyEpi/blob/master/02-Cpg-test.html  
_See_ MeanManualCpG.sh

## Manual CpG observed/expected ratio for individual contigs
From http://htmlpreview.github.io/?https://github.com/hputnam/EastOyEpi/blob/master/02-Cpg-test.html  
_See_ ManualCpG.sh

## Notos
https://github.com/cche/notos  
Bulla, I., Aliaga, B., Lacal, V., Bulla, J., Grunau, C. and Chaparro, C., 2018. Notos-a galaxy tool to analyze CpN observed expected ratios for inferring DNA methylation types. BMC bioinformatics, 19(1), pp.1-13.
#### Installation
```
git clone https://github.com/cche/notos.git
chmod u+x notos
```

## Notos Loop
https://github.com/cche/notos  
Requires list of genomes
```
#make list of fasta files
ls *.fa > faList.txt
#remove ".fa"
vim faList.txt # :%s/.fa//g :x
```

### Calculate mean CpG o/e from notos
```
wc -l $genome_cpgoe.csv
awk '{SUM+=$2}END{print SUM}' $genome_cpgoe.csv > $genome_sum_cpg
vim $genome_sum_cpg # after sum value, tab, then add wc -l number
awk '{print "Consensus CpG", "\t", ($1/$2)}' $genome_sum_cpg > $genome_mean_cpg.txt
less $genome_mean_cpg.txt
```
