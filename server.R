storage <- data.frame() |> Storage::Storage(type = "memory")
Authenticate::Users |> storage[['Seed.Table']]('User')

shinyServer(\(input, output, session) {
  state <- reactiveValues()
  state[['username']]   <- NULL

  reset <- \() {
    state[['username']]   <- NULL
  }

  observe({
    if (is.null(state[['username']])) {
      reset()
    } 
  })

  Authenticate::Controller("user", storage, state)
})
