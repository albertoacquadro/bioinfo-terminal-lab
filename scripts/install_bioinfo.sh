#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update

# Pacchetti base utili in un corso (download, archivi, compressioni)
sudo apt-get install -y --no-install-recommends \
  ca-certificates curl wget git unzip zip tar gzip bzip2 xz-utils \
  build-essential

# Tool bioinfo:
# - samtools per faidx e per SAM/BAM
# - fastp + fastqc per pulizia/valutazione qualità
# - bwa per allineamento (bwa-mem2 non disponibile via apt qui)
# - ncbi-blast+ per makeblastdb / blastn
sudo apt-get install -y --no-install-recommends \
  samtools bcftools vcftools \
  fastp fastqc \
  bwa \
  ncbi-blast+

# vcfutils.pl (se non presente nel PATH, lo installo)
if ! command -v vcfutils.pl >/dev/null 2>&1; then
  sudo apt-get install -y --no-install-recommends perl curl
  sudo curl -L -o /usr/local/bin/vcfutils.pl \
    https://raw.githubusercontent.com/samtools/bcftools/develop/misc/vcfutils.pl
  sudo chmod +x /usr/local/bin/vcfutils.pl
fi


# Verifiche “secche” (falliscono se manca qualcosa)
samtools --version | head -n 1
bcftools --version | head -n 1
vcftools --version | head -n 1

fastp --version
fastqc --version

bwa 2>&1 | head -n 1

makeblastdb -version | head -n 1
blastn -version | head -n 1

echo "OK: ambiente bioinfo installato."
