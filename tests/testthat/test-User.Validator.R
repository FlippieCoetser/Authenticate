describe('User.Validator',{
  it('exist',{
    User.Validator |> expect.exist()
  })
})

describe("When validators <- User.Validator()",{
  it("then validators is a list",{
    # When
    validators <- User.Validator()
    
    # Then
    validators |> expect.list()
  })
  it("then validators contains 'User' validator",{
    # When
    validators <- User.Validator()
    
    # Then
    validators[['User']] |> expect.exist()
  })
  it("then validators contains 'Exists' validator",{
    # When
    validators <- User.Validator()
    
    # Then
    validators[['Exists']] |> expect.exist()
  })
  it("then validators contains 'Has.Id' validator",{
    # When
    validators <- User.Validator()
    
    # Then
    validators[['Has.Id']] |> expect.exist()
  })
  it("then validators contains 'Has.Username' validator",{
    # When
    validators <- User.Validator()
    
    # Then
    validators[['Has.Username']] |> expect.exist()
  })
  it("then validators contains 'Has.Hash' validator",{
    # When
    validators <- User.Validator()
    
    # Then
    validators[['Has.Hash']] |> expect.exist()
  })
  it("then validators contains 'Has.Salt' validator",{
    # When
    validators <- User.Validator()
    
    # Then
    validators[['Has.Salt']] |> expect.exist()
  })
  it("then validators contains 'Id' validator",{
    # When
    validators <- User.Validator()
    
    # Then
    validators[['Id']] |> expect.exist()
  })
})

describe("When user |> validate[['Exists']]()",{
  it("then no exception is thrown if user is not NULL",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    output <- user |> validate[['Exists']]()

    # Then
    output |> expect.no.error()
  })
  it("then an exception is thrown if user is NULL",{
    # Given
    validate <- User.Validator()

    expected.error <- "User.NULL: User does not exist."
    # When
    user <- NULL

    # Then
    user |> validate[['Exists']]() |> expect.error(expected.error)
  })
  it("then user is returned if user is not NULL",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    output <- user |> validate[['Exists']]()

    # Then
    output |> expect.equal.data(user)
  })
})

describe("When user |> validate[['Has.Id']]()",{
  it("then no exception is thrown if user has 'id' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    # Then
    user |> validate[['Has.Id']]() |> expect.no.error()
  })
  it("then an exception is thrown if user has no 'id' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'id' does not exist."

    # When
    user <- data.frame()

    # Then
    user |> validate[['Has.Id']]() |> expect.error(expected.error)
  })
  it("then user is returned if user has 'id' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    output <- user |> validate[['Has.Id']]() 

    # Then
    output |> expect.equal.data(user)
  })
})

describe("When user |> validate[['Has.Username']]()",{
  it("then no exception is thrown if user has 'username' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    # Then
    user |> validate[['Has.Username']]() |> expect.no.error()
  })
  it("then an exception is thrown if user has no 'username' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'username' does not exist."

    # When
    user <- data.frame()

    # Then
    user |> validate[['Has.Username']]() |> expect.error(expected.error)
  })
  it("then user is returned if user has 'username' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    output <- user |> validate[['Has.Username']]()

    # Then
    output |> expect.equal.data(user)
  })
})

describe("When user |> validate[['Has.Hash']]()",{
  it("then no exception is thrown if user has 'hash' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    # Then
    user |> validate[['Has.Hash']]() |> expect.no.error()
  })
  it("then an exception is thrown if user has no 'hash' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'hash' does not exist."

    # When
    user <- data.frame()

    # Then
    user |> validate[['Has.Hash']]() |> expect.error(expected.error)
  })
  it("then user is returned if user has 'hash' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    output <- user |> validate[['Has.Hash']]()

    # Then
    output |> expect.equal.data(user)
  })
})

describe("When user |> validate[['Has.Salt']]()",{
  it("then no exception is thrown if user has 'salt' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    # Then
    user |> validate[['Has.Salt']]() |> expect.no.error()
  })
  it("then an exception is thrown if user has no 'salt' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'salt' does not exist."

    # When
    user <- data.frame()

    # Then
    user |> validate[['Has.Salt']]() |> expect.error(expected.error)
  })
  it("then user is returned if user has 'salt' attribute",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    output <- user |> validate[['Has.Salt']]()

    # Then
    output |> expect.equal.data(user)
  })
})

describe("When user |> validate[['User']]()",{
  it("then no exception is thrown if user is valid",{
    # Given
    validate <- User.Validator()

    # When
    user <- 'user@gmail.com' |> User.Model()

    # Then
    user |> validate[['User']]() |> expect.no.error()
  })
  it("then an exception is thrown if user is NULL",{
    # Given
    validate <- User.Validator()

    expected.error <- "User.NULL: User does not exist."

    # When
    user <- NULL

    # Then
    user |> validate[['User']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'id' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'id' does not exist."

    # When
    user <- data.frame(
      username = '',
      hash     = '',
      salt     = ''
    )

    # Then
    user |> validate[['User']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'username' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'username' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      hash     = '',
      salt     = ''
    )

    # Then
    user |> validate[['User']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'hash' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'hash' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      username = '',
      salt     = ''
    )

    # Then
    user |> validate[['User']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'salt' attribute",{
    # Given
    validate <- User.Validator()

    expected.error <- "Attribute.NULL: 'salt' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      username = '',
      hash     = ''
    )

    # Then
    user |> validate[['User']]() |> expect.error(expected.error)
  })
})

describe("When id |> validate[['Id']]()",{
  it("then no exception is thrown if id is valid",{
    # Given
    validate <- User.Validator()

    # When
    id <- uuid::UUIDgenerate()

    # Then
    id |> validate[['Id']]() |> expect.no.error()
  })
  it("then an exception is thrown if id is invalid",{
    # Given
    validate <- User.Validator()

    expected.error <- "Identifier.Invalid: 'id' is not a valid UUID."

    # When
    id <- 'invalid'

    # Then
    id |> validate[['Id']]() |> expect.error(expected.error)
  })
  it("then id is returned if id is an valid UUID",{
    # Given
    validate <- User.Validator()

    # When
    id <- uuid::UUIDgenerate()

    output <- id |> validate[['Id']]()

    # Then
    output |> expect.equal.data(id)
  })
})