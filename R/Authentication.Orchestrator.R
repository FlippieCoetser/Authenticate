#' Authentication Orchestration Service
#' 
#' @description
#' Orchestration Service used to:
#' - Register User
#' - Check Username
#' - Authenticate User
#'  
#' @param storage The storage provider to use by orchestration service
#' @export
Authentication.Orchestrator <- \(storage) {
  process <- storage |>
    User.Broker()    |>
    User.Service()   |>
    User.Processor()

  encrypt <- 
    Encryption.Service() |> 
    Encryption.Processor()

  orchestrations <- list()
  orchestrations[['Find.User']]         <- \(username) {
    username |> process[['Find.User']]()
  }
  orchestrations[['Register']]          <- \(user, password) {
    user |> encrypt[['Set.Hash']](password) |> process[['Add']]()  
  }
  orchestrations[['Match.Username']]    <- \(user) {
    user |> process[['Match.Username']]()
  }
  orchestrations[['Authenticate']]      <- \(user, password) {
    user |> 
      process[['Update.Id']]()        |> 
      process[['Update.Salt']]()      |> 
      encrypt[['Set.Hash']](password) |> 
      process[['Match.Hash']]()
  }
  return(orchestrations)
}