describe('User.Service',{
  it('exist',{
    User.Service |> expect.exist()
  })
})

describe("When services <- broker |> User.Service()",{
  it("then services is a list",{
    # Given
    storage <- get.storage()
    broker  <- storage |> User.Broker()

    # When
    services <- broker |> User.Service()

    # Then
    services |> expect.list()
  })
  it("then services contains 'Add' service",{
    # Given
    storage <- get.storage()
    broker  <- storage |> User.Broker()

    # When
    services <- broker |> User.Service()

    # Then
    services[['Add']] |> expect.function()
  })
  it("then services contains 'Retrieve' service",{
    # Given
    storage <- get.storage()
    broker  <- storage |> User.Broker()

    # When
    services <- broker |> User.Service()

    # Then
    services[['Retrieve']] |> expect.function()
  })
  it("then services contains 'RetrieveById' service",{
    # Given
    storage <- get.storage()
    broker  <- storage |> User.Broker()

    # When
    services <- broker |> User.Service()

    # Then
    services[['RetrieveById']] |> expect.function()
  })
  it("then services contains 'Update' service",{
    # Given
    storage <- get.storage()
    broker  <- storage |> User.Broker()

    # When
    services <- broker |> User.Service()

    # Then
    services[['Update']] |> expect.function()
  })
  it("then services contains 'Delete' service",{
    # Given
    storage <- get.storage()
    broker  <- storage |> User.Broker()

    # When
    services <- broker |> User.Service()

    # Then
    services[['Delete']] |> expect.function()
  })
})

describe("When user |> service[['Add']]()",{
  it("then user is inserted into storage",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    user <- 'user@gmail.com' |> User.Model()

    # When
    user |> services[['Add']]()

    # Then
    user[['id']] |> broker[['SelectWhereId']]() |> expect.equal.data(user)
  })
  it("then an exception is thrown if user is NULL",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.error <- "User.NULL: User does not exist."

    # When
    user <- NULL

    # Then
    user |> services[['Add']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'id' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.error <- "Attribute.NULL: 'id' does not exist."

    # When
    user <- data.frame(
      username = '',
      hash     = '',
      salt     = ''
    )

    # Then
    user |> services[['Add']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'username' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.error <- "Attribute.NULL: 'username' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      hash     = '',
      salt     = ''
    )

    # Then
    user |> services[['Add']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'hash' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.error <- "Attribute.NULL: 'hash' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      username = '',
      salt     = ''
    )

    # Then
    user |> services[['Add']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'salt' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.error <- "Attribute.NULL: 'salt' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      username = '',
      hash     = ''
    )

    # Then
    user |> services[['Add']]() |> expect.error(expected.error)
  })
})

describe("When service[['Retrieve']]()",{
  it("then all users are retrieved from storage",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.users <- broker[['Select']]()

    # When
    users <- services[['Retrieve']]()

    # Then
    users |> expect.equal.data(expected.users)
  })
})

describe("When id |> service[['RetrieveById']]()",{
  it("then user with matching id is returned from storage",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1) 
    expected.user <- existing.user

    id <- existing.user[['id']]

    # When
    actual.user <- id |> services[['RetrieveById']]()

    # Then
    actual.user |> expect.equal.data(expected.user)
  })
  it("then an exception is thrown if 'id' is invalid",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.error <- "Identifier.Invalid: 'id' is not a valid UUID."

    # When
    id <- 'invalid'

    # Then
    id |> services[['RetrieveById']]() |> expect.error(expected.error)
  })
})

describe("When user |> service[['Update']]()",{
  it("then user with matching id is update in storage",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1)

    updated.user <- existing.user
    updated.user[['username']] <- 'updated'

    expected.user <- updated.user

    # When
    updated.user |> services[['Update']]()

    # Then
    updated.user[['id']] |> broker[['SelectWhereId']]() |> expect.equal.data(expected.user)
  })
  it("then an exception is thrown if user is NULL",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1)

    updated.user <- existing.user
    updated.user[['username']] <- 'updated'

    expected.error <- "User.NULL: User does not exist."

    # When
    user <- NULL

    # Then
    user |> services[['Update']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'id' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1)

    updated.user <- existing.user
    updated.user[['username']] <- 'updated'

    expected.error <- "Attribute.NULL: 'id' does not exist."

    # When
    user <- data.frame(
      username = '',
      hash     = '',
      salt     = ''
    )

    # Then
    user |> services[['Update']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'username' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1)

    updated.user <- existing.user
    updated.user[['username']] <- 'updated'

    expected.error <- "Attribute.NULL: 'username' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      hash     = '',
      salt     = ''
    )

    # Then
    user |> services[['Update']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'hash' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1)

    updated.user <- existing.user
    updated.user[['username']] <- 'updated'

    expected.error <- "Attribute.NULL: 'hash' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      username = '',
      salt     = ''
    )

    # Then
    user |> services[['Update']]() |> expect.error(expected.error)
  })
  it("then an exception is thrown if user has no 'salt' attribute",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1)

    updated.user <- existing.user
    updated.user[['username']] <- 'updated'

    expected.error <- "Attribute.NULL: 'salt' does not exist."

    # When
    user <- data.frame(
      id       = uuid::UUIDgenerate(),
      username = '',
      hash     = ''
    )

    # Then
    user |> services[['Update']]() |> expect.error(expected.error)
  })
})

describe("When id |> service[['Delete']]()",{
  it("then user with matching id is deleted from storage",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    existing.user <- broker[['Select']]() |> tail(1)

    id <- existing.user[['id']]

    # When
    id |> services[['Delete']]()

    # Then
    id |> broker[['SelectWhereId']]() |> expect.rows(0)
  })
  it("then an exception is thrown if 'id' is invalid",{
    # Given
    storage  <- get.storage()
    broker   <- storage |> User.Broker()
    services <- broker  |> User.Service()

    expected.error <- "Identifier.Invalid: 'id' is not a valid UUID."

    # When
    id <- 'invalid'

    # Then
    id |> services[['Delete']]() |> expect.error(expected.error)
  })
})