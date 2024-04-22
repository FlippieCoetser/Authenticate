
Error.Missing.Username  <- \(session, target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1("RenoPilot", id='modal-heading'),
        shiny::h4("Error: Missing Username")
      )
    ),
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
        shiny::actionButton(ns(target), "Try Again", width = '100%', class = "btn-lg btn-primary")
      )
    )  
  )
}
Error.Missing.Password  <- \(session, target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1("RenoPilot", id='modal-heading'),
        shiny::h4("Error: Missing Password")
      )
    ),
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
        shiny::actionButton(ns(target), "Try Again", width = '100%', class = "btn-lg btn-primary")
      )
    )  
  )
}
Error.Missing.PasswordRepeat  <- \(session, target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1("RenoPilot", id='modal-heading'),
        shiny::h4("Error: Second Password Empty")
      )
    ),
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
        shiny::actionButton(ns(target), "Try Again", width = '100%', class = "btn-lg btn-primary")
      )
    )  
  )
}
Error.MisMatch.Passwords  <- \(session, target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1("RenoPilot", id='modal-heading'),
        shiny::h4("Error: Passwords do not match")
      )
    ),
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
        shiny::actionButton(ns(target), "Try Again", width = '100%', class = "btn-lg btn-primary")
      )
    )  
  )
}
Error.Invalid.Account <- \(session, target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1("RenoPilot", id='modal-heading'),
        shiny::h4("Error: Username Already Registered")
      )
    ),
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
        shiny::actionButton(ns(target), "Try Again", width = '100%', class = "btn-lg btn-primary")
      )
    )  
  )

}
Error.Invalid.Username <- \(session, target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1("RenoPilot", id='modal-heading'),
        shiny::h4("Error: Username Not Registered")
      )
    ),
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
        shiny::actionButton(ns(target), "Try Again", width = '100%', class = "btn-lg btn-primary")
      )
    )  
  )

}
Error.Invalid.Password <- \(session, target) {
  ns <- session[['ns']]
  shiny::modalDialog(
    easyClose = FALSE,
    footer = NULL,
    fade = FALSE,
    shiny::fluidRow(
      shiny::column(12, align="center",
        shiny::h1("RenoPilot", id='modal-heading'),
        shiny::h4("Error: Incorrect Password")
      )
    ),
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
        shiny::actionButton(ns(target), "Try Again", width = '100%', class = "btn-lg btn-primary")
      )
    )  
  )
}