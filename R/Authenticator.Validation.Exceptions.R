Authenticator.Validation.Exceptions <- \(){
  exceptions <- list()

  exceptions[['Missing.Username']] <- \(invoke) {
    if(invoke) { stop("Missing Username", call. = FALSE)}
  }
  exceptions[['Missing.Password']] <- \(invoke) {
    if(invoke) { stop("Missing Password", call. = FALSE)}
  }
  exceptions[['Missing.Repeated.Password']] <- \(invoke) {
    if(invoke) { stop("Missing Repeated Password", call. = FALSE)}
  }
  exceptions[['Unregistered.Username']] <- \(invoke) {
    if(invoke) { stop("Unregistered Username", call. = FALSE)}
  }
  exceptions[['Invalid.Password']] <- \(invoke) {
    if(invoke) { stop("Invalid Password", call. = FALSE)}
  }
  exceptions[['Invalid.Repeated.Password']] <- \(invoke) {
    if(invoke) { stop("Invalid Repeated Password", call. = FALSE)}
  }
  exceptions[['Invalid.Username']] <- \(invoke) {
    if(invoke) { stop("Invalid Username", call. = FALSE)}
  }
  return(exceptions)  
}