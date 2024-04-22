# Existing
describe('Given Example',{
  it('exist',{
    # Given
    Example |> is.null() |> expect_equal(FALSE)
  })
})

# Availability
describe("When members <- Example()",{
  it("Then members is a list",{
    # Given
    members <- Example()

    # Then
    members |> is.list() |> expect_equal(TRUE)
  })
  it("Then members contains AddOne member",{
    # Given
    members <- Example()

    # Then
    members[['AddOne']] |> is.null() |> expect_equal(FALSE)
  })
})

# Functionality
describe("When input |> example[['AddOne']]()",{
  it("Then output is input + 1",{
    # Given
    example <- Example()
    input <- 10

    # When 
    output <- input |> example[['AddOne']]()

    # Then
    output |> expect_equal(11)
  })
})