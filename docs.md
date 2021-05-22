# Documentation Links and Notes

I am not all of the way familiar with all of these tools. Documentation links will help clear up running details without requiring google searches.

## OpenRefine

https://docs.openrefine.org/manual/installing

Really any of the manual pages would be fine to start on.

## Anaconda

### Some useful commands for getting started

List environments:
```bash
conda env list
```

Enter environments:
```bash
conda activate <name>
```

### Install Jupyter In Current Environment

```bash
conda install -c conda-forge notebook
# or 
# conda install -c conda-forge jupyterlab
# depending on which version you use
conda install -c conda-forge nb_conda_kernels
```

#### Optional Notebook Extensions

```bash
conda install -c conda-forge jupyter_contrib_nbextensions
```

### Conda Env Pip

```bash
conda install pip
```

### Useful article

Article with some good thoughts on setting up a data science ecosystem using python Anaconda and it's supporting components:
https://towardsdatascience.com/how-to-set-up-anaconda-and-jupyter-notebook-the-right-way-de3b7623ea4a

Content I haven't explored in this article includes creating tensorflow environments and running various versions of tensor flow against the same Jupyter notebook.

