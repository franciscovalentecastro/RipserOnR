# Import library  
source( 'Ripser.R' )

# Load matrix of points of size n x 3
m = torus

# Point cloud
diaG = ripserDiag( m , dimension = 2 , threshold = 2 )
plot.diagram( diaG )
