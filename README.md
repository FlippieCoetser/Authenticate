# R Package Template

This repository can be used as a boilerplate when creating a new R package. It contains a basic package structure and a few valuable files to get started.

Unique feature included in this template:

1. A basic unit testing framework using `testthat`.
2. A basic documentation framework using `roxygen2`.
3. Github Actions for CI/CD.

## Using Template

To use this template to create your own R-Package, follow these steps:  

1. R `devtools` is required when developing R packages. Install and Reboot:

```r
install.packages("devtools")
```

2. Install the unit testing framework `testthat`:

```r
install.packages("testthat")
```

3. Create new Repository: click the `Use this template` button to create a new repository.  

4. Clone Repository

```bash
git clone <Repo URL>
```

5. Update `README.md`
6. Update `DESCRIPTION`
7. Update `tests/testthat/testthat.R`: change the reference in `library()` and `test_check()` with your package name.
8. Update documentation using `devtools` in r terminal

```r
devtools::document()
```

7. Check the Package using `devtools` in r terminal

```r
devtools::check()
```

## Template Architecture

### Folder Structure

By design, R packages leverage a specific folder structure. This structure is used by `devtools` to document, check and build packages.
Here is an overview of the different files and folders that comprise the package structure.

Files:

- `DESCRIPTION`: Contains the package metadata. This file defines the package name, version, dependencies and other metadata.
- `NAMESPACE`: Contains the package namespace. This file is used to define the package exports and imports.
- `LICENSE`: Contains the package license. This file is used to define the package license.
- `README.md`: Contains the package readme. This file is used to provide a high-level overview of the package.

Folders:

- `man`: Contains the documentation files. These files are generated by `devtools` and should not be edited manually.
- `R`: Contains the R source code files. These files define the functions and data structures that make up the package.
- `tests`: Contains the unit tests. These files test the functions and data structures that make up the package.
- `vignettes`: Contains the vignettes. These files are used to provide additional documentation and examples.

Most of your time developing R packages will be spent in the R and Tests folders. Files in `man` and `vignettes` are generated by `devtools` and should not be edited manually. Also, the contents in the `NAMESPACE` file should not be edited manually.