Authentication.Exceptions <- \(){
  exceptions <- list()

  exceptions[['MissingUsername']] <- \(invoke) {
    if(invoke) { stop("no Username entered")}
  }
  exceptions[['MissingPassword']] <- \(invoke) {
    if(invoke) { stop("no Password entered")}
  }
  exceptions[['MissingPasswordRepeat']] <- \(invoke) {
    if(invoke) { stop("no second Password entered")}
  }
  exceptions[['NotRegistered']] <- \(invoke) {
    if(invoke) { stop("Username not registered")}
  }
  exceptions[['IncorrectPassword']] <- \(invoke) {
    if(invoke) { stop("Incorrect Password")}
  }
  exceptions[['PasswordsMismatch']] <- \(invoke) {
    if(invoke) { stop("Passwords do not match")}
  }
  exceptions[['InvalidUsername']] <- \(invoke) {
    if(invoke) { stop("Username already registered")}
  }
  return(exceptions)  
}