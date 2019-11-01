#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 8000
#SBATCH --time 3:00:00

for VAR in "direct" "linked"
do
    for RADIUS in 1 2 5 10
    do
        echo "srun /work/upcorreia/bin/Rosetta/main/source/bin/cluster.default.linuxgccrelease -s out/"${VAR}"/*/?.pdb -in:file:fullatom -cluster:radius "${RADIUS}""
	mkdir "${VAR}"_"${RADIUS}".cluster
	srun /work/upcorreia/bin/Rosetta/main/source/bin/cluster.default.linuxgccrelease -s out/"${VAR}"/*/?.pdb -in:file:fullatom -cluster:radius "${RADIUS}" -out:prefix "${VAR}"_"${RADIUS}"_
	mv "${VAR}"_"${RADIUS}"_*.pdb "${VAR}"_"${RADIUS}".cluster
	mv "${VAR}"_"${RADIUS}".cluster out
    done
done

echo "Done clustering"
