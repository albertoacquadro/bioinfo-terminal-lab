#!/usr/bin/env bash
set -euo pipefail

echo "== tools =="
command -v samtools >/dev/null && samtools --version | head -n 1
command -v bcftools >/dev/null && bcftools --version | head -n 1
command -v vcftools >/dev/null && vcftools --version | head -n 1

command -v fastp >/dev/null && fastp --version
command -v fastqc >/dev/null && fastqc --version

command -v bwa-mem2 >/dev/null && bwa-mem2 version

command -v makeblastdb >/dev/null && makeblastdb -version | head -n 1
command -v blastn >/dev/null && blastn -version | head -n 1

echo "OK"
