# Authenticate R Package

This repository contains a plugin for R Shiny that allows users to authenticate using a username and password. The plugin provides both login and registration capabilities.

Note: This package depends on R `Storage` package. Currently, the storage package provides both `odbc` and `in-memory` type data stores.

## Installation

At the time of writing this README, the package is not available on CRAN. To install the package, you can use the `devtools` package to either install the package directly from GitHub or Build and Install it locally.

### Install from GitHub

1. Use the `devtools` package to install the package directly from Github:

```r
devtools::install_github("https://github.com/FlippieCoetser/Authenticate")
```

### Build and Install Locally

1. Clone the repository:

```bash
git clone https://github.com/FlippieCoetser/Authenticate
```

2. Generate `.tar.gz` file:

```r
devtools::build()
```

3. Install the package:

```r
install.packages("path/to/Authenticate_0.1.0.tar.gz", repos = NULL, type = "source")
```

## Usage

There are two ways to load the plugin: using the `library` function or using the `Authenticate` namespace.

### Load the package using `library` function:

Use the `library` function to load the `View`, `Controller` and `Orchestrator` directly into the R environment.

```r
library(Authenticate)
```

### Directly Access the component using the `Authenticate` namespace:

Directly address the `View`, `Controller` and `Orchestrator` using the `Authenticate` namespace.

```r
View         <- Authenticate::View
Controller   <- Authenticate::Controller
Orchestrator <- Authenticate::Orchestrator
```

### Seed the storage

You need to seed the storage with some data if you are using the `in-memory` storage type.

1. Create a new `storage` instance:

```r
configuration <- data.frame()
storage <- configuration |> Storage::Storage(type = "memory")
```

2. Seed the storage with some data:
   This package also includes test data that can be used to seed the storage. The `Seed.Table` function takes a single argument: the name of the table to seed.

```r
Authenticate::Users |> storage[['Seed.Table']]('User')
```

### Add the View to the UI

Add the `View` to the UI. See the `ui.r` file for an example. The `View` function takes a single argument: the id of the shiny module.

```r
Authenticate::View("user")
```

### Add the Controller to the Server

Add the `Controller` to the Server. See the `server.r` file for an example. The `Controller` function has four arguments:

1. The id of the shiny module.
2. The storage instance.
3. Optional `user` reactive value to store the current user details.
4. Optional `title` values to set the title of the login and registration modals.
5. Optional `debug` flag that enables event logging in the console.

```r
Authenticate::Controller("user", storage, title = "Login", debug = TRUE)
```

#### Add optional user reactive values

```r
user <- reactiveVal()
Authenticate::Controller("user", storage, user = user, title = "Login", debug = TRUE)

observeEvent(user[['username']], {
  print(user[['username']])
})
```

> Note: After successful login, `session[['userData']][['username']]` will also contains currently logged-in user's username.
