# Reproducibility checklist

Before publishing the repository, record:

- GROMACS version
- operating system / cluster
- CPU/GPU model
- force field version
- water model
- starting structure source and accession/PDB ID
- protein chain identifiers
- protonation method
- box dimensions
- salt concentration
- ion names
- temperature
- pressure
- thermostat/barostat
- timestep
- minimization criteria
- NVT duration
- NPT duration
- production duration
- random seeds
- number of independent replicas
- analysis commands
- software versions used for downstream analysis

The GitHub repository should contain code and lightweight configuration, while large trajectories should normally be deposited in a data repository.
