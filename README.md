# JupyterOnClusters
Run Jupyter notebooks on clusters.

If there is an anaconda module available on the cluster, then load it and create a conda environment:

```bash
conda create --name <env> ipykernel numpy matplotlib --channel conda-forge
```
The newly created environment can be activated and deactivated with `conda <activate|deactivate> <env>`.
All the conda environments can be listed with `conda info --envs`.
Conda environments can take between 1G to 10G bytes, make sure there is enough disk quota available with 
`quota -u <username>` or if there may be machine specific way of disk space distribution between users, 
e.g. `WORK` or `SCRATCH` space limitations on a specific machine. If the conda environment can't be created 
on the home directory, it can be created elsewhere, e.g. `SCRATCH` but then must be soft linked to `~/.conda`:

```bash
ln -s /path/to/conda ~/.conda
```
To install any other packages later on, e.g.`jupyter_contrib_nbextensions`, after activating the environment,
just install normally any package from any channel:

```bash
conda activate <env>
conda install jupyter_contrib_nbextensions --channel conda-forge
```
To enable an extensions, e.g. `collapsible_headings`:

```bash
jupyter nbextension enable collapsible_headings/main
```

Now to access the juyter notebook from a local machine, first initialize the `jupyter-notebook` server on the cluster:

```bash
jupyter-notebook --no-browser --port=8893 --ip=127.0.0.1
```
mind the url with the token. Now on the local machine forward the specified port to the cluster:

```bash
ssh -N -f -L localhost:8893:localhost:8893 <username>@<hostname> -i /path/to/parivate/key
```

Now the notebook server can be accessed locally with browser and the url generated at the last step.
