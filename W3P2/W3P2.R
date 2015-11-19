makeCacheMatrix<- function(x=matrix()){
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

cacheSolve<-function(FN, ...){
  IM <-FN $getinversematrix()
  if (!is.null(IM)){
    message("matrix inverse already cachced")
    return (IM)
  }
  else {
 NI <-solve(FN$getmatrix())
    return (NI)
      }
  }