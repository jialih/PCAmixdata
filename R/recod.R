##' @export
recod <-
  function(X.quanti,X.quali,rename.level=FALSE)
  {
    G <- NULL
    Gcod <- NULL
    nbmoda <- NULL
    if (!is.null(X.quanti)){
      if (is.factor(X.quanti))
        stop("All variables in X.quanti must be numerical",call. = FALSE)
      if (is.numeric(X.quanti)) 
        X.quanti <- data.frame(X.quanti)
      for (v in 1:ncol(X.quanti)) {
        if (!is.numeric(X.quanti[, v])) 
          stop("All variables in X.quanti must be numeric",call. = FALSE)
        }
      n1 <- nrow(X.quanti)
      p1 <- ncol(X.quanti)
      
      recodqt <- recodquant(X.quanti)
      Z1 <- recodqt$Z
      g1 <- recodqt$g
      s1 <- recodqt$s
      Y1 <- recodqt$Xcod
    }
    if (!is.null(X.quali)){
      if (is.numeric(X.quali))
        stop("All variables in X.quali must be categorical",call.=FALSE)
      if (is.factor(X.quali)) 
        X.quali <- data.frame(X.quali)
      for (v in 1:ncol(X.quali)) {
        if (is.numeric(X.quali[, v])) 
          stop("All variables in X.quali must be categorical",call.=FALSE) }      
      vect.all.levels<-as.character(unlist(apply(X.quali,2,unique)))
      vect.all.levels.unique<-unique(vect.all.levels)
      test.name.categ<-length(vect.all.levels)==length(vect.all.levels.unique)      
      if(test.name.categ==FALSE && rename.level==FALSE)
        stop("Some categorical variables have same names of categories,
             rename categories or use the option rename.level=TRUE to rename it automatically",call.=FALSE)
      for (v in 1:ncol(X.quali)) X.quali[,v] <- factor(as.character(X.quali[,v])) 
      n2 <- nrow(X.quali)
      p2 <- ncol(X.quali)
      G <- recodqual(X.quali,rename.level)
      g2 <- apply(G,2,mean)
      ns <- apply(G,2,sum)
      s2 <- sqrt(ns/nrow(G))
      
      Gcod <- sweep(G,MARGIN=2,STATS=s2,FUN="/") 
      moy<-apply(Gcod,2,mean)
      Z2 <- sweep(Gcod,MARGIN=2,STATS=moy,FUN="-") 
      G.cent<-sweep(G,MARGIN=2,STATS=ns/nrow(G),FUN="-")
      nb.moda <- function(moda) {
        moda <- as.factor(moda)
        length(levels(moda))
      }
      nbmoda <- apply(X.quali,2, nb.moda)
      indexj2<-NULL
      for (j in 1:ncol(X.quali)) {
        indexj2 <- c(indexj2,rep(j,nbmoda[j]))}
    }
    if (!is.null(X.quanti)&& !is.null(X.quali))
      if (n1==n2) {
        n <- n1
        p <- p1+p2
        Z <- cbind(Z1,Z2)
        Y <- cbind(Y1,G)
        W <- cbind(Z1,G.cent)
        g <- c(g1,g2)
        s <- c(s1,s2)
        X <- cbind.data.frame(X.quanti,X.quali)
        indexj <- c(1:p1,indexj2+p1)
      } else 
        stop("number of objects in X.quanti and X.quali must be the same",call.=FALSE)
    if (!is.null(X.quanti)&& is.null(X.quali)) {
      n <- n1
      p <- p1
      p2 <- 0
      Z <- Z1
      Y <- Y1
      W <- Z1
      g <- g1
      s <- s1
      X <- X.quanti
      indexj <- 1:p1
    }
    if (is.null(X.quanti)&& !is.null(X.quali)){
      n <- n2
      p <- p2
      p1 <- 0
      Z <- Z2
      Y <- G
      W <- G.cent
      g <- g2
      s <- s2
      X <- X.quali
      indexj <- indexj2 
    } 
    if (is.null(X.quanti)&& is.null(X.quali))
      stop("A data matrix must be given",call.=FALSE)
    
    if (is.null(colnames(X))) 
      colnames(X) <- paste("V", 1:ncol(X), sep = "")
    for (j in 1:ncol(X)) if (colnames(X)[j] == "") 
      colnames(X)[j] <- paste("V", j, sep = "")
    
    return(list(X=X,Y=Y,Z=Z,W=W,n=n,p=p,p1=p1,p2=p2,g=g,s=s,indexj=indexj,
                G=G,Gcod=Gcod,X.quanti=X.quanti,X.quali=X.quali,nbmoda=nbmoda))
  }


