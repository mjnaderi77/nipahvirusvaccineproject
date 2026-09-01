#!/usr/bin/env bash
set -euo pipefail

source config/config.env

mkdir -p "$RUN_DIR" "$ANALYSIS_DIR" "$LOG_DIR"

if [[ ! -f "$INPUT_PDB" ]]; then
    echo "ERROR: $INPUT_PDB not found."
    echo "Place your starting complex at data/input/complex.pdb"
    exit 1
fi

cd "$RUN_DIR"

echo "[1/5] pdb2gmx"
"$GMX" pdb2gmx \
    -f "../../$INPUT_PDB" \
    -o processed.gro \
    -p topol.top \
    -i posre.itp \
    -water "$WATER" \
    -ignh

echo "[2/5] Define simulation box"
"$GMX" editconf \
    -f processed.gro \
    -o boxed.gro \
    -c \
    -d "$BOX_DISTANCE" \
    -bt "$BOX_TYPE"

echo "[3/5] Solvate"
"$GMX" solvate \
    -cp boxed.gro \
    -cs spc216.gro \
    -o solvated.gro \
    -p topol.top

echo "[4/5] Prepare ions"
"$GMX" grompp \
    -f "../../mdp/minimization.mdp" \
    -c solvated.gro \
    -p topol.top \
    -o ions.tpr \
    -maxwarn 0

echo "[5/5] Add ions"
echo "SOL" | "$GMX" genion \
    -s ions.tpr \
    -o solv_ions.gro \
    -p topol.top \
    -pname NA \
    -nname CL \
    -neutral \
    -conc "$SALT_CONC"

echo "System preparation completed in $RUN_DIR"
