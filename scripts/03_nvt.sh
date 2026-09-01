#!/usr/bin/env bash
set -euo pipefail

source config/config.env
cd "$RUN_DIR"

"$GMX" grompp \
    -f "../../mdp/nvt.mdp" \
    -c em.gro \
    -r em.gro \
    -p topol.top \
    -o nvt.tpr \
    -maxwarn 0

"$GMX" mdrun \
    -deffnm nvt \
    -v \
    2>&1 | tee "../../$LOG_DIR/nvt.log"

echo "NVT equilibration finished."
