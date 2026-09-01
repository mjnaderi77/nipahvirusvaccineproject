#!/usr/bin/env bash
set -euo pipefail

source config/config.env
cd "$RUN_DIR"

"$GMX" grompp \
    -f "../../mdp/minimization.mdp" \
    -c solv_ions.gro \
    -p topol.top \
    -o em.tpr \
    -maxwarn 0

"$GMX" mdrun \
    -deffnm em \
    -v \
    2>&1 | tee "../../$LOG_DIR/em.log"

echo "Energy minimization finished."
echo "Check the final potential energy and Fmax before proceeding."
