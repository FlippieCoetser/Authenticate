describe('Encryption.Processor',{
  it('exist',{
    Encryption.Processor |> expect.exist()
  })
})

describe("When processors <- service |> Encryption.Processor()",{
  it("then processors is a list",{
    # Given
    service <- Encryption.Service()

    # When
    processors <- service |> Encryption.Processor()

    # Then
    processors |> expect.list()
  })
  it("then processors contains 'Set.Hash' processor",{
    # Given
    service <- Encryption.Service()

    # When
    processors <- service |> Encryption.Processor()

    # Then
    processors[['Set.Hash']] |> expect.exist()
  })
})

describe("When user |> process[['Set.Hash']](password)",{
  it("then user[['hash']] is set using user[['salt']] and password",{
    # Given
    service <- Encryption.Service()

    process <- service |> Encryption.Processor()

    user     <- 'user' |> User()
    password <- 'password'

    expected.hash <- 
      user[['salt']]  |> 
      paste(password) |> 
      digest::digest(algo='sha512', serialize=FALSE)

    # When
    actual.user <- user |> process[['Set.Hash']](password)

    # Then
    actual.user[['hash']] |> expect.equal(expected.hash)
  })
})