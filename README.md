# Programming Assignment 2
## Step by step

Import the R script
```R
> source("cachematrix.R")
```
create the matrix 
```R
> m <- matrix(runif(9),3,3)
> m
          [,1]        [,2]      [,3]
[1,] 0.1333129 0.007871525 0.4449713
[2,] 0.8957689 0.065143372 0.9741364
[3,] 0.2544803 0.915150502 0.3549224
```
create our special matrix object
```R
> m_obj <- makeCacheMatrix(m)
```
calculate the inverse matrix
```R
> m_inv <- cacheSolve(m_obj)
> m_inv
           [,1]       [,2]         [,3]
[1,] -3.6019655  1.6775447 -0.088431309
[2,] -0.2904845 -0.2734395  1.114679308
[3,]  3.3316193 -0.4977532  0.006775278
```
retrieve inverse from the cache
```R
> m_inv <- cacheSolve(m_obj)
getting cached data
> m_inv
           [,1]       [,2]         [,3]
[1,] -3.6019655  1.6775447 -0.088431309
[2,] -0.2904845 -0.2734395  1.114679308
[3,]  3.3316193 -0.4977532  0.006775278
```
check the result
```R
> m %*% m_inv
     [,1]         [,2]         [,3]
[1,]    1 8.326673e-17 0.000000e+00
[2,]    0 1.000000e+00 4.336809e-18
[3,]    0 8.326673e-17 1.000000e+00
```

## Appendix: Text of Assignment: 

This second programming assignment will require you to write an R
function that is able to cache potentially time-consuming computations.
For example, taking the mean of a numeric vector is typically a fast
operation. However, for a very long vector, it may take too long to
compute the mean, especially if it has to be computed repeatedly (e.g.
in a loop). If the contents of a vector are not changing, it may make
sense to cache the value of the mean so that when we need it again, it
can be looked up in the cache rather than recomputed. In this
Programming Assignment you will take advantage of the scoping rules of
the R language and how they can be manipulated to preserve state inside
of an R object.

### Example: Caching the Mean of a Vector

In this example we introduce the `<<-` operator which can be used to
assign a value to an object in an environment that is different from the
current environment. Below are two functions that are used to create a
special object that stores a numeric vector and caches its mean.

The first function, `makeVector` creates a special "vector", which is
really a list containing a function to

1.  set the value of the vector
2.  get the value of the vector
3.  set the value of the mean
4.  get the value of the mean

<!-- -->

    makeVector <- function(x = numeric()) {
            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setmean <- function(mean) m <<- mean
            getmean <- function() m
            list(set = set, get = get,
                 setmean = setmean,
                 getmean = getmean)
    }

The following function calculates the mean of the special "vector"
created with the above function. However, it first checks to see if the
mean has already been calculated. If so, it `get`s the mean from the
cache and skips the computation. Otherwise, it calculates the mean of
the data and sets the value of the mean in the cache via the `setmean`
function.

    cachemean <- function(x, ...) {
            m <- x$getmean()
            if(!is.null(m)) {
                    message("getting cached data")
                    return(m)
            }
            data <- x$get()
            m <- mean(data, ...)
            x$setmean(m)
            m
    }

### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.
