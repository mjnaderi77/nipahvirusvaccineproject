#!/usr/bin/env bash
set -euo pipefail

source config/config.env
cd "$RUN_DIR"

mkdir -p ../analysis

# RMSD: backbone
printf "Backbone\nBackbone\n" | "$GMX" rms \
    -s md.tpr \
    -f md_fit.xtc \
    -o ../analysis/rmsd_backbone.xvg \
    -tu ns

# RMSF: C-alpha
printf "C-alpha\n" | "$GMX" rmsf \
    -s md.tpr \
    -f md_fit.xtc \
    -o ../analysis/rmsf_ca.xvg \
    -res

# Radius of gyration
printf "Protein\n" | "$GMX" gyrate \
    -s md.tpr \
    -f md_fit.xtc \
    -o ../analysis/gyration.xvg

# SASA
printf "Protein\n" | "$GMX" sasa \
    -s md.tpr \
    -f md_fit.xtc \
    -o ../analysis/sasa.xvg \
    -tu ns

# Temperature, pressure and energies
printf "Temperature\n" | "$GMX" energy \
    -f md.edr \
    -o ../analysis/temperature.xvg

printf "Pressure\n" | "$GMX" energy \
    -f md.edr \
    -o ../analysis/pressure.xvg

printf "Potential\n" | "$GMX" energy \
    -f md.edr \
    -o ../analysis/potential_energy.xvg

printf "Kinetic-En.\n" | "$GMX" energy \
    -f md.edr \
    -o ../analysis/kinetic_energy.xvg

echo "Basic trajectory analysis finished."
echo "For H-bonds, use gmx hbond after defining the biologically meaningful donor/acceptor groups."
