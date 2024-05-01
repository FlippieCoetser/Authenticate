# Test Storage

get.storage <- \() {
  storage <- data.frame() |> Storage::Storage(type='memory')
  Users |> storage[['seed.table']]('User')
  return(storage) 
}