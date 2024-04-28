header  <- dashboardHeader(
  title = "Test App"
)
sidebar <- dashboardSidebar(
  disable = TRUE
)
body    <- dashboardBody(
  Authenticate::View("user"),
  Custom.Style()
)

dashboardPage(
  header,
  sidebar,
  body
)