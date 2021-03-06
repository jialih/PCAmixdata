% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/supvar.PCAmix.R
\name{supvar.PCAmix}
\alias{supvar.PCAmix}
\title{Supplementary variables in PCAmix}
\usage{
\method{supvar}{PCAmix}(obj, X.quanti.sup = NULL, X.quali.sup = NULL,
  rename.level = FALSE, ...)
}
\arguments{
\item{obj}{an object of class \code{PCAmix}.}

\item{X.quanti.sup}{a numeric matrix of data.}

\item{X.quali.sup}{a categorical matrix of data.}

\item{rename.level}{boolean, if TRUE all the levels of the qualitative variables 
are renamed as follows: "variable_name=level_name". This prevents to have identical
names of the levels.}

\item{\dots}{further arguments passed to or from other methods.}
}
\description{
Performs the coordinates of supplementary variables 
on the component of an object of class \code{PCAmix}.
}
\examples{
data(wine)
X.quanti <- splitmix(wine)$X.quanti[,1:5]
X.quali <- splitmix(wine)$X.quali[,1,drop=FALSE]
X.quanti.sup <-splitmix(wine)$X.quanti[,28:29]
X.quali.sup <-splitmix(wine)$X.quali[,2,drop=FALSE]
pca<-PCAmix(X.quanti,X.quali,ndim=4,graph=FALSE)
pcasup <- supvar(pca,X.quanti.sup,X.quali.sup)
}
\seealso{
\code{\link{PCAmix}}
}

