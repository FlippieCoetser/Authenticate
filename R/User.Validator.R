#' User Validator Component
#'
#' This function creates a suite of validators for checking the integrity of user data.
#' It encapsulates various checks to ensure that user objects meet expected criteria,
#' such as non-null values for essential attributes and specific format validations.
#' Each validator function is designed to throw a specific exception from 
#' `User.Validation.Exceptions` if the validation fails.
#'
#' The validators include checks for:
#'   - Existence of the user object.
#'   - Presence of essential attributes like ID, username, hash, and salt.
#'   - Specific format checks, such as UUID format for ID.
#'
#' @return A list of validator functions which include:
#'   \itemize{
#'     \item{\code{User}:}{Validates a complete user object by sequentially applying all individual attribute checks.}
#'     \item{\code{Exists}:}{Checks if the user object is not NULL.}
#'     \item{\code{HasId}, \code{HasUsername}, \code{HasHash}, \code{HasSalt}:}{Ensure that each respective attribute is not NULL.}
#'     \item{\code{Id}:}{Validates that the user ID is in UUID format.}
#'   }
#' @export
User.Validator <- \() {
  exception <- User.Validation.Exceptions()

  validators <- Validate::Validator()
  validators[['User']]        <- \(user) {
    user |> validators[['Exists']]() 
    user |> validators[['HasId']]() 
    user |> validators[['HasUsername']]() 
    user |> validators[['HasHash']]() 
    user |> validators[['HasSalt']]()
  }
  validators[['Exists']]      <- \(user) {
    user |> validators[['Is.Not.NULL']]('user') |> 
      tryCatch(error = \(...) {TRUE |> exception[['User.NULL']]()})
    return(user)
  }
  validators[['HasId']]       <- \(user) {
    user[['id']] |> validators[['Is.Not.NULL']]('id') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('id')})
    return(user)
  }
  validators[['HasUsername']] <- \(user) {
    user[['username']] |> validators[['Is.Not.NULL']]('username') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('username')})
    return(user)
  }
  validators[['HasHash']]     <- \(user) {
    user[['hash']] |> validators[['Is.Not.NULL']]('hash') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('hash')})
    return(user)
  }
  validators[['HasSalt']]     <- \(user) {
    user[['salt']] |> validators[['Is.Not.NULL']]('salt') |>
      tryCatch(error = \(...) { TRUE |> exception[['Attribute.NULL']]('salt')})
    return(user)
  }
  validators[['Id']]          <- \(id) {
    id |> validators[['Is.UUID']]('id')
    return(id)
  }
  return(validators)
}