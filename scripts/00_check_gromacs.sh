#!/usr/bin/env bash
set -euo pipefail

source config/config.env

echo "Checking GROMACS..."
command -v "$GMX" >/dev/null || {
    echo "ERROR: GROMACS executable '$GMX' was not found."
    exit 1
}

"$GMX" --version
echo
echo "GROMACS check complete."
