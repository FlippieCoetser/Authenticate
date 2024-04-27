
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
        app[['Username']] <- ''
        shiny::removeModal(session)
      }
      controller[['Start']][['login.user']]   <- \() {
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Login(session))
      }
      controller[['Start']][['signup']]       <- \() {
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Signup(session))
      }

      controller[['Login']] <- NULL
      controller[['Login']][['authenticate']] <- \() {
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
            app[['Username']]  <- input[['username']]

            Visibility[['username']] <- TRUE
            Visibility[['logout']]   <- TRUE
            Visibility[['login']]    <- FALSE

            shiny::removeModal(session)
          },
          error = \(error) {
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
            app[['Username']]  <- input[['username']]

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
        app[['Username']]  <- NULL
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::removeModal(session)
        shiny::showModal(Authentication.Modal.Start(session))
      }
      controller[['logout']] <- \() {
        user[['username']] <- NULL
        app[['Username']]  <- NULL
        Visibility[['username']] <- FALSE
        Visibility[['logout']]   <- FALSE
        Visibility[['login']]    <- FALSE
        shiny::showModal(Authentication.Modal.Start(session))
      }
      controller[['login']]  <- \() {
        user[['username']] <- NULL
        app[['Username']]  <- NULL
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