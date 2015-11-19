## This function takes a matrix and gives a list of 4 functions that perfrom various tasks. 

makeCacheMatrix <- function(x = matrix()) {

m<-NULL
  setmatrix<-function(y=matrix()){ 
    x<<-y
    m<<-NULL
  }
  getmatrix<-function()x
  
  setinversematrix<-function(){
    m<<-solve(x)
#      m<<-z  
  }
  getinversematrix<-function()m
  list(setmatrix=setmatrix,getmatrix=getmatrix,setinversematrix=setinversematrix,getinversematrix=getinversematrix)

}

##you can call this 1st fucntion in your enviorment like this.
##M1<-matrix(1:4,2,2) 
##outputfromfunction1<-makeCacheMatrix(M1)
##outputfromfunction1$setinversematrix()

## This fucntion takes two argments one a new matrix and the list object created from 1st fucntion, and checks if the matrix inverse is already calcualted.

cacheSolve<-function(x=matrix(),FN){
  Mat <-FN$getmatrix()
  if (identical(Mat,x))
      {
    INV<-FN$getinversematrix()
      if (!is.null(INV)){
    message("matrix inverse already calculated and cachced")
    return (INV)
  }  
    }
  else {
 INV <-solve(x)
    return (INV)
      }
  }

## Calling the second fuction like this will result in showing cached inverse.## cacheSolve(M1,outputfromfunction1)
##M3<-matrix(4:7,2,2)
 ## Calling the second fuction like this will result in calculating matrix inverse . not cahced.## cacheSolve(M3,outputfromfunction1)
