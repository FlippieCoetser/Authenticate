#' User Validator Component
#'
#' This function creates a suite of validators for checking the integrity of user data.
#' It encapsulates various checks to ensure that user objects meet expected criteria,
#' such as non-null values for essential attributes and specific format validations.
#' Each validator function is designed to throw a specific exception from
#' \code{User.Validation.Exceptions} if the validation fails.
#'
#' @return A list of validator functions, which includes:
#' \describe{
#'   \item{\code{User}}{Validates a complete user object by sequentially applying all individual attribute checks.}
#'   \item{\code{Exists}}{Checks if the user object is not NULL.}
#'   \item{\code{HasId}, \code{HasUsername}, \code{HasHash}, \code{HasSalt}}{Ensures that each respective attribute is not NULL.}
#'   \item{\code{Id}}{Validates that the user ID is in UUID format.}
#' }
#' @export
User.Validator <- \() {
  exception <- User.Validation.Exceptions()

  validators <- Validate::Validator()
  validators[['User']]        <- \(user) {
    user |> validators[['Exists']]() 
    user |> validators[['Has.Id']]() 
    user |> validators[['Has.Username']]() 
    user |> validators[['Has.Hash']]() 
    user |> validators[['Has.Salt']]()
  }
  validators[['Exists']]      <- \(user) {
    user |> validators[['is.not.NULL']]('user') |> 
      tryCatch(error = \(...) {TRUE |> exception[['User.NULL']]()})
    return(user)
  }
  validators[['Has.Id']]       <- \(user) {
    user[['id']] |> validators[['is.not.NULL']]('id') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('id')})
    return(user)
  }
  validators[['Has.Username']] <- \(user) {
    user[['username']] |> validators[['is.not.NULL']]('username') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('username')})
    return(user)
  }
  validators[['Has.Hash']]     <- \(user) {
    user[['hash']] |> validators[['is.not.NULL']]('hash') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('hash')})
    return(user)
  }
  validators[['Has.Salt']]     <- \(user) {
    user[['salt']] |> validators[['is.not.NULL']]('salt') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('salt')})
    return(user)
  }
  validators[['Id']]          <- \(id) {
    id |> validators[['is.UUID']]('id')
    return(id)
  }
  return(validators)
}