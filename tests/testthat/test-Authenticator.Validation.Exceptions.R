describe('Authenticator.Validation.Exceptions',{
  it('exist',{
    Authenticator.Validation.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- Authenticator.Validation.Exceptions()",{
  it("then exceptions is a list",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains 'Missing.Username' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Missing.Username']] |> expect.exist()
  })
  it("then exceptions contains 'Missing.Password' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Missing.Password']] |> expect.exist()
  })
  it("then exceptions contains 'Missing.Repeated.Password' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Missing.Repeated.Password']] |> expect.exist()
  })
  it("then exceptions contains 'Unregistered.Username' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Unregistered.Username']] |> expect.exist()
  })
  it("then exceptions contains 'Invalid.Password' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Invalid.Password']] |> expect.exist()
  })
  it("then exceptions contains 'Incorrect.Password' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Incorrect.Password']] |> expect.exist()
  })
  it("then exceptions contains 'Invalid.Repeated.Password' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Invalid.Repeated.Password']] |> expect.exist()
  })
  it("then exceptions contains 'Invalid.Username' exception",{
    # When
    exceptions <- Authenticator.Validation.Exceptions()
    
    # Then
    exceptions[['Invalid.Username']] |> expect.exist()
  })
})

describe("When input |> exception[['Missing.Username']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Missing.Username']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Missing: Username"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Missing.Username']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Missing.Password']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Missing.Password']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Missing: Password"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Missing.Password']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Missing.Repeated.Password']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Missing.Repeated.Password']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Missing: Repeated Password"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Missing.Repeated.Password']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Unregistered.Username']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Unregistered.Username']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Invalid: Unregistered Username"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Unregistered.Username']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Invalid.Password']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Invalid.Password']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Invalid: Password"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Invalid.Password']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Incorrect.Password']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Incorrect.Password']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Invalid: Incorrect Password"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Incorrect.Password']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Invalid.Repeated.Password']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Invalid.Repeated.Password']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Invalid: Repeated Password"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Invalid.Repeated.Password']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Invalid.Username']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Invalid.Username']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- Authenticator.Validation.Exceptions()
    
    expected.error <- "Field.Invalid: Username"
    # When
    input <- TRUE
    
    # Then
    input |> exception[['Invalid.Username']]() |> expect.error(expected.error)
  })
})