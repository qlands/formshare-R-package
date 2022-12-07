# FormShare Class
#
# This R6 class provide access to FormShare
# The FormShare class requires the following packages R packages:
#
#   R6
#   httr
#   jsonlite
# It also requires the following:
#   FormShare 2.22.0 (https://github.com/qlands/FormShare)
#   FormShare Analytics plugin (https://github.com/qlands/formshare_analytics_plugin)
#   FormShare Remote SQL plugin (https://github.com/qlands/formshare_sql_plugin)

library(R6)

#' An R6 Class Representing a connection to FormShare
#'
#' @description
#' The main FormShare class.
#'
#' @details
#' This class encapsulates all functions to execute analytics in FormShare.
FormShare <- R6Class("FormShare",
                     public = list(
                       #' @field user_id The user ID in FormShare.
                       user_id = NULL,

                       #' @field api_key The API key used to connect to FormShare.
                       api_key = NULL,

                       #' @field api_secret The API secret used to connect to FormShare
                       api_secret = NULL,

                       #' @field server_url The FormShare server to connect to
                       server_url = NULL,

                       #' @field logged_in Whether the used has a valid connection
                       logged_in = FALSE,

                       #' @field api_token Token to use in other functions
                       api_token = "",

                       #' @field token_url FormShare URL to retrieve a valid token
                       token_url = NULL,

                       #' @description
                       #' Create a new FormShare object.
                       #' @param server_url Server URL. By default https://formshare.org
                       #' @param user_id The user ID to use
                       #' @param api_key The API Key to use.
                       #' @param api_secret The API Secret to use.
                       #' @return A new `FormShare` object.
                       initialize = function(server_url = "https://formshare.org", user_id = "", api_key = "", api_secret="") {
                         library(httr)
                         library(jsonlite)
                         self$user_id = user_id
                         self$server_url <- server_url
                         self$api_key <- api_key
                         self$api_secret <- api_secret
                         self$token_url = paste(self$server_url,"/api/1/security/login",sep="")
                       },
                       #' @description
                       #' Get the current API key.
                       get_api_key = function() {
                         return(self$api_key)
                       },
                       #' @description
                       #' Sets the current API key.
                       #' @param new_key New API key
                       set_api_key = function(new_key) {
                         self$api_key <- new_key
                       },
                       #' @description
                       #' Get the current API secret
                       get_api_secret = function() {
                         return(self$api_secret)
                       },
                       #' @description
                       #' Sets the current API secret.
                       #' @param new_secret New API secret
                       set_api_secret = function(new_secret) {
                         self$api_secret <- new_secret
                       },
                       #' @description
                       #' Get the current server URL
                       get_server_url = function() {
                         return(self$server_url)
                       },
                       #' @description
                       #' Sets the current server URL.
                       #' @param new_url New server URL
                       set_server_url = function(new_url) {
                         self$server_url <- new_url
                       },
                       #' @description
                       #' Log-in to the FormShare server and stores a API token
                       #' @return True of False if the connection was successful.
                       login = function() {
                         if (self$api_key == "")
                         {
                           stop("You need to indicate an API key")
                         }
                         else
                         {
                           if (self$api_secret == "")
                           {
                             stop("You need to indicate an API secret")
                           }
                           else
                           {
                             body <- list("X-API-Key"=self$api_key, "X-API-Secret"=self$api_secret)
                             resp <- POST(self$token_url, body = body, encode = "form")
                             status <- status_code(resp)
                             if (status == 200)
                             {
                               jsonRespText<-content(resp,as="text", encoding = "UTF-8")
                               token_data <- fromJSON(jsonRespText)
                               self$api_token = token_data$result$token
                               self$logged_in = TRUE
                               return(TRUE)
                             }
                             else
                             {
                               private$print_error(status)
                               return(FALSE)
                             }
                           }
                         }
                       },
                       #' @description
                       #' Return the repositories that the user has access to.
                       #' @return A data frame with repositories that the user has access to.
                       get_repositories = function() {
                         if (self$logged_in)
                         {
                           database_url = paste(self$server_url,"/user/",self$user_id,"/analytics/tools/remote_sql/databases",sep="")
                           resp <- GET(database_url, add_headers(Authorization = paste("Bearer", self$api_token, sep = " ")))
                           status <- status_code(resp)
                           if (status == 200)
                           {
                             jsonRespText<-content(resp,as="text", encoding = "UTF-8")
                             repositories <- fromJSON(jsonRespText)
                             return (repositories$result$databases)
                           }
                           else
                           {
                             private$print_error(status)
                             return(FALSE)
                           }
                         }
                         else
                         {
                           print("You are not logged in")
                         }
                       },
                       #' @description
                       #' Get the tables in a repository.
                       #' @param repository The repository to use
                       #' @return A data frame with tables inside a repository.
                       get_tables = function(repository) {
                         if (self$logged_in)
                         {
                           tables_url = paste(self$server_url,"/user/",self$user_id,"/analytics/tools/remote_sql/tables",sep="")
                           body <- list("schema"=repository)
                           resp <- POST(tables_url, body = body, encode = "json", add_headers(Authorization = paste("Bearer", self$api_token, sep = " ")))
                           status <- status_code(resp)
                           if (status == 200)
                           {
                             jsonRespText<-content(resp,as="text", encoding = "UTF-8")
                             tables <- fromJSON(jsonRespText)
                             return (tables$result$tables)
                           }
                           else
                           {
                             private$print_error(status)
                             return(FALSE)
                           }
                         }
                         else
                         {
                           print("You are not logged in")
                         }
                       },
                       #' @description
                       #' Get the fields in a table of a repository.
                       #' @param repository The repository to use
                       #' @param table The table to use
                       #' @return A data frame with fields inside a table.
                       get_fields = function(repository, table) {
                         if (self$logged_in)
                         {
                           fields_url = paste(self$server_url,"/user/",self$user_id,"/analytics/tools/remote_sql/fields",sep="")
                           body <- list("schema"=repository, "table"=table)
                           resp <- POST(fields_url, body = body, encode = "json", add_headers(Authorization = paste("Bearer", self$api_token, sep = " ")))
                           status <- status_code(resp)
                           if (status == 200)
                           {
                             jsonRespText<-content(resp,as="text", encoding = "UTF-8")
                             fields <- fromJSON(jsonRespText)
                             return (fields$result$fields)
                           }
                           else
                           {
                             private$print_error(status)
                             return(FALSE)
                           }
                         }
                         else
                         {
                           print("You are not logged in")
                         }
                       },
                       #' @description
                       #' Executes an SQL and returns it result.
                       #' @param repository The repository to use
                       #' @param sql SQL to execute
                       #' @return A data frame with the result of the execution.
                       execute = function(repository, sql) {
                         if (self$logged_in)
                         {
                           temp_dir = tempdir()
                           temp_file = tempfile(fileext = ".zip")
                           json_file = paste(temp_dir, "/output.json", sep = "")
                           execute_url = paste(self$server_url,"/user/",self$user_id,"/analytics/tools/remote_sql/execute",sep="")
                           body <- list("schema"=repository, "sql"=sql)
                           resp <- POST(execute_url, body = body, encode = "json", add_headers(Authorization = paste("Bearer", self$api_token, sep = " ")), write_disk(temp_file, overwrite=TRUE))
                           status <- status_code(resp)
                           if (status == 200)
                           {
                             unzip(temp_file,exdir=temp_dir)
                             size = file.info(json_file)$size
                             if (size > 0)
                             {
                               return (fromJSON(json_file))
                             }
                             else
                             {
                               return (TRUE)
                             }
                           }
                           else
                           {
                             private$print_error(status)
                             return(FALSE)
                           }
                         }
                         else
                         {
                           print("You are not logged in")
                         }
                       },
                       #' @description
                       #' A convenient function to return the contents of a table.
                       #' @param repository The repository to use
                       #' @param table Table to retrieve
                       #' @return A data frame with data of the table
                       get_table = function(repository, table) {
                         if (self$logged_in)
                         {
                           sql = paste("SELECT * FROM ", table, sep = "")
                           return (self$execute(repository, sql))
                         }
                       }
                     ),
                     private = list(
                       #' @description
                       #' Internal function. Print a message based on a status
                       print_error = function(status) {
                         if (status == 401)
                         {
                           print("Unauthorized")
                           return(FALSE)
                         }
                         if (status == 404)
                         {
                           print("URL not found")
                           return(FALSE)
                         }
                         if (status == 500)
                         {
                           print("HTTP call returned an error")
                           return(FALSE)
                         }
                         print("Unknown error")
                       }
                     )
)
