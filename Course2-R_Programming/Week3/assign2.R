#cache matrix inverse

#create special matrix object with inverse attribute
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinv <- function(inv) m <<- inv
  getinv <- function() m
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}

cacheSolve <- function(x, ...) {
  m <- x$getinv()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data)
  x$setinv(m)
  m
}

#test
matr = matrix(c(2.0, 4.0, 3.0, 5.0, 6.0, 4.0, 2.0, 3.0, 8.0), nrow = 3, ncol= 3)
matobject = makeCacheMatrix(matr)

#calculate inverse for the first time
cacheSolve(matobject)

#getting cached data for the second time
cacheSolve(matobject)

#verification of the results
solve(matr)
