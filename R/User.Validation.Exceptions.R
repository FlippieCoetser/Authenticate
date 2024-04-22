#' User Validation Exceptions Constructor
#'
#' Constructs a list of exception handling functions specifically for user validation.
#' This function provides a standardized way to handle and throw exceptions related to
#' user data integrity. Each exception function is designed to stop execution with a 
#' specific error message if invoked.
#'
#' The available exceptions are:
#'   - \code{User.NULL}: Triggered when a user object is expected but not provided.
#'   - \code{Attribute.NULL}: Triggered when a required attribute of the user object
#'     is missing.
#'
#' @return A list of functions, each corresponding to a specific type of exception related
#' to user validation. Functions are invoked with parameters controlling whether the exception
#' should be thrown and provide custom error messages.
User.Validation.Exceptions <- \() {
  exceptions <- list()
  exceptions[['User.NULL']]      <- \(invoke) {
    if(invoke) stop("User.NULL: User does not exist.", call. = FALSE)
  }
  exceptions[['Attribute.NULL']] <- \(invoke, attribute) {
    if(invoke) stop("Attribute.NULL: '", attribute, "' does not exist.", call. = FALSE)
  }
  return(exceptions)
}