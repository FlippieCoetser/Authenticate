describe('Authenticator.Validator',{
  it('exist',{
    Authenticator.Validator |> expect.exist()
  })
})

describe("When validators <- Authenticator.Validator()",{
  it("then validators is a list",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators |> expect.list()
  })
  it("then validators contains 'Has.Username' validator",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators[['Has.Username']] |> expect.exist()
  })
  it("then validators contains 'Has.Password' validator",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators[['Has.Password']] |> expect.exist()
  })
  it("then validators contains 'Registered.Username' validator",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators[['Registered.Username']] |> expect.exist()
  })
  it("then validators contains 'Unregistered.Username' validator",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators[['Unregistered.Username']] |> expect.exist()
  })
  it("then validators contains 'Valid.Password' validator",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators[['Valid.Password']] |> expect.exist()
  })
  it("then validators contains 'Has.RepeatedPassword' validator",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators[['Has.RepeatedPassword']] |> expect.exist()
  })
  it("then validators contains 'Match.Passwords' validator",{
    # When
    validators <- Authenticator.Validator()
    
    # Then
    validators[['Match.Passwords']] |> expect.exist()
  })
})

describe("When field |> validate[['Has.Username']]()",{
  it("then no exception is thrown if field is not empty",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- 'user@gmail.com' 

    # Then
    field |> validate[['Has.Username']]() |> expect.no.error()
  })
  it("then an exception is thrown if field is empty",{
    # Given
    validate <- Authenticator.Validator()

    expected.error <- "Field.Missing: Username"

    # When
    field <- ''

    # Then
    field |> validate[['Has.Username']]() |> expect.error(expected.error)
  })
  it("then field is returned if field is not empty",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- 'user@gmail.com' 

    output <- field |> validate[['Has.Username']]()

    # Then
    output |> expect.equal.data(field)
  })
})

describe("When field |> validate[['Has.Password']]()",{
  it("then no exception is thrown if field is not empty",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- '1234567890' 

    # Then
    field |> validate[['Has.Password']]() |> expect.no.error()
  })
  it("then an exception is thrown if field is empty",{
    # Given
    validate <- Authenticator.Validator()

    expected.error <- "Field.Missing: Password"

    # When
    field <- ''

    # Then
    field |> validate[['Has.Password']]() |> expect.error(expected.error)
  })
  it("then field is returned if field is not empty",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- '1234567890' 

    output <- field |> validate[['Has.Password']]()

    # Then
    output |> expect.equal.data(field)
  })
})

describe("When field |> validate[['Registered.Username']]()",{
  it("then no exception is thrown if field is TRUE",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- TRUE 

    # Then
    field |> validate[['Registered.Username']]() |> expect.no.error()
  })
  it("then an exception is thrown if field is FALSE",{
    # Given
    validate <- Authenticator.Validator()

    expected.error <- "Field.Invalid: Unregistered Username"

    # When
    field <- FALSE

    # Then
    field |> validate[['Registered.Username']]() |> expect.error(expected.error)
  })
  it("then field is returned if field is TRUE",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- TRUE 

    output <- field |> validate[['Registered.Username']]()

    # Then
    output |> expect.equal.data(field)
  })
})

describe("When field |> validate[['Unregistered.Username']]()",{
  it("then no exception is thrown if field is FALSE",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- FALSE

    # Then
    field |> validate[['Unregistered.Username']]() |> expect.no.error()
  })
  it("then an exception is thrown if field is TRUE",{
    # Given
    validate <- Authenticator.Validator()

    expected.error <- "Field.Invalid: Username"

    # When
    field <- TRUE

    # Then
    field |> validate[['Unregistered.Username']]() |> expect.error(expected.error)
  })
  it("then field is returned if field is FALSE",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- FALSE

    output <- field |> validate[['Unregistered.Username']]()

    # Then
    output |> expect.equal.data(field)
  })
})

describe("When field |> validate[['Valid.Password']]()",{
  it("then no exception is thrown if field is TRUE",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- TRUE 

    # Then
    field |> validate[['Valid.Password']]() |> expect.no.error()
  })
  it("then an exception is thrown if field is FALSE",{
    # Given
    validate <- Authenticator.Validator()

    expected.error <- "Field.Invalid: Password"

    # When
    field <- FALSE

    # Then
    field |> validate[['Valid.Password']]() |> expect.error(expected.error)
  })
  it("then field is returned if field is TRUE",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- TRUE 

    output <- field |> validate[['Valid.Password']]()

    # Then
    output |> expect.equal.data(field)
  })
})

describe("When repeated.password |> validate[['Has.RepeatedPassword']](password.two)",{
  it("then no exception is thrown if field is not empty",{
    # Given
    validate <- Authenticator.Validator()

    # When
    repeated.password <- '1234567890'

    # Then
    repeated.password|> validate[['Has.RepeatedPassword']]() |> expect.no.error()
  })
  it("then an exception is thrown if field is empty",{
    # Given
    validate <- Authenticator.Validator()

    expected.error <- "Field.Missing: Repeated Password"

    # When
    field <- ''

    # Then
    field |> validate[['Has.RepeatedPassword']]() |> expect.error(expected.error)
  })
  it("then field is returned if field is not empty",{
    # Given
    validate <- Authenticator.Validator()

    # When
    field <- '1234567890' 

    output <- field |> validate[['Has.RepeatedPassword']]()

    # Then
    output |> expect.equal.data(field)
  })
})

describe("When password.one |> validate[['Match.Passwords']](password.two)",{
  it("then no exception is thrown if passwords match",{
    # Given
    validate <- Authenticator.Validator()

    # When
    password.one <- '1234567890'
    password.two <- '1234567890'

    # Then
    password.two |> validate[['Match.Passwords']](password.one) |> expect.no.error()
  })
  it("then an exception is thrown if passwords do not match",{
    # Given
    validate <- Authenticator.Validator()

    expected.error <- "Field.Invalid: Repeated Password"

    # When
    password.one <- '1234567890'
    password.two <- '0987654321'

    # Then
    password.two |> validate[['Match.Passwords']](password.one) |> expect.error(expected.error)
  })
  it("then password.two is returned if passwords match",{
    # Given
    validate <- Authenticator.Validator()

    # When
    password.one <- '1234567890'
    password.two <- '1234567890'

    output <- password.two |> validate[['Match.Passwords']](password.one)

    # Then
    output |> expect.equal.data(password.two)
  })
})