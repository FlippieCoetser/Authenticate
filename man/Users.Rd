% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Data.R
\docType{data}
\name{Users}
\alias{Users}
\title{Users Dataset}
\format{
A data frame with 3 rows and 4 columns:
\describe{
\item{id}{Unique identifier for the user, stored as a UUID string.}
\item{username}{Email address used as the username.}
\item{hash}{SHA-512 hashed password, as a hex string, for user authentication.}
\item{salt}{UUID string used as a salt for the password hash.}
}
}
\source{
Generated synthetic data.
}
\usage{
Users
}
\description{
This dataset contains user information for a sample application. Each record represents a user
with a unique identifier, username, hashed password, and associated salt for additional
security during the hashing process. This data can be used for authentication system examples,
security demonstrations, or testing user management functionalities.
}
\keyword{datasets}
