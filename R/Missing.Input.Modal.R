Missing.Input.Modal  <- \(session, input,target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    size = "s",
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h3("Error", id='modal-heading'),
        shiny::h4(paste0("Missing input: ", input))
      )
    ),
    shiny::br(),
    shiny::fluidRow(
      shiny::column(
        6, 
        align="center",
        style = "padding-right: 5px; padding-left: 15px;",
        shiny::actionButton(ns("cancel"), "Cancel", width = '100%')
      ),
      shiny::column(
        6, 
        align="center",
        style = "padding-left: 5px; padding-right: 15px;",
        shiny::actionButton(ns(target), "Retry", width = '100%', class = "btn-primary")
      )
    )  
  )
}