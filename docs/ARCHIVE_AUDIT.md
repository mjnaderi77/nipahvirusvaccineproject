# Audit of supplied archive

The supplied `Nipah virus.zip` contains an `10. MD/MD/` directory with:

- `complex.pdb`
- `processed.gro`
- `boxed.gro`
- `solvated.gro`
- `solv_ions.gro`
- `topol.top`
- `em.mdp`
- `nvt.mdp`
- `ions.mdp`
- EM/NVT output files

The topology header indicates GROMACS 2023.3 and AMBER99SB-ILDN.

The archived `nvt.mdp` specifies 50,000 steps with `dt = 0.002 ps`, i.e. 100 ps.

No archived NPT production `.mdp`/trajectory equivalent to a 150 ns production run was found in the inspected `10. MD/MD/` directory.

This audit is included so the GitHub repository does not accidentally claim simulations that are not represented by the supplied files.
