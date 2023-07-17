#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 2
#SBATCH --mem 20G

export genome="genome"
head -2 $genome.fa
echo
echo number of seqs =
grep -c ">" $genome.fa #count total number of sequences

grep -v "^>" $genome.fa | awk 'BEGIN {ORS=""; print ">Concatenated__catalog\n"} {print}' > $genome.concat.fa #combine into one sequence

echo number of seqs =
fgrep -c ">" $genome.concat.fa #count total number of sequences - should now be 1
head --bytes=500 $genome.concat.fa

perl -e '$count=0; $len=0; while(<>) {s/\r?\n//; s/\t/ /g; if (s/^>//) { if ($. != 1) {print "\n"} s/ |$/\t/; $count++; $_ .= "\t";} else {s/ //g; $len += length($_)} print $_;} print "\n"; warn "\nConverted $count FASTA records in $. lines to tabular format\nTotal sequence length: $len\n\n";' $genome.concat.fa | cut -f1,3 > ./$genome.fasta2tab #change format to tab

head --bytes=500 $genome.fasta2tab
tail --bytes=500 $genome.fasta2tab

perl -e '$col = 1;' -e 'while (<>) { s/\r?\n//; @F = split /\t/, $_; $len = length($F[$col]); print "$_\t$len\n" } warn "\nAdded column with length of column $col for $. lines.\n\n";' $genome.fasta2tab > ./$genome.tab_1 #add extra column per line with number of base pairs for that read
head --bytes=500 $genome.tab_1
tail --bytes=500 $genome.tab_1

awk '{print $2}' $genome.tab_1 > $genome.tab_2 #take the sequence column from tab_1 and put it into a new file, tab_2

#do the CG, C and G counts
echo "CG" | awk -F\[Cc][Gg] '{print NF-1}' $genome.tab_2 > $genome.CG
echo "C" | awk -F\[Cc] '{print NF-1}' $genome.tab_2 > $genome.C
echo "G" | awk -F\[Gg] '{print NF-1}' $genome.tab_2 > $genome.G

paste $genome.tab_1 \
       $genome.CG \
       $genome.C \
       $genomeG \
       > $genome.comb #combine into one file into the correct column
head --bytes=500 $genome.comb
tail --bytes=500 $genome.comb

awk '{print $1, "\t", (($4)/($5*$6))*(($3^2)/($3-1))}' $genome.comb > $genome.ID_CpG #do the maths
head --bytes=500 $genome.ID_CpG
