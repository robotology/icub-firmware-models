# Thermal model

The scripts contained in this folder are used to run the linear fit process of the thermal model parameters of a given motor.

The fitting process uses a continuous LTI model with one pole, estimating the thermal resistance $R_T$ and thermal time constant $\tau$.

The datasets are contained in the `data` folder.

## Usage
To run the fitting process, you can use either the live script `run_fitting_live.mlx`, or the more basic `run_fitting.m`.

The scripts also run the discretization method for digital implementation.