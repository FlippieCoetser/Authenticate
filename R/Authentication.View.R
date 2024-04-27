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
#' Authentication View for Shiny Application
#'
#' This function creates a user interface for managing authentication displays within a Shiny application.
#' It provides reactive UI elements that show the current user's username and offer login or logout actions
#' depending on the user's authentication state.
#'
#' @param id A unique identifier for the Shiny module which scopes the UI elements.
#'
#' @details
#' The view consists of:
#' - A username display that only appears if the user is logged in.
#' - A login action link that is visible when the user is not logged in.
#' - A logout action link that appears when the user is logged in.
#'
#' The visibility of these elements is controlled by Shiny's server-side logic which outputs
#' reactivity conditions. These conditions are set based on the user's authentication status,
#' ensuring that UI elements reflect the current state appropriately.
#'
#' @return A Shiny UI component that includes conditional panels for user authentication management.
#'
#' @export
View <- Authentication.View