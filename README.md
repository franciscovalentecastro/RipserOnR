# RipserOnR

A parser for the output of the C++ library Ripser for calculating Vietoris–Rips persistence barcodes so it can be used easily with the TDA library in R.

# Download the Files

On the [RipserOnR](https://github.com/holt0102/RipserOnR) GitHub project page you should select the option **"Clone or Download"** and then **"Download Zip"** to get all the necessary files for using this R code. Unzip all the files and put them on your working folder.

**Note : For an advanced user, you should just clone the repo to your working folder.**

# Setup

You should put all the files from the Zip in your working folder. The most important files are :

* Ripser.R
* ripser.cpp
* Makefile

For an easier setup experience we can use Linux ( the R code should work on Windows too, but we need also a compiled .exe from ripser.cpp which would need to setup a compiler like MinGW ). For this to work we need this apps installed, which come easily with most Linux distros :

* g++
* make

Being this a simple C++ development setup. 

Finally, we import the library to our current environment ( with our files on the root of the folder ) using the next line 

```
source( 'Ripser.R' )
```

# Usage 

An example of usage can be seen in the "useRipser.R" file which shows the next code

```
# Import library  
source( 'Ripser.R' )

# Load matrix of points of size n x 3
m = torus

# Point cloud
diaG = ripserDiag( m , dimension = 2 , threshold = 2 )
plot.diagram( diaG )
```

We obtain a function named **ripserDiag** which follows the same usage as **ripsDiag** from the R TDA library. This meaning that we provide the data to which we want to apply **Persistent Homology**, some parameters and this fucntion will return an object that contains all the information of the cycles of the filtration ( as big list of intervals ).

# Plotting

To plot the diagrams and barcodes resulting from the persisten homology of the data we use the function **plot.diagram** from the R TDA library

```
plot.diagram( diAG )
plot.diagram( diAG , barcode = TRUE )
```

# Parameters
The parameters for the fucntion **ripserDiag** follow the names of the **Ripser** library parameters :

- **format**    :  use the specified file format for the input. Options are:
  - lower-distance (lower triangular distance matrix; default)
  - upper-distance (upper triangular distance matrix)
  - distance       (full distance matrix)
  - point-cloud    (point cloud in Euclidean space)
  - dipha          (distance matrix in DIPHA file format)
- **dim**       :  compute persistent homology up to dimension <k>
- **threshold** :  compute Rips complexes up to diameter <t>
