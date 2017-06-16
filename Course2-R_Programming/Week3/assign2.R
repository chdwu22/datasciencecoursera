## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  inv_mat <- NULL
  set <- function(matr)
  {
    x <<- matr
    inv_mat = NULL
  }
  get <- function() x
  setinv <- function(input) inv_mat <<- input
  getinv <- function() inv_mat
  list(set = set, get = get, setinv = setinv, getinv = getinv)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  inv_mat <- x$getinv
  if(!is.null(inv_mat))
  {
    message("getting cached inverse matrix")
    return(inv_mat)
  }
  matr <- x$get()
  inv_mat <- solve(matr)
  x$setinv(inv_mat)
  inv_mat
}

m = matrix(c(2,4,3,5,6,4,2,3,8), nrow = 3, ncol= 3)
matobject = makeCacheMatrix(m)
inv_mat = cacheSolve(matobject)
matobject$get()
inv_mat
