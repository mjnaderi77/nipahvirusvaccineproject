#!/usr/bin/env bash
set -euo pipefail

bash scripts/00_check_gromacs.sh
bash scripts/01_prepare_system.sh
bash scripts/02_em.sh
bash scripts/03_nvt.sh
bash scripts/04_npt.sh
bash scripts/05_md.sh
bash scripts/06_trajectory_cleanup.sh
bash scripts/07_analysis.sh

echo "FULL WORKFLOW COMPLETED"
