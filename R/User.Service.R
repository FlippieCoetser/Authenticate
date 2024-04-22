#' User Service Constructor
#'
#' Constructs a service layer for user management that integrates validation with database
#' operations. This function provides an interface to add, retrieve, update, and delete
#' user records, ensuring that all operations are preceded by appropriate validations.
#'
#' @param broker An object that handles the data storage operations, typically a database
#'               broker with methods like \code{Insert}, \code{Select}, \code{Update}, 
#'               and \code{Delete}. This broker must support the operations expected by
#'               each service function.
#'
#' @return A list of functions that manage user data, ensuring validation and interaction
#'         with the data storage layer:
#'         \describe{
#'           \item{\code{Add}}{Validates and adds a user to the database.}
#'           \item{\code{Retrieve}}{Retrieves all users from the database.}
#'           \item{\code{RetrieveById}}{Retrieves a user by their unique ID after validating the ID format.}
#'           \item{\code{Update}}{Validates and updates a user record in the database.}
#'           \item{\code{Delete}}{Deletes a user record from the database after validating the ID format.}
#'         }
#' @export
User.Service <- \(broker) {
  validate <- User.Validator()

  services <- list()
  services[['Add']]          <- \(user) {
    user |> validate[['User']]()
    user |> broker[['Insert']]()
  }
  services[['Retrieve']]     <- \() {
    broker[['Select']]()
  }
  services[['RetrieveById']] <- \(id) {
    id |> validate[['Id']]()
    id |> broker[['SelectWhereId']]()
  }
  services[['Update']]       <- \(user) {
    user |> validate[['User']]()
    user |> broker[['Update']]()
  }
  services[['Delete']]       <- \(id) {
    id |> validate[['Id']]()
    id |> broker[['Delete']]()
  }
  return(services)
}