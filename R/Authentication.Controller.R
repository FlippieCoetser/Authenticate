Authentication.Controller <- \(id, storage, app, debug = FALSE) {
  shiny::moduleServer(
    id,
    \(input, output, session) { 
      log <- \(message) if (debug) print(message)

      validate <- Authenticator.Validator()

      data <- storage |> Authentication.Orchestrator()
      
      user <- shiny::reactiveValues()
      user[['username']] <- NULL

      # UI Event Binding
      shiny::observeEvent(input[["login.guest"]], { authenticator[['Start']][["login.guest"]]()  })
      shiny::observeEvent(input[["login.user"]],  { authenticator[['Start']][["login.user"]]()   })
      shiny::observeEvent(input[["signup"]],      { authenticator[['Start']][["signup"]]()       })
      shiny::observeEvent(input[["authenticate"]],{ authenticator[['Login']][["authenticate"]]() })
      shiny::observeEvent(input[["register"]],    { authenticator[['Signup']][["register"]]()    })
      shiny::observeEvent(input[["cancel"]],      { authenticator[['cancel']]()                  })
      shiny::observeEvent(input[["logout"]],      { authenticator[["logout"]]()                  })
      shiny::observeEvent(input[["login"]],       { authenticator[["login"]]()                   })

      # UI Modal Dialogs
      showMissingUsername <- \(invoke, target) {
        if (invoke) {
          message <- paste0("Missing Username")
          shiny::showModal(Invalid.Input.Modal(session,message,target))
        }
      }
      showMissingPassword <- \(invoke, target) {
        if (invoke) {
          message <- paste0("Missing Password")
          shiny::showModal(Invalid.Input.Modal(session,message,target))
        }
      }
      showMissingPasswordRepeat <- \(invoke, target) {
        if (invoke) {
          message <- paste0("Missing Password")
          shiny::showModal(Invalid.Input.Modal(session,message,target))
        }
      }
      showInvalidUsername <- \(invoke, target) {
        if (invoke) {
          message <- paste0("Username: ", input[['username']], " not registered")
          shiny::showModal(Invalid.Input.Modal(session,message,target))
        }
      }
      showIncorrectPassword <- \(invoke, target) {
        if (invoke) {
          message <- paste0("Incorrect Password for: ", input[['username']])
          shiny::showModal(Invalid.Input.Modal(session,message,target))
        }
      }
      showMisMatchPasswords <- \(invoke, target) {
        if (invoke) {
          message <- paste0("Passwords to not match")
          shiny::showModal(Invalid.Input.Modal(session,message,target))
        }
      }
      showInvalidUsername <- \(invoke, target) {
        if (invoke) {
          message <- paste0("Unregistered Username: ", input[['username']])
          shiny::showModal(Invalid.Input.Modal(session,message,target))
        }
      }

      # UI Element Visibility
      Visibility <- shiny::reactiveValues()

      authenticator <- NULL
      authenticator[['Start']] <- NULL
      authenticator[['Initialize']]   <- \() {
        log('Initialize')
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::showModal(Authentication.Modal.Start(session))
      }
      authenticator[['Start']][['login.guest']]  <- \() {
        log('Login Guest')
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE 
        Visibility[['login']]    <- TRUE
        app[['username']] <- ''
        shiny::removeModal(session)
      }
      authenticator[['Start']][['login.user']]   <- \() {
        log('Login User')
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Login(session))
      }
      authenticator[['Start']][['signup']]       <- \() {
        log('Signup User')
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Signup(session))
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
            app[['username']]  <- input[['username']]

            # Set Component Visibility
            Visibility[['username']] <- TRUE
            Visibility[['logout']]   <- TRUE
            Visibility[['login']]    <- FALSE

            shiny::removeModal(session)
          },
          error = \(error) {

            shiny::removeModal(session)

            'Field.Missing: Username' |> grepl(error) |> showMissingUsername("login.user")
            'Field.Invalid: Unregistered Username' |> grepl(error) |> showInvalidUsername("login.user")

            'Field.Missing: Password' |> grepl(error) |> showMissingPassword("login.user")

            'Field.Invalid: Incorrect Password'    |> grepl(error) |> showIncorrectPassword("login.user")
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
            app[['username']]  <- input[['username']]

            # Set Component Visibility
            Visibility[['username']] <- TRUE
            Visibility[['logout']]   <- TRUE
            Visibility[['login']]    <- FALSE

            shiny::removeModal(session)
          },
          error = \(error) {
            shiny::removeModal(session)

            'Field.Missing: Username' |> grepl(error) |> showMissingUsername("signup")
            'Field.Invalid: Username' |> grepl(error) |> showInvalidUsername("signup")

            'Field.Missing: Password' |> grepl(error) |> showMissingPassword("signup")
            'Field.Missing: Repeated Password' |> grepl(error) |> showMissingPasswordRepeat("signup")

            'Field.Invalid: Repeated Password' |> grepl(error) |> showMisMatchPasswords("signup")  
          }
        )
      }

      authenticator[['cancel']] <- \() {
        log('Cancel')

        # Set State
        user[['username']] <- NULL
        app[['username']]  <- NULL

        # Set Component Visibility
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE


        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Start(session))
      }
      authenticator[['logout']] <- \() {
        log('Logout User')

        # Set State
        user[['username']] <- NULL
        app[['username']]  <- NULL

        # Set Component Visibility
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE


        shiny::showModal(Authentication.Modal.Start(session))
      }
      authenticator[['login']]  <- \() {
        log('Login User')

        # Set State
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

      authenticator[['Initialize']]()
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
Controller <- Authentication.Controller