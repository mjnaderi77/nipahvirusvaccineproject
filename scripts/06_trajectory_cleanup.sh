#!/usr/bin/env bash
set -euo pipefail

source config/config.env
cd "$RUN_DIR"

mkdir -p ../analysis

# 1 = Protein, 0 = System is normally available in a standard index.
echo "Protein" | "$GMX" trjconv \
    -s md.tpr \
    -f md.xtc \
    -o md_noPBC.xtc \
    -pbc mol \
    -center

echo "Protein" | "$GMX" trjconv \
    -s md.tpr \
    -f md_noPBC.xtc \
    -o md_fit.xtc \
    -fit rot+trans

echo "Protein" | "$GMX" trjconv \
    -s md.tpr \
    -f md.gro \
    -o md_final_protein.gro \
    -pbc mol \
    -center

echo "Trajectory cleanup finished."
