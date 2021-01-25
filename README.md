# Contrib Module: miniconda3

## Description

NOAA GSL AVID maintains a miniconda3 contrib module on the RDHPCS platforms. It
is an RDHPCS-supported intallation of miniconda and houses several widely-used
conda environments including:

  - avid_verify, a Python 2 verification environment 
  - data_handling, a Python 3 environment with data science packages
  - pygraf, a Python 3 graphics support environment
  - regional_workflow, a Python 3 environment for the ufs-srweather-app
  - spp_vx, a Python 3 data handling and graphics environment


## Installation (except NOAA RDHPC gaea)

---
Steps:

1. Clone this repository as /contrib/miniconda3 (create by RDHPCS admins). Do
   that with these steps in your scratch space:
        git clone https://this/repo tmp
        mv tmp/.git /contrib/miniconda3/.git
        rm -rf tmp
2. Follow the steps in the Miniconda section below.
3. Restore the repo version of the conda config and source scripts:
        git checkout miniconda3/4.5.12

### Miniconda

Miniconda installation instructions are available on [RDHPCS Common
Docs](https://rdhpcs-common-docs.rdhpcs.noaa.gov/wiki/index.php/Anaconda).

There are a few specifics related to the AVID installation:

 - We use version: 4.5.12
 - Do not have the installer edit your .bashrc
 - Install only on contrib or scratch space (individual user).


On Hera, the sitecustomize.py file throws innocuous, but noisy, errors when
using this installation of conda. Remove the file `
$conda_root/lib/pythonX.Y/site-packages/sitecustomize.py` to stop the attempts
at logging dependencies and remove the error.

### Module

The contrib modules are managed according to [this
page](https://rdhpcs-common-docs.rdhpcs.noaa.gov/wiki/index.php/Managing_Packages_in_/contrib).
The module files are kept in this repository, and must be stored on RDHPCS
platforms under `/contrib/miniconda3/modulefiles/miniconda3` using only the
version as the module file name.

The module file is a Tcl script and has some useful documentation
[here](https://modules.readthedocs.io/en/latest/modulefile.html).

Note: the modulefile has become pretty complex for this version of miniconda
since it requires sourcing separate files for different shells. Future versions
of miniconda may remedy this complexity.

### Conda Environments -- From existing

To install the environments in the scratch space, use the various YAML
environment files included in this repository.

    module use -a /contrib/miniconda3/modulefiles
    module load miniconda3
    unset CONDA_ENVS_PATH
    unset CONDA_PKGS_PATH

    conda env create -f /path/to/[env_name].yml

### Conda Environments -- New

To install environments not yet in the repository:


    module use -a /contrib/miniconda3/modulefiles
    module load miniconda3
    unset CONDA_ENVS_PATH
    unset CONDA_PKGS_PATH

    conda create --name myenv python=3.8
    conda activate myenv

At this point you have a new empty environment with Python v3.8 and can install
RDHPCS-supplied packages. Check
[here](https://rdhpcs-common-docs.rdhpcs.noaa.gov/wiki/index.php/Anaconda) for
the list of packages.

For example:

    conda install -c conda-forge matplotlib
    conda install pillow

## Installation and usage (NOAA RDHPC gaea only)

The installation on gaea differs w.r.t. the version of miniconda and the modulefile
being used, because gaea's Tcl version is too old to understand the default modulefile.

Instead, we are using a modern lua modulefile and the ESRL-provided lua module support,
together with version 4.8.3 of miniconda3. The installation procedure also differs slightly.

### Miniconda installation

    mkdir -p /lustre/f2/pdata/esrl/gsd/contrib/miniconda3/4.8.3/src
    cd /lustre/f2/pdata/esrl/gsd/contrib/miniconda3/4.8.3/src

    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh sh Miniconda3-latest-Linux-x86_64.sh -u

Note: skip initializing miniconda in user .bashrc/.profile etc.

### Include GSL miniconda3 repository

    cd /lustre/f2/pdata/esrl/gsd/contrib/miniconda3/4.8.3/src
    git clone --recursive https://github.com/NOAA-GSD/contrib_miniconda3.git miniconda3
    rsync -av miniconda3/ ../

    # Copy modulefile to the right place
    mkdir -p /lustre/f2/pdata/esrl/gsd/contrib/modulefiles/miniconda3/
    cp -av modulefiles/miniconda3/4.8.3.lua /lustre/f2/pdata/esrl/gsd/contrib/modulefiles/miniconda3/

### Usage

#### Load miniconda module

    source /lustre/f2/pdata/esrl/gsd/contrib/lua-5.1.4.9/init/init_lmod.sh

    module use /lustre/f2/pdata/esrl/gsd/contrib/modulefiles
    module load miniconda3/4.8.3

#### Create environment from yaml file (first time only)

    conda env create -f /lustre/f2/pdata/esrl/gsd/contrib/miniconda3/4.8.3/environments/regional_workflow.yml

#### Activate environment

    conda activate regional_workflow

#### Deactivate conda and unload module

    conda deactivate
    module unload miniconda3

### Notes

1) Only the regional_workflow environment has been tested on gaea with miniconda3-4.8.3.
2) After loading the miniconda3 module, warnings about a missing version information in
   miniconda's libtinfo.so.6 are written to stdout frequently. Annoying, but harmless.

## Contact

  For issues or questions related to the contrib module, conda, or supported
  environments, please contact:

  | Name            | Email                       |
  | ----------------| :---------------------------|
  | Christina Holt  | christina.holt@noaa.gov     |
  | Jeff Hamilton   | jeffrey.a.hamilton@noaa.gov |
  | Dom Heinzeller  | dom.heinzeller@noaa.gov     | (gaea support)

