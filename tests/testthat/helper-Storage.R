# Test Storage

get.storage <- \() {
  storage <- data.frame() |> Storage::Storage(type='memory')
  Users |> storage[['Seed.Table']]('User')
  return(storage) 
}