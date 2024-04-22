describe('User.Processor',{
  it('exist',{
    User.Processor |> expect.exist()
  })
})

describe("When processors <- service |> User.Processor()",{
  it("then processors is a list",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors |> expect.list()
  })
  it("then processors contains 'Add' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Add']] |> expect.exist()
  })
  it("then processors contains 'Upsert' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Upsert']] |> expect.exist()
  })
  it("then processors contains 'Find.User' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Find.User']] |> expect.exist()
  })
  it("then processors contains 'Update.Id' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Update.Id']] |> expect.exist()
  })
  it("then processors contains 'Update.Salt' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Update.Salt']] |> expect.exist()
  })
  it("then processors contains 'Match.Id' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Match.Id']] |> expect.exist()
  })
  it("then processors contains 'Match.Hash' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Match.Hash']] |> expect.exist()
  })
  it("then processors contains 'Match.Username' processor",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()

    # When
    processors <- service |> User.Processor()

    # Then
    processors[['Match.Username']] |> expect.exist()
  })
})

describe("When user |> process[['Add']]()",{
  it("then user is added to storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    new.user <- 'user' |> User()

    expected.user <- new.user

    # When
    new.user |> process[['Add']]()

    # Then
    actual.user <- new.user[['id']] |> service[['RetrieveById']]()

    actual.user |> expect.equal.data(expected.user)
  })
})

describe("When user |> process[['Upsert']]()",{
  it("then user is added to storage if user does not exist",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    new.user <- 'user' |> User()

    expected.user <- new.user

    # When
    new.user |> process[['Upsert']]()

    # Then
    actual.user <- new.user[['id']] |> service[['RetrieveById']]()

    actual.user |> expect.equal.data(expected.user)
  })
  it("then user is updated in storage if user exist",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    existing.user <- service[['Retrieve']]() |> tail(1)

    updated.user  <- existing.user
    updated.user[['username']] <- 'updated.user'

    expected.user <- updated.user

    # When
    updated.user |> process[['Upsert']]()

    # Then
    actual.user <- updated.user[['id']] |> service[['RetrieveById']]()

    actual.user |> expect.equal.data(expected.user)
  })
})

describe("When username |> process[['Find.User']]()",{
  it("then returns user with matching username",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()
    
    existing.user <- service[['Retrieve']]() |> tail(1)

    username <- existing.user[['username']]

    expected.user <- existing.user

    # When
    actual.user <- username |> process[['Find.User']]()

    # Then
    actual.user |> expect.equal.data(expected.user)
  })
})

describe("When user |> process[['Update.Id']]()",{
  it("then user[['id']] is updated using value in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    existing.user <- service[['Retrieve']]() |> tail(1)

    user <- existing.user
    user[['id']] <- ''
    
    expected.user <- existing.user

    # When
    updated.user <- user |> process[['Update.Id']]()

    # Then
    updated.user[['id']] |> expect.equal(expected.user[['id']])
  })
})

describe("When user |> process[['Update.Salt']]()",{
  it("then user[['salt']] is updated using value in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    existing.user <- service[['Retrieve']]() |> tail(1)

    user <- existing.user
    user[['salt']] <- ''
    
    expected.user <- existing.user

    # When
    updated.user <- user |> process[['Update.Salt']]()

    # Then
    updated.user[['salt']] |> expect.equal(expected.user[['salt']])
  })
})

describe("When user |> process[['Match.Username']]()",{
  it("then returns TRUE if user with matching username found in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    user <-  service[['Retrieve']]() |> tail(1)

    # When
    result <- user |> process[['Match.Username']]()

    # Then
    result |> expect.equal(TRUE)
  })
  it("then returns FALSE if no user with matching username found in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    user <- 'not.existing.user' |> User()

    # When
    result <- user |> process[['Match.Username']]()

    # Then
    result |> expect.equal(FALSE)
  })
})

describe("When user |> process[['Match.Hash']]()",{
  it("then returns TRUE if user has matching hash in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    user <-  service[['Retrieve']]() |> tail(1)

    # When
    result <- user |> process[['Match.Hash']]()

    # Then
    result |> expect.equal(TRUE)
  })
  it("then returns FALSE if user does not have matching hash in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()
    process <- service |> User.Processor()

    user <-  service[['Retrieve']]() |> tail(1)
    user[['hash']] <- 'not.existing.hash'

    # When
    result <- user |> process[['Match.Hash']]()

    # Then
    result |> expect.equal(FALSE)
  })
})

describe("When user |> process[['Match.Id']]()",{
  it("then returns TRUE if user has matching id in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service() 
    process <- service |> User.Processor()

    user <-  service[['Retrieve']]() |> tail(1)

    # When
    result <- user |> process[['Match.Id']]()

    # Then
    result |> expect.equal(TRUE)
  })
  it("then returns FALSE if use does not have matching id in storage",{
    # Given
    storage <- get.storage()

    service <- storage |> User.Broker() |> User.Service()
    process <- service |> User.Processor()

    user <-  service[['Retrieve']]() |> tail(1)
    user[['id']] <- uuid::UUIDgenerate()

    # When
    result <- user |> process[['Match.Id']]()

    # Then
    result |> expect.equal(FALSE)
  })
})