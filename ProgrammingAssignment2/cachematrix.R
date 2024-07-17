## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
        y <- NULL
        set <- function(z){
                background1 <<- z
                y <<- NULL
        }
        get <- function(){background1}
        setin <- function(inverse){y <<- inverse}
        getin <- function(){y}
        list (set = set, get = get, setin = setin, getin = getin)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        z <- x$getin()
        if(!is.null(z)){z}
        dato <- x$get()
        z <- solve(dato) %*% dato
        x$setin(z)
        z
        
}
