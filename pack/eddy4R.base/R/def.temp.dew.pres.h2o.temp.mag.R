##############################################################################################
#' @title Definition function: Calculate dew point temperature from water vapor pressure and ambient temperature using Magnus equation

#' @author 
#' Stefan Metzger \email{eddy4R.info@gmail.com} \cr
#' Natchaya Pingintha-Durden \email{ndurden@battelleecology.org}

#' @description  Calculate dew point temperature from water vapor pressure and ambient temperature using Magnus equation.

#' @param presH2o Either a vector or an object of class numeric of measured water vapor pressure and of the same length as \code{temp}. [Pa]
#' @param temp Either a vector or an object of class numeric of measured air temperature and of the same length as \code{presH2o}. [K]


#' @return Dew point temperature and of the same length as \code{presH2o} and \code{temp}. [K]

#' @references
#' License: GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007. \cr
#' Gueymard, C.: Assessment of the accuracy and computing speed of simplified saturation vapor equations using a new reference dataset, J. Appl. Meteorol., 32, 1294-1300, doi:10.1175/1520-0450(1993)0321294:aotaac2.0.co;2, 1993. \cr

#' @keywords dew point, humidity conversion, Magnus equation

#' @examples 
#' def.temp.dew.pres.h2o.temp.mag(presH2o = 2212.04, temp = 298.15)
#' def.temp.dew.pres.h2o.temp.mag(presH2o = c(42.22, 87.22, 699.78), temp = c(265.15, 278.15, 293.15))

#' @seealso Currently none

#' @export

# changelog and author contributions / copyrights
#   Stefan Metzger (2014-11-11)
#     original creation
#   Stefan Metzger (2015-11-28)
#     re-formualtion as function() to allow packaging
#   Natchaya P-Durden (2016-11-30)
#     rename function to def.temp.dew.pres.h2o.temp.mag()
#   Stefan Metzger (2015-12-21)
#     fixing unit assignment
#   David Durden (2017-06-14)
#     fixing bug if all NA's are passed
#   Natchaya P-Durden (2018-04-03)
#     update @param format
##############################################################################################

def.temp.dew.pres.h2o.temp.mag <- function(presH2o, temp) {
  
  #defined local constants for Magnus formula
  CnstLoc <- list(Cnst01 = 6.11, Cnst02 = 17.08, Cnst03 = 234.18, Cnst04 = 22.44, Cnst05 = 272.44)
  
   #temp >= 273.15 K (0 degC):
  if(mean(temp, na.rm=TRUE) >= eddy4R.base::IntlConv$CelsKelv[1] | is.na(mean(temp, na.rm=TRUE))) {
    #dew point:
    tempDew <- (CnstLoc$Cnst03 * log(presH2o*1e-2 / CnstLoc$Cnst01) / (CnstLoc$Cnst02 - log(presH2o*1e-2 / CnstLoc$Cnst01)))
    attributes(tempDew)$unit <- NULL
    tempDew <- eddy4R.base::def.unit.conv(data=tempDew, unitFrom="C", unitTo="K") # Convert to Kelvin
    
  } else {
    #temp < 273.15 K (0 degC):
    tempDew <- (CnstLoc$Cnst05 * log(presH2o*1e-2 / CnstLoc$Cnst01) / (CnstLoc$Cnst04 - log(presH2o*1e-2 / CnstLoc$Cnst01)))
    attributes(tempDew)$unit <- NULL
    tempDew <- eddy4R.base::def.unit.conv(data=tempDew, unitFrom="C", unitTo="K") # Convert to Kelvin
    
  }
  
  #return reported object
  return(tempDew)
  
  # end function def.temp.dew.pres.h2o.temp.mag()
}
