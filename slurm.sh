#!/usr/bin/env bash
#
# Sample slurm job for launching Jupyte notebooks. 
# Change slurm parameters accordingly.

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --cpus-per-task=4
#SBATCH --partition=m100_usr_prod
#SBATCH --qos=m100_qos_dbg
#SBATCH --gres=gpu:4
#SBATCH --time=02:00:00
#SBATCH --mem=20GB
#SBATCH --job-name=jupyter
#SBATCH --output=/path/to/home/username/jupyter-%j.log
#SBATCH --error=/path/to/home/username/jupyter-%j.err

module purge
module load anaconda
# acivate the conda environmnet
conda activate <conda-env>
# for R notebooks load the R module first
# module load R
# for Julia notebooks load the Julia module first
# module load julia
# for exporting notebooks to a PDF, load texlive module
# module load texlive

# TODO: check if nc is installed
# if JUPYTER_PORT environment variable is set it will be used,
# if it's in use we will try to find one in the range 8800-8899,
# if noting can be found in that range, a random one will be used.
if [[ -z "${JUPYTER_PORT}" ]]; then
    JUPYTER_PORT=$(netstat -antp 2>/dev/null | grep :88 | sort | head -n 1 | awk '{print $4}' | cut -d ":" -f 2)
    echo $JUPYTER_PORT
else
    JUPYTER_PORT="${JUPYTER_PORT}"
fi

cat /etc/hosts
jupyter lab --ip=0.0.0.0 --port=8888
