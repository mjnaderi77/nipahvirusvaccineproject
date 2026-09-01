# Nipah Virus Molecular Dynamics — GROMACS Workflow

Reproducible GROMACS workflow for the Nipah virus protein complex used in this project.

## Important note about the archived project

The supplied project archive was inspected before preparing this repository. The existing topology was generated with:

- **GROMACS 2023.3**
- **AMBER99SB-ILDN** force field
- **TIP3P** water
- PME electrostatics
- Two protein chains (`Protein_chain_A` and `Protein_chain_A2`)
- Existing box/topology contained ~122,176 water molecules and 44 chloride ions

The archive currently contains an energy-minimization setup and a **100 ps NVT** run, but it does **not** contain a complete NPT + long production MD workflow. Therefore, this repository provides a clean, reproducible workflow for:

1. system preparation
2. energy minimization
3. NVT equilibration
4. NPT equilibration
5. production MD
6. trajectory cleanup
7. RMSD, RMSF, SASA, radius of gyration, H-bond and basic energy analyses

> Do not describe a production simulation as 150 ns unless the production trajectory actually contains 150 ns of simulated time.

## Recommended workflow

```bash
bash scripts/00_check_gromacs.sh
bash scripts/01_prepare_system.sh
bash scripts/02_em.sh
bash scripts/03_nvt.sh
bash scripts/04_npt.sh
bash scripts/05_md.sh
bash scripts/06_trajectory_cleanup.sh
bash scripts/07_analysis.sh
```

For a long production run, first edit `config/config.env`.

## Project structure

```text
niv-md-gromacs-github/
├── README.md
├── LICENSE
├── CITATION.cff
├── .gitignore
├── config/
│   └── config.env
├── mdp/
│   ├── minimization.mdp
│   ├── nvt.mdp
│   ├── npt.mdp
│   └── md.mdp
├── scripts/
│   ├── 00_check_gromacs.sh
│   ├── 01_prepare_system.sh
│   ├── 02_em.sh
│   ├── 03_nvt.sh
│   ├── 04_npt.sh
│   ├── 05_md.sh
│   ├── 06_trajectory_cleanup.sh
│   └── 07_analysis.sh
├── analysis/
│   └── README.md
├── data/
│   ├── input/
│   └── topology/
├── results/
├── figures/
├── logs/
└── docs/
```

## Input files

Place the starting complex here:

```text
data/input/complex.pdb
```

If you are continuing from an already prepared topology, place the required topology/coordinate files under `data/topology/` and adapt the configuration accordingly.

## Simulation defaults

The default production length is controlled by:

```bash
PRODUCTION_NS=150
```

At `dt = 0.002 ps`, this corresponds to 75,000,000 integration steps.

For a first test, change this to `1` or `5` ns before launching a large production simulation.

## Reproducibility

Record at minimum:

- GROMACS version
- force field
- water model
- simulation temperature
- pressure
- timestep
- equilibration lengths
- production length
- random seed
- starting PDB/model identifier
- topology generation method

Do not commit large binary trajectories (`.xtc`, `.trr`, `.tpr`, `.edr`) to GitHub unless there is a specific reason. Store them in Zenodo, Figshare, institutional storage, or another data repository and link them from the README.

## Analysis outputs

The analysis script generates:

- backbone RMSD
- backbone RMSF
- radius of gyration
- SASA
- protein-protein/intermolecular H-bonds where the index groups are appropriate
- temperature
- pressure
- potential energy
- kinetic energy

The exact group selections may need adjustment for the specific complex.

## Scientific caution

This repository automates commands; it does not validate biological interpretation. Inspect:

- energy minimization convergence
- temperature stability
- pressure/density equilibration
- RMSD/RMSF behavior
- periodic-boundary artifacts
- protein structural integrity
- chain/interface definitions

before reporting results.
