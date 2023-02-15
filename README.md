# CpG observed/expected

## Manual mean CpG observed/expected calculations
From http://htmlpreview.github.io/?https://github.com/hputnam/EastOyEpi/blob/master/02-Cpg-test.html  
_See_ MeanManualCpG.sh

## Manual CpG observed/expected ratio for individual contigs
From http://htmlpreview.github.io/?https://github.com/hputnam/EastOyEpi/blob/master/02-Cpg-test.html  
_See_ ManualCpG.sh

## Notos
https://github.com/cche/notos  
#### Installation
```
git clone https://github.com/cche/notos.git
chmod u+xq
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
