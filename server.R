storage <- data.frame() |> Storage::Storage(type = "memory")
Authenticate::Users |> storage[['Seed.Table']]('User')

shinyServer(\(input, output, session) {
  user <- reactiveValues()
  user[['username']]   <- NULL

  reset <- \() {
    user[['username']]   <- NULL
  }

  observe({
    if (is.null(user[['username']])) {
      reset()
    } 
  })

  Authenticate::Controller("user", storage, user)
})
