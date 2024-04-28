Error.Modal <- \() {
  modals <- list()
  modals[['Missing.Username']]       <- \(invoke, session, target) {
    if (invoke) {
      shiny::showModal(Invalid.Input.Modal(session,"Missing Username",target))
    }
  }
  modals[['Missing.Password']]       <- \(invoke, session, target) {
    if (invoke) {
      shiny::showModal(Invalid.Input.Modal(session,"Missing Password",target))
    }
  }
  modals[['Missing.PasswordRepeat']] <- \(invoke, session, target) {
    if (invoke) {
      shiny::showModal(Invalid.Input.Modal(session,"Missing Password Repeat",target))
    }
  }
  modals[['Invalid.Username']]       <- \(invoke, session, target) {
    if (invoke) {
      shiny::showModal(Invalid.Input.Modal(session,"Username already registered",target))
    }
  }
  modals[['Incorrect.Password']]     <- \(invoke, session, target) {
    if (invoke) {
      shiny::showModal(Invalid.Input.Modal(session,"Incorrect Password",target))
    }
  }
  modals[['Mismatch.Passwords']]     <- \(invoke, session, target) {
    if (invoke) {
      shiny::showModal(Invalid.Input.Modal(session,"Passwords to not match",target))
    }
  }
  modals[['Unregistered.Username']]  <- \(invoke, session, target) {
    if (invoke) {
      shiny::showModal(Invalid.Input.Modal(session,"Unregistered Username",target))
    }
  }
  return(modals)
}