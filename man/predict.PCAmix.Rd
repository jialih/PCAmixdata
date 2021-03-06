\name{predict.PCAmix}
\alias{predict.PCAmix}
\title{Prediction of new scores in PCAmix or PCArot}

\description{
This function performs the scores of new observations on the principal components of PCAmix. If the components have been rotated, this function performs the scores of the
  new observations on the rotated principal components. In other words, this function is projecting the new observations onto the principal components of PCAmix (or PCArot) obtained previoulsy on a separated dataset. Note that the new observations must be described with the same variables than those used in PCAmix (or PCArot).
}

\usage{
  \method{predict}{PCAmix}(object, X.quanti = NULL, X.quali = NULL, rename.level=FALSE,...)
}
\arguments{
  \item{object}{an object of class PCAmix (output of the
  function PCAmix or PCArot).}
   \item{X.quanti}{a numeric data matrix or an object that can be coerced to such a matrix (such as a numeric vector or a data frame with all numeric columns)}

  \item{X.quali}{a categorical matrix of data, or an object that can be coerced to such a matrix (such as a character vector, a factor or a data frame with all factor columns)}
  
   \item{rename.level}{boolean, if TRUE all the levels of the qualitative variables are renamed as follows: "variable_name=level_name". This prevents to have identical names for the levels.}
  
  \item{...}{further arguments passed to or from other methods. They are ignored in this function.}
 } 
\value{
  Returns the matrix of the scores of the new observations on
  the principal components or on the rotated principal components of PCAmix.
}

\examples{
# quantitative data
data(decathlon)
n <- nrow(decathlon)
sub <- sample(1:n,20)
pca<-PCAmix(decathlon[sub,1:10], graph=FALSE)
predict(pca,decathlon[-sub,1:10])
rot <- PCArot(pca,dim=4)
predict(rot,decathlon[-sub,1:10])

# quantitative and qualitative data
data(wine)
str(wine)
X.quanti <- splitmix(wine)$X.quanti
X.quali <- splitmix(wine)$X.quali
pca<-PCAmix(X.quanti[,1:27],X.quali,ndim=4,graph=FALSE)
n <- nrow(wine)
sub <- sample(1:n,10)
pca<-PCAmix(X.quanti[sub,1:27],X.quali[sub,],ndim=4)
pred <- predict(pca,X.quanti[-sub,1:27],X.quali[-sub,])
plot(pca,axes=c(1,2))
points(pred[,c(1,2)],col=2,pch=16)
text(pred[,c(1,2)], labels = rownames(X.quanti[-sub,1:27]), col=2,pos=3)
}

\seealso{
  \code{\link{PCAmix}}
}

\author{
  Marie Chavent \email{marie.chavent@math.u-bordeaux1.fr},
  Vanessa Kuentz, Benoit Liquet, Jerome Saracco
}

\references{
Chavent M., Kuentz-Simonet V., Labenne A., Saracco J., Multivariate analysis of mixed data: The PCAmixdata R package, arXiv:1411.4911 [stat.CO].
}

