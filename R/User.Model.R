#' User Business Entity
#' 
#' @description
#' User Business Entity is a data.frame with the following attributes:
#' - id
#' - username
#' - hash
#' - salt
#' 
#' Both id and salt are UUIDs and auto-generated on instantiation.
#' 
#' @param username The username of the user
#' @export 
User.Model <- \(username) data.frame(
  id       = uuid::UUIDgenerate(),
  username = username,
  hash     = '',
  salt     = uuid::UUIDgenerate()
)