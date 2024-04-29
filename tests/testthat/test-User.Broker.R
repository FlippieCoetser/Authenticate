describe('User.Broker',{
  it('Exist',{
    User.Broker |> expect.exist()
  })
})

describe("Given operations <- storage |> User.Broker()",{
  it("then operations is a list",{
    # Given
    storage <- get.storage()

    operations <- storage |> User.Broker()

    # Then
    operations |> expect.list()
  })
  it("then operations contains 'Insert' operation",{
    # Given
    storage <- get.storage()

    operations <- storage |> User.Broker()

    # Then
    operations[['Insert']] |> expect.exist()
  })
  it("then operations contains 'Select' operation",{
    # Given
    storage <- get.storage()

    operations <- storage |> User.Broker()

    # Then
    operations[['Select']] |> expect.exist()
  })
  it("then operations contains 'SelectWhereId' operation",{
    # Given
    storage <- get.storage()

    operations <- storage |> User.Broker()

    # Then
    operations[['SelectWhereId']] |> expect.exist()
  })
  it("then operations contains 'Update' operation",{
    # Given
    storage <- get.storage()

    operations <- storage |> User.Broker()

    # Then
    operations[['Update']] |> expect.exist()
  })
  it("then operations contains 'Delete' operation",{
    # Given
    storage <- get.storage()

    operations <- storage |> User.Broker()

    # Then
    operations[['Delete']] |> expect.exist()
  })
})

describe("When user |> operation[['Insert']]()",{
  it("then user is inserted into storage",{
    # Given
    storage   <- get.storage()
    operation <- storage |> User.Broker()

    new.user <- 'User.x@gmail.com' |> User.Model()

    expected.user <- new.user

    # When
    new.user |> operation[['Insert']]()

    # Then
    actual.user <- new.user[['id']] |> operation[['SelectWhereId']]()
    actual.user |> expect.equal.data(expected.user)
  })
})

describe("When operation[['Select']]()",{
  it("then all users from storage is returned",{
    # Given
    storage   <- get.storage()
    operation <- storage |> User.Broker()

    expected.users <- Users

    # When
    actual.users <- operation[['Select']]()

    # Then
    actual.users |> expect.equal.data(expected.users)
  })
})

describe("When id |> operation[['SelectWhereId']]()",{
  it("then user with matching id in storage is returned",{
    # Given
    storage   <- get.storage()
    operation <- storage |> User.Broker()

    expected.user <- Users |> tail(1)

    id <- expected.user[['id']]

    # When
    actual.user <- id |> operation[['SelectWhereId']]()

    # Then
    actual.user |> expect.equal(expected.user)
  })
})

describe("When user |> operation[['Update']]()",{
  it("then user with matching id is updated in storage",{
    # Given
    storage   <- get.storage()
    operation <- storage |> User.Broker()

    existing.user <- Users |> tail(1)

    updated.user <- existing.user
    updated.user[['salt']] <- uuid::UUIDgenerate()

    expected.user <- updated.user

    id <- updated.user[['id']]

    # When
    updated.user |> operation[['Update']]()

    # Then
    actual.user <- id |> operation[['SelectWhereId']]()
    actual.user |> expect.equal(updated.user)
  })
})

describe("When id |> operation[['Delete']]()",{
  it("then user with matching id is deleted from storage",{
    # Given
    storage   <- get.storage()
    operation <- storage |> User.Broker()

    existing.user <- Users |> tail(1)

    id <- existing.user[['id']]

    # When
    id |> operation[['Delete']]()

    # Then
    maybe.user <- id |> operation[['SelectWhereId']]()
    maybe.user |> expect.rows(0)
  })
})