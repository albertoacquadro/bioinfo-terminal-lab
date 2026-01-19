#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update

# Pacchetti base utili in un corso (download, archivi, compressioni)
sudo apt-get install -y --no-install-recommends \
  ca-certificates curl wget git unzip zip tar gzip bzip2 xz-utils \
  build-essential

# Tool bioinfo che compaiono nei tuoi moduli:
# - samtools per faidx e per SAM/BAM :contentReference[oaicite:5]{index=5} :contentReference[oaicite:6]{index=6}
# - fastp + fastqc per pulizia/valutazione qualità :contentReference[oaicite:7]{index=7}
# - bwa-mem2 per allineamento :contentReference[oaicite:8]{index=8}
# - ncbi-blast+ per makeblastdb / blastn :contentReference[oaicite:9]{index=9}
sudo apt-get install -y --no-install-recommends \
  samtools bcftools vcftools \
  fastp fastqc \
  bwa-mem2 \
  ncbi-blast+

# Verifiche “secche” (falliscono se manca qualcosa)
samtools --version | head -n 1
bcftools --version | head -n 1
vcftools --version | head -n 1

fastp --version
fastqc --version

bwa-mem2 version

makeblastdb -version | head -n 1
blastn -version | head -n 1

echo "OK: ambiente bioinfo installato."
