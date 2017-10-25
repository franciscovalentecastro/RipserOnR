# Operate on a data point cloud represented as a matrix
source( 'Ripser.R' )

m = torus
#M = SDataSet3Matrix_F

# Point cloud
diaG = ripserDiag( m , dimension = 2 , threshold = 2 )
plot.diagram( diaG )

# Distance matrix

## Fix negative numbers in matrix
M[ M == -1 ] = .00000001

## Calculate homology
diAG = ripserDiag( M , dimension = 1 , threshold = 1.5, format = "distance" )
plot.diagram( diAG )