describe('Encryption.Service',{
  it('exist',{
    Encryption.Service |> expect.exist()
  })
})

describe("When services <- Encryption.Service()",{
  it("then services is a list",{
    # When
    services <- Encryption.Service()

    # Then
    services |> expect.list()
  })
  it("then services contains 'Hash.Password' service",{
    # When
    services <- Encryption.Service()

    # Then
    services[['Hash.Password']] |> expect.exist()
  })
})

describe("When password |> service[['Hash.Password']](salt)",{
  it("then a sha512 hash is created using the password and salt",{
    # Given
    service <- Encryption.Service()

    password <- 'password'
    salt     <- uuid::UUIDgenerate()

    expected.hash <- salt |> paste(password) |> digest::digest(algo = 'sha512', serialize = FALSE)

    # When
    actual.hash <- password |> service[['Hash.Password']](salt)

    # Then
    actual.hash |> expect.equal(expected.hash)
  })
})