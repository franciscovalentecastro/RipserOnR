"
Help from Ripser program

Usage: ripser [options] [filename]

Options:

--help           print this screen
--format         use the specified file format for the input. Options are:
                    lower-distance (lower triangular distance matrix; default)
                    upper-distance (upper triangular distance matrix)
                    distance       (full distance matrix)
                    point-cloud    (point cloud in Euclidean space)
                    dipha          (distance matrix in DIPHA file format)
--dim <k>        compute persistent homology up to dimension <k>
--threshold <t>  compute Rips complexes up to diameter <t>
"

## Libraries 
library(stringr)
library(TDA)

## Compile Ripser depending on platform
if(.Platform$OS.type == "unix") {
    system2("make" , args = c( "clean" ) )
    system2("make" , args = c( "all" ) )
} else {
    system2("c++" , args = c( "-std=c++11", "ripser.cpp", "-o", "ripser", "-Ofast", "-D", "NDEBUG" ) )
}

## Parse raw output from Ripser
parseOutput = function( output ){
    
    ## Number of intervals by dimension
    indices            = grep( "persistence intervals in dim " , output , value = FALSE )
    maxDimension       = length( indices ) - 1
    indices            = c( indices , length( output ) )
    
    ## Convert output in matrix
    diagram = matrix(, ncol = 3, nrow = 0 )
    
    ## Loop each group of intervals by dimension
    for( dim in 0:maxDimension ){
        
        ## Select intervals
        if( dim == maxDimension ){
            intervals = output[ ( indices[ dim + 1 ] + 1):( indices[ dim + 2 ] ) ]
        }else{
            intervals = output[ ( indices[ dim + 1 ] + 1):( indices[ dim + 2 ] - 1 ) ]
        }
        
        ## Removed lines from output
        intervals = grep( "\\[\\d*\\.?\\d+\\,\\d*\\.?\\d+\\)" , intervals , value = TRUE )
        
        ## Remove punctuation from intervals
        intervals = gsub( "(\\s|\\[|\\))" , "" , intervals )
        
        ## Split interval and convert to numeric
        intervals = as.numeric( unlist( strsplit( intervals , "," ) ) )
        
        ## Convert ouput in matrix
        intervals = matrix( intervals , ncol = 2 , byrow = T )
        
        ## Add dimension column
        intervals = cbind( rep( dim , nrow( intervals ) ) , intervals )
        
        ## Add intervals to diagram
        diagram = rbind( diagram, intervals )
        
    }
    
    ## Format matrix to diagram format
    colnames( diagram ) = c( "dimension" , "Birth" , "Death" )
    
    return( diagram )    
}

## Calculate rips diagram using Ripser library
ripserDiag = function( X, dimension, threshold, format = "point-cloud" ){
    
    # Ripser likes to read files in, so use a temporary file
    f = tempfile()
    write.table(X, f, col.names = FALSE, row.names = FALSE)
    
    ## Set parameters as text
    dimension = as.character( dimension )
    threshold = as.character( threshold )
    
    ## Run Ripser using system command
    if(.Platform$OS.type == "unix") {
        ripserOut = system2("./ripser", args = c( "--dim", dimension, "--threshold", threshold, "--format", format , f), stdout = TRUE)
    } else {
        ripserOut = system2("ripser", args = c( "--dim", dimension, "--threshold", threshold, "--format", format , f), stdout = TRUE)
    }

    ## Add threshold value as death for undying intervals
    ripserOut = gsub( "\\,\\s\\)" , paste( c( "\\,", as.character(threshold), "\\)" ), collapse = "") , ripserOut )

    return( parseOutput( ripserOut ) )
}

