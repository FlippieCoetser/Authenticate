Authenticator.Validator <- \() {
  exception <- Authenticator.Validation.Exceptions()
  
  validators <- list()

  validators[['Has.Username']] <- \(field) {
    (field == "") |> exception[["Missing.Username"]]()
    return(field)
  }
  validators[['Has.Password']] <- \(field) {
    (field == "") |> exception[['Missing.Password']]()
    return(field)
  }
  validators[['Registered.Username']] <- \(field) {
    field |> isFALSE() |> exception[['Unregistered.Username']]() 
    return(field) 
  }
  validators[['Unregistered.Username']] <- \(field) {
    field |> exception[['Invalid.Username']]() 
    return(field)
  }
  validators[['Valid.Password']] <- \(field) {
    field |> isFALSE() |> exception[['Invalid.Password']]() 
    return(field) 
  }
  validators[['Incorrect.Password']] <- \(field) {
    field |> isFALSE() |> exception[['Incorrect.Password']]() 
    return(field) 
  }
  validators[['Has.RepeatedPassword']] <- \(field) {
    (field == "") |> exception[['Missing.Repeated.Password']]()
    return(field)
  }
  validators[['Match.Passwords']] <- \(password.one, password.two) {
    (password.one != password.two) |> exception[['Invalid.Repeated.Password']]()
    return(password.two)
  }
  return(validators)
}