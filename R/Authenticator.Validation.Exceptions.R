Authenticator.Validation.Exceptions <- \(){
  exceptions <- list()

  exceptions[['Missing.Username']] <- \(invoke) {
    if(invoke) { stop("Field.Missing: Username", call. = FALSE)}
  }
  exceptions[['Missing.Password']] <- \(invoke) {
    if(invoke) { stop("Field.Missing: Password", call. = FALSE)}
  }
  exceptions[['Missing.Repeated.Password']] <- \(invoke) {
    if(invoke) { stop("Field.Missing: Repeated Password", call. = FALSE)}
  }
  exceptions[['Unregistered.Username']] <- \(invoke) {
    if(invoke) { stop("Field.Invalid: Unregistered Username", call. = FALSE)}
  }
  exceptions[['Invalid.Password']] <- \(invoke) {
    if(invoke) { stop("Field.Invalid: Password", call. = FALSE)}
  }
  exceptions[['Incorrect.Password']] <- \(invoke) {
    if(invoke) { stop("Field.Invalid: Incorrect Password", call. = FALSE)}
  }
  exceptions[['Invalid.Repeated.Password']] <- \(invoke) {
    if(invoke) { stop("Field.Invalid: Repeated Password", call. = FALSE)}
  }
  exceptions[['Invalid.Username']] <- \(invoke) {
    if(invoke) { stop("Field.Invalid: Username", call. = FALSE)}
  }
  return(exceptions)  
}