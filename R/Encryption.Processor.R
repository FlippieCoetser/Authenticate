Encryption.Processor <- \(service) {
  processors <- list()
  processors[['Set.Hash']] <- \(model, password) {
    model[['hash']] <- password |> service[['Hash.Password']](model[['salt']])
    return(model)
  }
  return(processors)
}