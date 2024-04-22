Authentication.View <- \(id) {
  ns <- shiny::NS(id)
  shiny::fluidRow(
    shiny::column(
      width = 8,
      offset = 3,
      shiny::div(
        class = 'pull-right',
        shiny::conditionalPanel(
          condition = "output.UsernameIsVisible",
          ns = ns,
          shiny::h4(shiny::textOutput(ns("username")))
        )
      )
    ),
    shiny::column(
      width = 1,
      shiny::conditionalPanel(
        condition = "output.logoutIsVisible",
        ns = ns,
        shiny::actionLink(ns("logout"),shiny::h4("Logout"))
      ),
      shiny::conditionalPanel(
        condition = "output.loginIsVisible",
        ns = ns,
        shiny::actionLink(ns("login"),shiny::h4("Login"))
      )
    )   
  )
}