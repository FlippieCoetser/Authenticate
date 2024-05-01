describe('Authenticator.Orchestrator',{
  it('exist',{
    Authenticator.Orchestrator |> expect.exist()
  })
})

describe("When orchestrations <- storage |> Authenticator.Orchestrator()",{
  it("then orchestrations is a list",{
    # Given
    storage <- get.storage()

    # When
    orchestrations <- storage |> Authenticator.Orchestrator()

    # Then
    orchestrations |> expect.list()
  })
  it("then orchestrations contains 'Find.User' orchestration",{
    # Given
    storage <- get.storage()

    # When
    orchestrations <- storage |> Authenticator.Orchestrator()

    # Then
    orchestrations[['Find.User']] |> expect.exist()
  })
  it("then orchestrations contains 'Register' orchestration",{
    # Given
    storage <- get.storage()

    # When
    orchestrations <- storage |> Authenticator.Orchestrator()

    # Then
    orchestrations[['Register']] |> expect.exist()
  })
  it("then orchestrations contains 'Matching.Username' orchestration",{
    # Given
    storage <- get.storage()

    # When
    orchestrations <- storage |> Authenticator.Orchestrator()

    # Then
    orchestrations[['Match.Username']] |> expect.exist()
  })
  it("then orchestrations contains 'Authenticate' orchestration",{
    # Given
    storage <- get.storage()

    # When
    orchestrations <- storage |> Authenticator.Orchestrator()

    # Then
    orchestrations[['Authenticate']] |> expect.exist()
  })
})

describe("When username |> orchestrate[['Find.User']]()",{
  it("then returns TRUE if user with matching username found in storage",{
    # Given
    storage <- get.storage()

    orchestrate <- storage |> Authenticator.Orchestrator()

    user <-  Users |> tail(1)

    # When
    result <- user[['username']] |> orchestrate[['Find.User']]()

    # Then
    result |> expect.equal(user)
  })
  it("then returns FALSE if no user with matching username found in storage",{
    # Given
    storage <- get.storage()

    orchestrate <- storage |> Authenticator.Orchestrator()

    user <- 'not.existing.user' |> User.Model()

    # When
    result <- user[['username']] |> orchestrate[['Find.User']]()

    # Then
    result |> expect.rows(0)
  })
})

describe("When user |> orchestrate[['Register']](password)",{
  it("then user hash is set and added to storage",{
    # Given
    storage <- get.storage()

    orchestrate <- storage |> Authenticator.Orchestrator()

    user     <- 'user.new@gmail.com' |> User.Model()
    password <- 'password'
    id       <- user[['id']]

    expected.user <- user
    expected.user[['hash']] <- user[['salt']] |> 
      paste(password) |> digest::digest(algo = 'sha512', serialize = FALSE)

    # When
    user |> orchestrate[['Register']](password)

    # Then
    actual.user <- id |> storage[['retrieve.where.id']]('User')
    actual.user |> expect.equal.data(expected.user)
  })
})

describe("When user |> orchestrate[['Match.Username']]()",{
  it("then returns TRUE if user with matching username found in storage",{
    # Given
    storage <- get.storage()

    orchestrate <- storage |> Authenticator.Orchestrator()

    user <-  'User' |> storage[['retrieve']]() |> tail(1)

    # When
    result <- user |> orchestrate[['Match.Username']]()

    # Then
    result |> expect.equal(TRUE)
  })
  it("then returns FALSE if no user with matching username found in storage",{
    # Given
    storage <- get.storage()

    orchestrate <- storage |> Authenticator.Orchestrator()

    user <- 'not.existing.user' |> User.Model()

    # When
    result <- user |> orchestrate[['Match.Username']]()

    # Then
    result |> expect.equal(FALSE)
  })
})

describe("When user |> orchestrate[['Authenticate']](password)",{
  it("then returns TRUE if user hash matches password",{
    # Given
    storage <- get.storage()

    orchestrate <- storage |> Authenticator.Orchestrator()

    user     <- 'user' |> User.Model()
    password <- 'password'

    user |> orchestrate[['Register']](password)

    # When
    result <- user |> orchestrate[['Authenticate']](password)

    # Then
    result |> expect.equal(TRUE)
  })
  it("then returns FALSE if user hash does not match password",{
        # Given
    storage <- get.storage()

    orchestrate <- storage |> Authenticator.Orchestrator()

    user     <- 'user' |> User.Model()
    password <- 'password'

    user |> orchestrate[['Register']](password)

    password <- 'wrong.password'

    # When
    result <- user |> orchestrate[['Authenticate']](password)

    # Then
    result |> expect.equal(FALSE)
  })
})