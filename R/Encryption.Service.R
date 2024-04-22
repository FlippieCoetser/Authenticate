#' Encryption Service Constructor
#'
#' Creates an encryption service that provides cryptographic functionalities, 
#' specifically for hashing passwords. This service uses SHA-512 hashing algorithm 
#' to combine a password with a salt and generate a hashed output.
#'
#' @return A list containing cryptographic functions, including:
#'   \describe{
#'     \item{\code{Hash.Password}}{
#'       Combines a password with a salt and computes a SHA-512 hash.
#'       \itemize{
#'         \item \code{password}: The plain text password to be hashed.
#'         \item \code{salt}: A string used to salt the password to enhance security.
#'       }
#'       Returns a hashed string using SHA-512 algorithm.
#'     }
#'   }
#' @export
Encryption.Service <- \() {
  services <- list()
  services[['Hash.Password']] <- \(password, salt) {
    salt |> paste(password) |> digest::digest(algo = 'sha512', serialize = FALSE)
  }
  return(services)
}