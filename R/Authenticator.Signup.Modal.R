Authenticator.Signup.Modal <- \(session,title) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1(title, id='modal-heading'),
        shiny::h4("Sign-up")
      )
    ),
    shiny::br(),
    shiny::textInput(ns("username"), "Username", value = NULL, width = '100%', placeholder = "Enter e-mail address"),
    shiny::br(),
    shiny::passwordInput(ns("password"), "Password", value = NULL, width = '100%', placeholder = "Enter password"),
    shiny::br(),
    shiny::passwordInput(ns("passwordRepeat"), "Repeat Password", value = NULL, width = '100%', placeholder = "Repeat password"),
    shiny::br(),
    shiny::br(),
    shiny::fluidRow(
      shiny::column(
        6, 
        align="center",
        shiny::actionButton(ns("cancel"), "Cancel", width = '100%',class = "btn-lg")
      ),
      shiny::column(
        6, 
        align="center",
        shiny::actionButton(ns("register"), "Register", width = '100%', class = "btn-lg btn-primary")
      )
    ),
    shiny::br()
  )
}