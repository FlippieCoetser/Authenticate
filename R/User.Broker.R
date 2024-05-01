#' User.Broker Component
#'
#' This component provides operations for managing user data in the storage.
#'
#' @param storage The storage object used for data persistence.
#' @return A list of operations for managing user data.
User.Broker <- \(storage) {
  sql.utilities <- Query::SQL.Utilities()
  sql.functions <- Query::SQL.Functions()

  fields <- list(
    'id'       |> sql.utilities[['BRACKET']]() |> sql.functions[['LOWER']]('id'),
    'username' |> sql.utilities[['BRACKET']](),
    'hash'     |> sql.utilities[['BRACKET']](),
    'salt'     |> sql.utilities[['BRACKET']]()
  )

  operations <- list()
  operations[['Insert']]        <- \(user) {
    user |> storage[['add']]('User')
  }
  operations[['Select']]        <- \() {
    'User' |> storage[['retrieve']]()
  }
  operations[['SelectWhereId']] <- \(id) {
    id |> storage[['retrieve.where.id']]('User', fields)
  }
  operations[['Update']]        <- \(user) {
    user |> storage[['modify']]('User')
  }
  operations[['Delete']]        <- \(id) {
    id |> storage[['remove']]('User')
  }
  return(operations)
}