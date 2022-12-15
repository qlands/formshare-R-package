A simple connection between FormShare and R for advanced analytics.
==================================================

## Description

[FormShare](https://formshare.org) is an advanced data management platform for [Open Data Kit (ODK)](https://getodk.org/) . This R Package provides a simple connection object between FormShare and R for advanced analytics.

## Requirements

- [FormShare](https://github.com/qlands/FormShare) >= 2.22.0
- [FormShare Analytics Plug-in](https://github.com/qlands/formshare_analytics_plugin)
- [FormShare Remote SQL Plug-in](https://github.com/qlands/formshare_sql_plugin)

## Details

This class encapsulates all functions to execute analytics in FormShare directly from R.

### Public fields

**user_id**

The user ID in FormShare.

**api_key**

The API key used to connect to FormShare.

**api_secret**

The API secret used to connect to FormShare

**server_url**

The FormShare server to connect to

**logged_in**

Whether the used has a valid connection

**api_token**

Token to use in other functions

**token_url**

FormShare URL to retrieve a valid token

### Methods

#### Public methods

*   [FormShare$new()](#method-new)
    
*   [FormShare$get_api_key()](#method-get_api_key)
    
*   [FormShare$set_api_key()](#method-set_api_key)
    
*   [FormShare$get_api_secret()](#method-get_api_secret)
    
*   [FormShare$set_api_secret()](#method-set_api_secret)
    
*   [FormShare$get_server_url()](#method-get_server_url)
    
*   [FormShare$set_server_url()](#method-set_server_url)
    
*   [FormShare$login()](#method-login)
    
*   [FormShare$get_repositories()](#method-get_repositories)
    
*   [FormShare$get_tables()](#method-get_tables)
    
*   [FormShare$get_fields()](#method-get_fields)
    
*   [FormShare$execute()](#method-execute)
    
*   [FormShare$get_table()](#method-get_table)
    
*   [FormShare$clone()](#method-clone)
    

* * *

#### Method new

Create a new FormShare object.

##### Usage

```R
my_connection = FormShare$new(
  server_url = "https://formshare.org",
  user_id = "your_user",
  api_key = "your_api_key",
  api_secret = "your_api_secret"
)
```

##### Arguments

**server_url**

Server URL. By default https://formshare.org

**user_id**

The user ID to use

**api_key**

The API Key to use.

**api_secret**

The API Secret to use.

##### Returns

A connection object to FormShare.

* * *

#### Method get_api_key

Get the current API key.

##### Usage

```R
current_api_key = my_connection$get_api_key()
```

* * *

#### Method set_api_key

Sets the current API key.

##### Usage

```R
my_connection$set_api_key("new_api_key")
```

##### Arguments

**new_key**

New API key

* * *

#### Method get_api_secret

Get the current API secret

##### Usage

```R
current_api_secret = my_connection$get_api_secret()
```

* * *

#### Method set_api_secret

Sets the current API secret.

##### Usage

```R
my_connection$set_api_secret("new_api_secret")
```

##### Arguments

**new_secret**

New API secret

* * *

#### Method get_server_url

Get the current server URL

##### Usage

```R
current_url = my_connection$get_server_url()
```

* * *

#### Method set_server_url

Sets the current server URL.

##### Usage

```R
my_connection$set_server_url("new_url")
```

##### Arguments

**new_url**

New server URL

* * *

#### Method login

Log-in to the FormShare server and stores a API token

##### Usage

```R
my_connection$login()
```

##### Returns

True of False if the connection was successful.

* * *

#### Method get_repositories

Return the repositories that the user has access to.

##### Usage

```R
my_repositories = my_connection$get_repositories()
```

##### Returns

A data frame with repositories that the user has access to.

* * *

#### Method get_tables

Get the tables in a repository.

##### Usage

```R
my_tables = my_connection$get_tables("repository_id")
```

##### Arguments

**repository**

The repository to use

##### Returns

A data frame with tables inside a repository.

* * *

#### Method get_fields

Get the fields in a table of a repository.

##### Usage

```R
my_fields = my_connection$get_fields("repository_id", "table_name")
```

##### Arguments

**repository**

The repository ID to use

**table**

The table to use

##### Returns

A data frame with fields inside a table.

* * *

#### Method execute

Executes an SQL and returns it result.

##### Usage

```R
data = my_connection$execute("repository_id", "SELECT * FROM maintable")
```

##### Arguments

**repository**

The repository to use

**sql**

SQL to execute

##### Returns

A data frame with the result of the execution. Return TRUE if the result is empty or if the execution does not return any data. For example when executing a "CREATE VIEW"

* * *

#### Method get_table

A convenient function to return the contents of a table.

##### Usage

```R
data = my_connection$get_table("repository_id", "maintable")
```

##### Arguments

**repository**

The repository to use

**table**

Table to retrieve

##### Returns

A data frame with data of the table

* * *

#### Method clone

The objects of this class are cloneable with this method.

##### Usage

```R
clone = my_connection$clone(deep = FALSE)
```

##### Arguments

**deep**

Whether to make a deep clone.

## License

[GPL V 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html)

## Author

[Carlos Quiros](https://orcid.org/0000-0002-9485-9961)
