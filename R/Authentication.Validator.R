Authentication.Validator <- \() {
  exception <- Authentication.Exceptions()
  
  validators <- list()

  validators[['UsernameEmpty']] <- \(username) {
    (username == "") |> exception[["MissingUsername"]]()
    return(username)
  }
  validators[['PasswordEmpty']] <- \(password) {
    (password == "") |> exception[['MissingPassword']]()
    return(password)
  }
  validators[['AccountExist']] <- \(match) {
    match |> isFALSE() |> exception[['NotRegistered']]()  
  }
  validators[['InvalidUsername']] <- \(match) {
    match |> exception[['InvalidUsername']]() 
  }
  validators[['CorrectPassword']] <- \(match) {
    match |> isFALSE() |> exception[['IncorrectPassword']]()  
  }
  validators[['PasswordRepeatEmpty']] <- \(passwordRepeat) {
    (passwordRepeat == "") |> exception[['MissingPasswordRepeat']]()
    return(passwordRepeat)
  }
  validators[['PasswordsMatch']] <- \(password, passwordRepeat) {
    (password != passwordRepeat) |> exception[['PasswordsMismatch']]()
  }
  return(validators)
}