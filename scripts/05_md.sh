#!/usr/bin/env bash
set -euo pipefail

source config/config.env
cd "$RUN_DIR"

# Calculate production steps from ns and timestep.
python3 - <<'PY'
from pathlib import Path
p = Path("../../mdp/md.mdp")
text = p.read_text()
import os
ns = float(os.environ.get("PRODUCTION_NS", "150"))
dt = float(os.environ.get("DT_PS", "0.002"))
steps = int(round(ns * 1000.0 / dt))
lines=[]
for line in text.splitlines():
    if line.strip().startswith("nsteps"):
        lines.append(f"nsteps                  = {steps}")
    else:
        lines.append(line)
p.write_text("\n".join(lines) + "\n")
print(f"Production: {ns} ns, dt={dt} ps, nsteps={steps}")
PY

"$GMX" grompp \
    -f "../../mdp/md.mdp" \
    -c npt.gro \
    -t npt.cpt \
    -p topol.top \
    -o md.tpr \
    -maxwarn 0

echo "Starting production MD."
echo "For HPC, replace the mdrun command with your cluster's recommended MPI/GPU command."

"$GMX" mdrun \
    -deffnm md \
    -v \
    2>&1 | tee "../../$LOG_DIR/md.log"

echo "Production MD finished."
