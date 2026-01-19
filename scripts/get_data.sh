#!/usr/bin/env bash
set -euo pipefail

mkdir -p data

# INCOLLA QUI i 3 link "Download" di Zenodo (uno per file)
ST1_URL="INCOLLA_LINK_DOWNLOAD_DI_st1.fastq"
ST2_URL="INCOLLA_LINK_DOWNLOAD_DI_st2.fastq"
REF_URL="INCOLLA_LINK_DOWNLOAD_DI_Ref122.fasta"

echo "Scarico st1.fastq..."
curl -L "$ST1_URL" -o data/st1.fastq

echo "Scarico st2.fastq..."
curl -L "$ST2_URL" -o data/st2.fastq

echo "Scarico Ref122.fasta..."
curl -L "$REF_URL" -o data/Ref122.fasta

echo "Controllo file..."
ls -lh data
