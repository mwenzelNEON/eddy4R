% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/def.pres.h2o.sat.temp.mag.R
\name{def.pres.h2o.sat.temp.mag}
\alias{def.pres.h2o.sat.temp.mag}
\title{Definition function: Calculate saturated water vapor pressure from temperature using Magnus equation}
\usage{
def.pres.h2o.sat.temp.mag(temp)
}
\arguments{
\item{temp}{Either a vector or an object of class numeric of measured air temperature. [K]}
}
\value{
Saturated water vapor pressure and of the same length as \code{temp}. [Pa]
}
\description{
Calculate saturated water vapor pressure from temperature using Magnus equation.
}
\examples{
def.pres.h2o.sat.temp.mag(temp = 265.15)
def.pres.h2o.sat.temp.mag(temp = c(265.15, 285.0, 290.2))
}
\references{
License: GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007. \cr
Gueymard, C.: Assessment of the accuracy and computing speed of simplified saturation vapor equations using a new reference dataset, J. Appl. Meteorol., 32, 1294-1300, doi:10.1175/1520-0450(1993)0321294:aotaac2.0.co;2, 1993. \cr
}
\seealso{
Currently none
}
\author{
Stefan Metzger \email{eddy4R.info@gmail.com} \cr
Natchaya Pingintha-Durden \email{ndurden@battelleecology.org}
}
\keyword{Magnus}
\keyword{conversion,}
\keyword{equation}
\keyword{humidity}
