describe('User.Validation.Exceptions',{
  it('exist',{
    User.Validation.Exceptions |> expect.exist()
  })
})

describe("When exceptions <- User.Validation.Exceptions()",{
  it("then exceptions is a list",{
    # When
    exceptions <- User.Validation.Exceptions()
    
    # Then
    exceptions |> expect.list()
  })
  it("then exceptions contains 'User.NULL'",{
    # When
    exceptions <- User.Validation.Exceptions()
    
    # Then
    exceptions[['User.NULL']] |> expect.exist()
  })
  it("then exceptions contains 'Attribute.NULL'",{
    # When
    exceptions <- User.Validation.Exceptions()
    
    # Then
    exceptions[['Attribute.NULL']] |> expect.exist()
  })
})

describe("When input |> exception[['User.NULL']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- User.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['User.NULL']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- User.Validation.Exceptions()
    
    expected.error <- "User.NULL: User does not exist."
    # When
    input <- TRUE
    
    # Then
    input |> exception[['User.NULL']]() |> expect.error(expected.error)
  })
})

describe("When input |> exception[['Attribute.NULL']]()", {
  it("then no exception is thrown if input is FALSE", {
    # Given
    exception <- User.Validation.Exceptions()
    
    # When
    input <- FALSE
    
    # Then
    input |> exception[['Attribute.NULL']]() |> expect.no.error()
  })
  it("then an exception is thrown if input is TRUE", {
    # Given
    exception <- User.Validation.Exceptions()
    
    attribute <- 'Attribute'

    expected.error <- paste0("Attribute.NULL: '", attribute, "' does not exist.")

    # When
    input <- TRUE
    
    # Then
    input |> exception[['Attribute.NULL']](attribute) |> expect.error(expected.error)
  })
})