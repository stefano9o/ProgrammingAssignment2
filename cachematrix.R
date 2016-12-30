## The functions enable the user to calculate the inverse of a matrix.
## If the the calculation has been already done, the inverse is retrieved from the cache. 

## Create a special matrix object in wich can be stored the matrix itself and its inverse.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(inv_) inv <<- inv_
  getinv <- function() inv
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


## Calculate/Retrieve from cache the inverse of the special matrix object
cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinv(inv)
  ## Return a matrix that is the inverse of 'x'
  inv
}
