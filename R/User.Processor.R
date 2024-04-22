User.Processor <- \(service) {
  processors <- list()
  processors[['Add']]                <- \(user) {
    user |> service[['Add']]()
  }
  processors[['Upsert']]             <- \(user) {
    matching.id <- user |> processors[['Match.Id']]()

    if(!matching.id) user |> service[['Add']]()
    if(matching.id)  user |> service[['Update']]()
  }
  processors[['Find.User']]          <- \(username) { 
    users <- service[['Retrieve']]()
    users <- users[users[['username']] == username,]
    return(users)
  }
  processors[['Update.Id']]          <- \(user) {
    matching.user <- user[['username']] |> processors[['Find.User']]()

    user[['id']] <- matching.user[['id']]
    return(user)
  }
  processors[['Update.Salt']]        <- \(user) {
    matching.user <- user[['id']] |> service[['RetrieveById']]()

    user[['salt']] <- matching.user[['salt']]
    return(user)
  }
  processors[['Match.Id']]        <- \(user) {
    matching.user <- user[['id']] |> service[['RetrieveById']]()
    (matching.user[['id']] == user[['id']]) |> any()
  }
  processors[['Match.Hash']] <- \(user) {
    matching.user <- user[['id']] |> service[['RetrieveById']]()
    (matching.user[['hash']] == user[['hash']]) |> any()
  }
  processors[['Match.Username']]  <- \(user) {
    matching.user <- user[['id']] |> service[['RetrieveById']]()
    (matching.user[['username']] == user[['username']]) |> any()
  }
  return(processors)
}