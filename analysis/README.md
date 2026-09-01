# Analysis

Expected output files:

- `rmsd_backbone.xvg`
- `rmsf_ca.xvg`
- `gyration.xvg`
- `sasa.xvg`
- `temperature.xvg`
- `pressure.xvg`
- `potential_energy.xvg`
- `kinetic_energy.xvg`

For interface-specific H-bond analysis, create an index with `gmx make_ndx` or `gmx select` and define the two groups representing the molecular partners.

For publication-grade analysis, consider adding:

- PCA / essential dynamics
- dynamic cross-correlation matrix
- cluster analysis
- secondary-structure analysis (`gmx dssp`, if installed)
- interface contacts
- salt bridges
- MM/PBSA or MM/GBSA
- replicate simulations
