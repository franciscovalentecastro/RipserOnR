# RipserOnR

A parser for the output of the C++ library Ripser for calculating Vietoris–Rips persistence barcodes so it can be used easily with the TDA library in R.

# Download the Files

In the RipserOnR you should select the option "Clone or Download" and then "Download Zip" to get all the necessary files for using this R code.

# Usage

You should put all the files from the Zip in your working folder. The most important files are :

* Ripser.R
* ripser.cpp
* Makefile

For an easier setup experience we can use Linux ( the R code should work on Windows too, but we need also a compiled .exe from ripser.cpp which would need to setup a compiler like MinGW ). For this to work we need this apps installed, which come in an easy to setup way on most Linux distros :

* g++
* make

Being this a simple C++ development setup. 

Finally, we import the library to our current environment ( with our files on the root of the folder ) using the next line 

```
source( 'Ripser.R' )
```
