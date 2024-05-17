
Authenticator.Start.Modal  <- \(session,title) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1(title, id='modal-heading'),
        shiny::h4("Login")
      )
    ),
    shiny::br(),
    shiny::actionButton(ns("login.guest"), "Guest", width = '100%', class = "btn-lg"),
    shiny::br(),
    shiny::hr(),
    shiny::actionButton(ns("login.user"), "User", width = '100%', class = "btn-lg"),
    shiny::br(),
    shiny::br(),
    shiny::h4("Want to create and save multiple designs? Simply sign-up to activate your account"),
    shiny::br(),
    shiny::actionButton(ns("signup"), "Sign-up!", width = '100%', class = "btn-lg btn-primary"),
    shiny::br()
  )
}