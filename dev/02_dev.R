# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
## Amend DESCRIPTION with dependencies read from package code parsing
attachment::att_amend_desc()

usethis::use_dev_package("reactable")
usethis::use_package("shinythemes")
usethis::use_package("shinyjs")
usethis::use_package("rintrojs")
usethis::use_package("vroom")
usethis::use_package("htmltools")

## Add modules ----
## Create a module infrastructure in R/

### modules of expression query
golem::add_module(name = "query_exprs", with_test = TRUE)
golem::add_module(name = "query_exprs_select_studies", with_test = TRUE)
golem::add_module(name = "query_exprs_select_cohorts", with_test = TRUE)

### module of concentration query
golem::add_module(name = "query_con", with_test = T)
#### three sub server function in this tab (concentration query)
golem::add_fct("query_con_creatinine_server", with_test = TRUE)
golem::add_fct("query_con_abs_server", with_test = TRUE)
golem::add_fct("query_con_related_server", with_test = TRUE)

### modules of body weight query
golem::add_module(name = "query_weight_cohorts", with_test = T)
golem::add_module(name = "query_weight_idx", with_test = T)

### modules of displaying the results
golem::add_module(name = "display_table", with_test = T)

### modules of downloading the results
golem::add_module(name = "download", with_test = T)

## Add helper functions ----
## Creates fct_* and utils_*

## fct function, which is used in some topic.
golem::add_fct("display_sample", with_test = TRUE)
golem::add_fct("remove_sub", with_test = T)

## utils function, which is widely used in the whole app.
golem::add_utils("helpers", with_test = TRUE)
golem::add_utils("lp_main_box", with_test = T)

## External resources
## Creates .js and .css files at inst/app/www
# golem::add_js_file("script")
# golem::add_js_handler("handlers")
golem::add_css_file("style")
# golem::add_sass_file("custom")

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "my_dataset", open = FALSE)
usethis::use_data_raw(name = "my_dataset_1", open = FALSE)

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")

# Documentation

## Vignette ----
usethis::use_vignette("toyGolemModel")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
##
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action()
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release()
usethis::use_github_action_check_standard()
usethis::use_github_action_check_full()
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis()
usethis::use_travis_badge()

# AppVeyor
usethis::use_appveyor()
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")
