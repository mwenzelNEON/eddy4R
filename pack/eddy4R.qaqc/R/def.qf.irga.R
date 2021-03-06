##############################################################################################
#' @title Definition function: irga flags for LI72000

#' @author 
#' Dave Durden \email{ddurden@battelleecology.org}

#' @description 
#' Definition function to interpret the irga sensor flags from \code{diag01}.
#' @param diag01 The 32-bit diagnostic stream that is output from the LI7200. 
#' @param MethQf Switch for quality flag determination for the LI7200, diag01 provides ones for passing quality by default the equals "lico". The "qfqm" method changes the ones to zeros to match the NEON QFQM logic.
#' 
#' @return A dataframe (\code{qfIrgaTurb}) of sensor specific irga quality flags as described in NEON.DOC.000807.

#' @references 
#' License: GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007. \cr
#' NEON Algorithm Theoretical Basis Document:Eddy Covariance Turbulent Exchange Subsystem Level 0 to Level 0' data product conversions and calculations (NEON.DOC.000807) \cr
#' Licor LI7200 reference manual

#' @keywords NEON, irga, qfqm

#' @examples 
#' diag01 <- rep(8191, 72000)
#' def.qf.irga(diag01 = diag01)

#' @seealso Currently none

#' @export

# changelog and author contributions / copyrights
#   Dave Durden (2017-01-15)
#     original creation
#   Dave Durden (2017-12-02)
#     fixing issues with missing diag data and order bits are analyzed for qfIrgaTurbAgc
#   Dave Durden (2017-12-03)
#     Changing output naming convention to qfIrgaTurb
#   Natchaya P-Durden (2018-04-03)
#     update @param format
#   Natchaya P-Durden (2018-04-11)
#    applied eddy4R term name convention; replaced pos by set
##############################################################################################


def.qf.irga <- function(diag01, MethQf = c("qfqm","lico")[1]){

  if(base::is.null(diag01)) {
    stop("Input 'diag01' is required")
  } 

  if(!(base::is.integer(diag01)|is.numeric(diag01))) {
  stop("Input 'diag01' is required as an integer or numeric")
  } 
 

  #Grab position of NA's
  setNa <- which(is.na(diag01))
  
  # Turn the diag01 into a matrix of 32 bits separated into columns for the timeseries of diagnostic values  
qfIrgaTurb <- t(base::sapply(diag01,function(x){ base::as.integer(base::intToBits(x))}))

# Function to aggregate bits to base 10 representation
bitsToInt<-function(x) {
  packBits(rev(c(rep(FALSE, 32-length(x)%%32), base::as.logical(x))), "integer")
}

#Calculate the IRGA AGC value based on the first 4 bits (0-3) of the binary
qfIrgaTurbAgc <- base::sapply(seq_len(nrow(qfIrgaTurb)), function(x) ((bitsToInt(qfIrgaTurb[x,4:1])*6.25)+ 6.25)/100)

#Create outpu dataframe
qfIrgaTurb <- base::data.frame(qfIrgaTurbAgc, qfIrgaTurb[,5:13])


#Provide column names to the output
base::names(qfIrgaTurb) <- c("qfIrgaTurbAgc", "qfIrgaTurbSync", "qfIrgaTurbPll", "qfIrgaTurbChop","qfIrgaTurbDetc", "qfIrgaTurbPres", "qfIrgaTurbAux", "qfIrgaTurbTempIn", "qfIrgaTurbTempOut", "qfIrgaTurbHead")


if (MethQf == "qfqm"){
#Change all the 1 values to 0 and 0 to 1 to fit the NEON qfqm framework
base::lapply(base::names(qfIrgaTurb[!names(qfIrgaTurb) == "qfIrgaTurbAgc"]), function(x) {
  set <- which(qfIrgaTurb[,x] == 1)
  qfIrgaTurb[set,x] <<- base::as.integer(0)
  qfIrgaTurb[-set,x] <<- base::as.integer(1)
  qfIrgaTurb[,x] <<- base::as.integer(qfIrgaTurb[,x])
})}

#Replace positions without diag data with -1
qfIrgaTurb[setNa,] <- -1L

qfIrgaTurb$qfIrgaTurbAgc[setNa] <- NaN


#return dataframe
return(qfIrgaTurb)

}
