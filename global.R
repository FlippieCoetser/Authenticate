library(shiny)
library(shinydashboard)
library(uuid)

Custom.Style <- \() tags[['head']](
  tags[['link']](
    rel = "stylesheet",
    type = "text/css",
    href = "style.css"
  )
)

storage <- data.frame() |> Storage::Storage(type = "memory")
Authenticate::Users |> storage[['seed.table']]('User')