% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Authenticator.View.R
\name{View}
\alias{View}
\title{Authentication View for Shiny Application}
\usage{
View(id)
}
\arguments{
\item{id}{A unique identifier for the Shiny module which scopes the UI elements.}
}
\value{
A Shiny UI component that includes conditional panels for user authentication management.
}
\description{
This function creates a user interface for managing authentication displays within a Shiny application.
It provides reactive UI elements that show the current user's username and offer login or logout actions
depending on the user's authentication state.
}
\details{
The view consists of:
\itemize{
\item A username display that only appears if the user is logged in.
\item A login action link that is visible when the user is not logged in.
\item A logout action link that appears when the user is logged in.
}

The visibility of these elements is controlled by Shiny's server-side logic which outputs
reactivity conditions. These conditions are set based on the user's authentication status,
ensuring that UI elements reflect the current state appropriately.
}
