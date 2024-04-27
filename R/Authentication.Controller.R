Authentication.Controller <- \(id, storage, app) {
  shiny::moduleServer(
    id,
    \(input, output, session) {  
      validate <- Authentication.Validator()

      User.data <- storage |> Authentication.Orchestrator()
      
      user <- shiny::reactiveValues()
      user[['username']] <- NULL

      # UI Event Binding
      shiny::observeEvent(input[["login.guest"]], { controller[['Start']][["login.guest"]]()  })
      shiny::observeEvent(input[["login.user"]],  { controller[['Start']][["login.user"]]()   })
      shiny::observeEvent(input[["signup"]],      { controller[['Start']][["signup"]]()       })
      shiny::observeEvent(input[["authenticate"]],{ controller[['Login']][["authenticate"]]() })
      shiny::observeEvent(input[["register"]],    { controller[['Signup']][["register"]]()    })
      shiny::observeEvent(input[["cancel"]],      { controller[['cancel']]()                  })
      shiny::observeEvent(input[["logout"]],      { controller[["logout"]]()                  })
      shiny::observeEvent(input[["login"]],       { controller[["login"]]()                   })

      # UI Element Visibility
      Visibility <- shiny::reactiveValues()
      Visibility[['username']] <- FALSE
      Visibility[['logout']]   <- FALSE
      Visibility[['login']]    <- FALSE

      controller <- NULL
      controller[['Start']] <- NULL
      controller[['Start']][['Initialize']]   <- \() {
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::showModal(Authentication.Modal.Start(session))
      }
      controller[['Start']][['login.guest']]  <- \() {
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE 
        Visibility[['login']]    <- TRUE
        app[['username']] <- ''
        shiny::removeModal(session)
      }
      controller[['Start']][['login.user']]   <- \() {
        print('Login User')
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Login(session))
      }
      controller[['Start']][['signup']]       <- \() {
        print('Signup User')
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Signup(session))
      }

      controller[['Login']] <- NULL
      controller[['Login']][['authenticate']] <- \() {
        print('Authenticate User')
        tryCatch(
          {
            input[['username']] |> validate[['UsernameEmpty']]()

            input[['password']] |> validate[['PasswordEmpty']]()

            input[['username']] |> User() |> 
              User.data[['Matching.Username']]() |> validate[['AccountExist']]()

            input[['username']] |> User() |>
              User.data[['Authenticate']](input[['password']]) |>
              validate[['CorrectPassword']]()
            
            user[['username']] <- input[['username']]
            app[['username']]  <- input[['username']]

            print(paste0("User: ", user[['username']]))

            Visibility[['username']] <- TRUE
            Visibility[['logout']]   <- TRUE
            Visibility[['login']]    <- FALSE

            shiny::removeModal(session)
          },
          error = \(error) {
            print(error)
            shiny::removeModal(session)

            showMissingUsername <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Missing.Username(session,"login.user"))
              }
            }
            showMissingPassword <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Missing.Password(session,"login.user"))
              }
            }
            showInvalidUsername <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Invalid.Username(session,"login.user"))
              }
            }
            showIncorrectPassword <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Invalid.Password(session,"login.user"))
              }
            }

            'no Username entered'     |> grepl(error) |> showMissingUsername()
            'no Password entered'     |> grepl(error) |> showMissingPassword()
            'Username not registered' |> grepl(error) |> showInvalidUsername()
            'Incorrect Password'      |> grepl(error) |> showIncorrectPassword()
          }
        )
      }

      controller[['Signup']] <- NULL
      controller[['Signup']][['register']] <- \() {
        print('Register User')
        tryCatch(
          {
            input[['username']] |> validate[['UsernameEmpty']]()

            input[['password']] |> validate[['PasswordEmpty']]()

            input[['passwordRepeat']] |> validate[['PasswordRepeatEmpty']]()

            input[['password']] |> validate[['PasswordsMatch']](input[['passwordRepeat']])

            input[['username']] |> User() |> 
              User.data[['Matching.Username']]() |> validate[['InvalidUsername']]()

            input[['username']] |>
              User() |> User.data[['Register']](input[['password']])

            user[['username']] <- input[['username']]
            app[['username']]  <- input[['username']]

            Visibility[['username']] <- TRUE
            Visibility[['logout']]   <- TRUE
            Visibility[['login']]    <- FALSE

            shiny::removeModal(session)
          },
          error = \(error) {
            shiny::removeModal(session)

            showMissingUsername <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Missing.Username(session,"signup"))
              }
            }
            showMissingPassword <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Missing.Password(session,"signup"))
              }
            }
            showMissingPasswordRepeat <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Missing.PasswordRepeat(session,"signup"))
              }
            }
            showMisMatchPasswords <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.MisMatch.Passwords(session,"signup"))
              }
            }
            showInvalidUsername <- \(invoke) {
              if (invoke) {
                shiny::showModal(Error.Invalid.Account(session,"signup"))
              }
            }

            'no Username entered' |> grepl(error) |> showMissingUsername()
            'no Password entered' |> grepl(error) |> showMissingPassword()
            'no second Password entered' |> grepl(error) |> showMissingPasswordRepeat()
            'Passwords do not match' |> grepl(error) |> showMisMatchPasswords()
            'Username already registered' |> grepl(error) |> showInvalidUsername()
          }
        )
      }

      controller[['cancel']] <- \() {
        user[['username']] <- NULL
        app[['username']]  <- NULL
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Start(session))
      }
      controller[['logout']] <- \() {
        print('Logout User')
        user[['username']] <- NULL
        app[['username']]  <- NULL
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::showModal(Authentication.Modal.Start(session))
      }
      controller[['login']]  <- \() {
        print('Login User')
        user[['username']] <- NULL
        app[['username']]  <- NULL
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::showModal(Authentication.Modal.Start(session))
      }  

      # UI Data Bindings
      output[['username']] <- shiny::renderText({ user[['username']] })

      # UI Element Visibility Binding
      output[['UsernameIsVisible']] <- shiny::reactive({ Visibility[['username']] })
      output[['logoutIsVisible']]   <- shiny::reactive({ Visibility[['logout']]   })
      output[['loginIsVisible']]    <- shiny::reactive({ Visibility[['login']]    })
      shiny::outputOptions(output, 'UsernameIsVisible', suspendWhenHidden = FALSE)
      shiny::outputOptions(output, 'logoutIsVisible'  , suspendWhenHidden = FALSE)
      shiny::outputOptions(output, 'loginIsVisible'   , suspendWhenHidden = FALSE)

      controller[['Start']][['Initialize']]()
    }
  )
}

#' Authentication Controller for Shiny Application
#'
#' This function manages user authentication within a Shiny application. It
#' sets up a module server for handling user interactions related to login,
#' registration, and session management. It includes mechanisms to validate
#' user inputs, manage user session states, and dynamically update UI elements
#' based on the authentication state.
#'
#' @param id A unique identifier for the Shiny module.
#' @param storage A storage backend, presumably for managing user data.
#' @param app A reference to the main Shiny app object, used to manage global states.
#'
#' @details
#' The function creates a series of event observers and reactive expressions that:
#' - Handle guest and registered user logins.
#' - Manage user registration.
#' - Authenticate user credentials.
#' - Provide functionality for user logout and cancellation of operations.
#' - Dynamically control the visibility of UI elements such as username display and login/logout buttons based on the user's authentication status.
#'
#' Each user interaction is validated through a set of predefined validation functions,
#' and the UI is updated accordingly to reflect the current state. Errors in user input
#' are handled gracefully, providing modal dialogs to inform users of specific issues.
#'
#' @return A Shiny module server function that can be invoked with `callModule`.
#'
#' @export
Controller <- Authentication.Controller