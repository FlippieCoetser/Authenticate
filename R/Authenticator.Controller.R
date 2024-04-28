Authenticator.Controller <- \(id, storage, user = shiny::reactiveValues() , debug = FALSE) {
  shiny::moduleServer(
    id,
    \(input, output, session) { 
      log <- \(message) if (debug) print(message)

      # UI Modal Dialogs
      modal <- Authenticator.Error.Modal()
      
      # UI Element Visibility
      visibility <- shiny::reactiveValues()

      # Data Access
      data <- storage |> Authenticator.Orchestrator()

      # UI Event Binding
      shiny::observeEvent(input[["login.guest"]], { authenticator[['Start']][["login.guest"]]()  })
      shiny::observeEvent(input[["login.user"]],  { authenticator[['Start']][["login.user"]]()   })
      shiny::observeEvent(input[["signup"]],      { authenticator[['Start']][["signup"]]()       })
      shiny::observeEvent(input[["authenticate"]],{ authenticator[['Login']][["authenticate"]]() })
      shiny::observeEvent(input[["register"]],    { authenticator[['Signup']][["register"]]()    })
      shiny::observeEvent(input[["cancel"]],      { authenticator[['cancel']]()                  })
      shiny::observeEvent(input[["logout"]],      { authenticator[["logout"]]()                  })
      shiny::observeEvent(input[["login"]],       { authenticator[["login"]]()                   })

      # Validation Logic
      validate <- Authenticator.Validator()

      # Business Logic
      authenticator <- NULL
      authenticator[['init']]   <- \() {
        log('Initialize')
        user[['username']] <- NULL
        visibility[['username']] <- FALSE
        visibility[['logout']]   <- FALSE
        visibility[['login']]    <- FALSE
        shiny::showModal(Authenticator.Modal.Start(session))
      }
      authenticator[['login']]  <- \() {
        log('Login User')

        # Set State
        user[['username']] <- NULL
        
        visibility[['username']] <- FALSE
        visibility[['logout']]   <- FALSE
        visibility[['login']]    <- FALSE
        shiny::showModal(Authenticator.Modal.Start(session))
      }
      authenticator[['logout']] <- \() {
        log('Logout User')

        # Set State
        user[['username']] <- NULL

        # Set Component visibility
        visibility[['username']] <- FALSE
        visibility[['logout']]   <- FALSE
        visibility[['login']]    <- FALSE


        shiny::showModal(Authenticator.Modal.Start(session))
      }  
      authenticator[['cancel']] <- \() {
        log('Cancel')

        # Set State
        user[['username']] <- NULL

        # Set Component visibility
        visibility[['username']] <- FALSE
        visibility[['logout']]   <- FALSE
        visibility[['login']]    <- FALSE


        shiny::removeModal(session)
        shiny::showModal(Authenticator.Modal.Start(session))
      }

      authenticator[['Start']] <- NULL
      authenticator[['Start']][['login.guest']]  <- \() {
        log('Login Guest')
        visibility[['username']] <- FALSE
        visibility[['logout']]   <- FALSE 
        visibility[['login']]    <- TRUE
        user[['username']] <- ''
        shiny::removeModal(session)
      }
      authenticator[['Start']][['login.user']]   <- \() {
        log('Login User')
        visibility[['username']] <- FALSE
        visibility[['logout']]   <- FALSE
        visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authenticator.Login.Modal(session))
      }
      authenticator[['Start']][['signup']]       <- \() {
        log('Signup User')
        visibility[['username']] <- FALSE
        visibility[['logout']]   <- FALSE
        visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authenticator.Signup.Modal(session))
      }

      authenticator[['Login']] <- NULL
      authenticator[['Login']][['authenticate']] <- \() {
        tryCatch(
          {
            log('Validate User Credentials')
            input[['username']] |> validate[['Has.Username']]()
            input[['username']] |> 
              User() |> 
              data[['Match.Username']]() |> 
              validate[['Registered.Username']]()

            input[['password']] |> validate[['Has.Password']]()

            log('Authenticate User')
            input[['username']] |> User() |>
              data[['Authenticate']](input[['password']]) |>
              validate[['Correct.Password']]()
            
            # Update State
            user[['username']] <- input[['username']]

            # Set Component visibility
            visibility[['username']] <- TRUE
            visibility[['logout']]   <- TRUE
            visibility[['login']]    <- FALSE

            shiny::removeModal(session)
          },
          error = \(error) {
            shiny::removeModal(session)

            'Field.Missing: Username' |> 
              grepl(error) |> modal[['Missing.Username']](session, "login.user")

            'Field.Invalid: Unregistered Username' |> 
              grepl(error) |> modal[['Unregistered.Username']](session, "login.user")

            'Field.Missing: Password' |> 
              grepl(error) |> modal[['Missing.Password']](session, "login.user")

            'Field.Invalid: Incorrect Password' |> 
              grepl(error) |> modal[['Incorrect.Password']](session, "login.user")
          }
        )
      }

      authenticator[['Signup']] <- NULL
      authenticator[['Signup']][['register']] <- \() {
        tryCatch(
          {
            log('Validate User Registration')
            input[['username']] |> validate[['Has.Username']]()
            input[['username']] |> 
              User() |> 
              data[['Match.Username']]() |> 
              validate[['Unregistered.Username']]()

            input[['password']] |> validate[['Has.Password']]()
            input[['passwordRepeat']] |> validate[['Has.RepeatedPassword']]()
            input[['password']] |> 
              validate[['Match.Passwords']](input[['passwordRepeat']])

            log('Register User')
            input[['username']] |>
              User() |> 
              data[['Register']](input[['password']])

            # Update State
            user[['username']] <- input[['username']]

            # Set Component visibility
            visibility[['username']] <- TRUE
            visibility[['logout']]   <- TRUE
            visibility[['login']]    <- FALSE

            shiny::removeModal(session)
          },
          error = \(error) {
            shiny::removeModal(session)

            'Field.Missing: Username' |> 
              grepl(error) |> modal[['Missing.Username']](session,"signup")
            'Field.Invalid: Username' |> 
              grepl(error) |> modal[['Invalid.Username']](session, "signup")

            'Field.Missing: Password' |> 
              grepl(error) |> modal[['Missing.Password']](session, "signup")
            'Field.Missing: Repeated Password' |> 
              grepl(error) |> modal[['Missing.PasswordRepeat']](session, "signup")

            'Field.Invalid: Repeated Password' |> 
              grepl(error) |> modal[['Mismatch.Passwords']](session, "signup")  
          }
        )
      }

      # UI Data Bindings
      output[['username']] <- shiny::renderText({ user[['username']] })

      # UI Element visibility Binding
      output[['UsernameIsVisible']] <- shiny::reactive({ visibility[['username']] })
      output[['logoutIsVisible']]   <- shiny::reactive({ visibility[['logout']]   })
      output[['loginIsVisible']]    <- shiny::reactive({ visibility[['login']]    })
      shiny::outputOptions(output, 'UsernameIsVisible', suspendWhenHidden = FALSE)
      shiny::outputOptions(output, 'logoutIsVisible'  , suspendWhenHidden = FALSE)
      shiny::outputOptions(output, 'loginIsVisible'   , suspendWhenHidden = FALSE)

      authenticator[['init']]()
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
#' @param user An optional reactive values with cached user details.
#' @param debug A logical value indicating whether to print debug messages.
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
Controller <- Authenticator.Controller