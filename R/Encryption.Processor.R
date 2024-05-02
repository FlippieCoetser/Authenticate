#' Encryption Processor Constructor
#'
#' Creates a processor that utilizes an encryption service to handle password hashing
#' operations within a model object. This processor relies on an external encryption
#' service, passed as a parameter, to hash passwords using the service's specific 
#' cryptographic methods.
#'
#' @param service An encryption service object that provides cryptographic functions,
#' such as password hashing. This service should include a \code{Hash.Password} function
#' that accepts a password and salt, returning a hashed password.
#'
#' @return A list of functions that perform operations on model data, specifically:
#'   \describe{
#'     \item{\code{Set.Hash}}{
#'       Updates a model object with a hashed password. The model must have a `hash` 
#'       field and a `salt` field. The password is hashed using the provided salt 
#'       and the hash function from the encryption service.
#'       \itemize{
#'         \item \code{model}: The model object containing the user data.
#'         \item \code{password}: The plain text password to be hashed.
#'       }
#'       Returns the modified model object with the hashed password.
#'     }
#'   }
#' @export
Encryption.Processor <- \(service) {
  processors <- list()
  processors[['Set.Hash']] <- \(model, password) {
    model[['hash']] <- password |> service[['Hash.Password']](model[['salt']])
    return(model)
  }
  return(processors)
}