# DNMT1i
These are the scripts I wrote in conducting analysis for the DNMT1i manuscript. Unless otherwise noted the 4 conditions used in this project were gNT-DMSO, gNT-DNMT1i, gRNF4-DMSO, & gRNF4-DNMT1i. The experiments for which I'm including analysis in this repo are:

ATACseq_220215: 4 conditions NT & gRNF4 both +/- DNMT1i conducted in triplicate. Processing and initial analysis was performed by NGB. These scripts for additional downstream analysis I performed in preparation and revision of the manuscript.

ChIPseq_AGRF2105: Original DNMT1 chip in the 4 conditions listed above, n=1. Processing and initial analysis was conducted by EYNL. These scripts are from the additional analysis I performed.

ChIPseq_250217: This is another chip for DNMT1 as follows, WT & CXXC both +/- drug n=2 and WT-gNT, WT-gRNF4, KR-gNT, KR-gRNF4 all +/- drug n=1. For this experiment I did all processing and analysis end-to-end with the included scripts.

ChIPseq_250627: These are chips of GFP-tagged DNMT1 in WT, NTC, UHRF1-KO, ∆RFTS, and ∆RC +/- drug. I conducted end-to-end processing for this experiment so all is included here.

ChIPseq_251009: Again chipping DNMT1 in WT and C∆W both w/ DMSO, dTAG & dTAG_DNMT1i. This is also one I did end-to-end analysis so all scripts are included.

EMseq_250417: Both WT and KR mutant in all 4 conditions listed above, n=2.

ExternalData_AZA_DAC_CRISPR: This is conducting analysis on a table and MAGECK counts from AZA and DAC CRISPR screen published by Johnstone lab https://www.nature.com/articles/s41375-020-0973-z

ExternalData_GSE145639: These scripts analyse raw data (and subsequent analysis) downloaded from GEO published in Epigenetic therapy induces transcription of inverted SINEs and ADAR1 dependency, Nature 2020 https://www.nature.com/articles/s41586-020-2844-1 

ExternalData_GSE209777: These scripts are analyzing raw data downloaded from GEO for RNAseq published in the TINPAT paper in Nat Com Oct 2023 https://www.nature.com/articles/s41467-023-42417-w

MassSpec: This experiment was conducted and data processed externally; these scripts are just doing downstream analysis on provided tables.

Nanopore_250821: Initial nanopore sequencing n=3 for just WT-DMSO & -DNMT1i conditions.

Nanopore_251013: Top up nanopore sequencing of just WT-DNMT1i condition, n=4.

RNAseq_210108: Original RNAseq performed in 4 conditions w/ n=3, initially processed and analysed by EYNL & NGB. My analysis consisted of re-aligning and processing the data with an editing-aware alignment to account for ADAR editing of reads particularly in intergenic regions and mintRNAs.

RNAseq_221222: Quadruple knockdown and quadruple NT in both DMSO & DNMT1i conditions. Also on the same sequencing run were cytoplasm and nuclear fractions of WT-DMSO & -DNMT1i conditions, n=2.

RNAseq_230105: Repeat of previous experiment w/ separate fractions for cytoplasm and nucleus in WT +/- drug, n=2.
