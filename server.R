shinyServer(\(input, output, session) {
  user <- reactiveValues()
  user[['username']]   <- NULL

  Authenticate::Controller("user", storage, user)
})
