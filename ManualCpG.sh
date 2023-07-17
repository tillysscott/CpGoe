#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH -c 2
#SBATCH --mem 20G


head -2 genome.fa
echo
echo number of seqs =
fgrep -c ">" genome.fa #count total number of sequences

perl -e '$count=0; $len=0; while(<>) {s/\r?\n//; s/\t/ /g; if (s/^>//) { if ($. != 1) {print "\n"} s/ |$/\t/; $count++; $_ .= "\t";} else {s/ //g; $len += length($_)} print $_;} print "\n"; warn "\nConverted $count FASTA records in $. lines to tabular format\nTotal sequence length: $len\n\n";' genome.fa | cut -f1,3 > ./fasta2tab #change format to tab

head -2 fasta2tab

perl -e '$col = 1;' -e 'while (<>) { s/\r?\n//; @F = split /\t/, $_; $len = length($F[$col]); print "$_\t$len\n" } warn "\nAdded column with length of column $col for $. lines.\n\n";' fasta2tab > ./tab_1 #add extra column per line with number of base pairs for that read
head -2 tab_1

awk '{print $2}' tab_1 > tab_2 #take the sequence column from tab_1 and put it into a new file, tab_2

#do the CG, C and G counts
echo "CG" | awk -F\[Cc][Gg] '{print NF-1}' tab_2 > CG
echo "C" | awk -F\[Cc] '{print NF-1}' tab_2 > C
echo "G" | awk -F\[Gg] '{print NF-1}' tab_2 > G

paste tab_1 \
       CG \
       C \
       G \
       > comb #combine into one file into the correct column
head -2 comb

awk '{print $1, "\t", (($4)/($5*$6))*(($3^2)/($3-1))}' comb > ID_CpG #do the maths
head ID_CpG
