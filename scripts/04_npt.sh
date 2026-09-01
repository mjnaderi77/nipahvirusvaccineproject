#!/usr/bin/env bash
set -euo pipefail

source config/config.env
cd "$RUN_DIR"

"$GMX" grompp \
    -f "../../mdp/npt.mdp" \
    -c nvt.gro \
    -r nvt.gro \
    -t nvt.cpt \
    -p topol.top \
    -o npt.tpr \
    -maxwarn 0

"$GMX" mdrun \
    -deffnm npt \
    -v \
    2>&1 | tee "../../$LOG_DIR/npt.log"

echo "NPT equilibration finished."
