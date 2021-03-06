##############################################################################################
#' @title Definition function: Extract variable with unit attribute from data frame

#' @author 
#' Cove Sturtevant \email{eddy4R.info@gmail.com}

#' @description Function definition. Extracts a variable from a data frame (with units attached as attributes
#' at the data frame level), and attaches the variable's unit directly to the extracted variable. 

#' @param data Required. A data frame with units of each variables attached as a named attribute "unit"
#' to the data frame.
#' @param nameVar Required. A string containing the name of the variable within \code{data} to extract,
#' along with its units
#' @param AllwIdx Optional. Logical, defaulting to FALSE. Allow positional determination of the unit within
#' the unit attribute vector? If FALSE, an error will result if the variable name does not match an entry with 
#' the named unit vector. If TRUE, the unit attribute vector does not need to be named, and the unit will be 
#' pulled based on the same position of the variable within the data frame \code{data}.
#'  
#' @return The desired variable with units attached as attribute. 
#' 
#' @references 
#' License: GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007.

#' @keywords Fulcrum

#' @examples Currently none

#' @seealso Currently none

#' @export
#' 
# changelog and author contributions / copyrights
#   Cove Sturtevant (2016-09-08)
#     original creation 
#   Natchaya P-Durden (2016-11-27) 
#     rename function to def.unit.extr()
#   Natchaya P-Durden (2018-04-03)
#     update @param format
#   Natchaya P-Durden (2018-04-11)
#    applied eddy4R term name convention; replaced pos by idx or set
##############################################################################################

def.unit.extr <- function(
  data,
  nameVar,
  AllwIdx=FALSE
  ) {
  
  # Grab the variable
  var <- data[[nameVar]]

  # Get position of variable within data frame in case unit attribute is not names
  setVar <- which(names(data) == nameVar)
  
  # Assign the attributes
  if (nameVar %in% names(attr(data,"unit"))) {
    # If unit attribute is named
    attr(var,"unit") <- attr(data,"unit")[[nameVar]]
  } else {
    # If we don't allow positional determination within the unit attribute vector, stop
    if(!AllwIdx){
      stop("Cannot find variable in unit attribute list. Make sure unit attribute is a named vector corresponding to the variable names.")
    }
    # Otherwise use same position as variable within data frame
    attr(var,"unit") <- attr(data,"unit")[setVar]
  }
    
  # Assign output
  return(var)
}