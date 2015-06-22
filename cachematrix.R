## This functions gives a matrix and the inverse of a matrix.

## This function make a matrix.

makeCacheMatrix <- function(x = matrix()) {
  inversa <- NULL
  set <- function(y) {
    x <<- y
    inversa <<- NULL 
  } 
  get <- function() x 
  setinversa <- function(inv) inversa <<- inv
  getinversa <- function() inversa 
  list(set = set, get = get,
       setinversa = setinversa,
       getinversa = getinversa)
}

## This function make de inverse of a matrix with the function solve().

cacheSolve <- function(x, ...) {
  m <- x$getinversa()
  if(!is.null(m)) { 
    message("getting cached data")
    return(m) 
  }
  data <- x$get() 
  m <- solve(data) 
  x$setinversa(m) 
  m 
}

# Test
# generate a random square, non-singular matrix
test <- matrix(runif(16,1,100),4,4)
# generate the makeCacheMatrix object with this matrix
test2 <- makeCacheMatrix(test)
# from now on calculate or retrieve calculated inversion using the cacheSolve function

MatrixInv <- cacheSolve(test2)
MatrixInv <- cacheSolve(test2)
MatrixInv <- cacheSolve(test2)
