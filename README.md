An R6 Class Representing a connection to FormShare
--------------------------------------------------

### Description

This class provides access to FormShare to perform analytics and data queries directly on data repositories.

### Requirements

- [R6](https://cran.r-project.org/web/packages/R6/index.html)
- [FormShare >= 2.22.0](ttps://github.com/qlands/FormShare)
- [FormShare Analytics plug-in](https://github.com/qlands/formshare_analytics_plugin)
- [FormShare SQL plug-in](https://github.com/qlands/formshare_sql_plugin)

### Details

This class encapsulates all functions to execute analytics in FormShare.

### Public fields

`user_id`

The user ID in FormShare.

`api_key`

The API key used to connect to FormShare.

`api_secret`

The API secret used to connect to FormShare

`server_url`

The FormShare server to connect to

`logged_in`

Whether the used has a valid connection

`api_token`

Token to use in other functions

`token_url`

FormShare URL to retrieve a valid token

### Methods

#### Public methods

*   [`FormShare$new()`](#method-FormShare-new)

*   [`FormShare$get_api_key()`](#method-FormShare-get_api_key)

*   [`FormShare$set_api_key()`](#method-FormShare-set_api_key)

*   [`FormShare$get_api_secret()`](#method-FormShare-get_api_secret)

*   [`FormShare$set_api_secret()`](#method-FormShare-set_api_secret)

*   [`FormShare$get_server_url()`](#method-FormShare-get_server_url)

*   [`FormShare$set_server_url()`](#method-FormShare-set_server_url)

*   [`FormShare$login()`](#method-FormShare-login)

*   [`FormShare$get_repositories()`](#method-FormShare-get_repositories)

*   [`FormShare$get_tables()`](#method-FormShare-get_tables)

*   [`FormShare$get_fields()`](#method-FormShare-get_fields)

*   [`FormShare$execute()`](#method-FormShare-execute)

*   [`FormShare$get_table()`](#method-FormShare-get_table)

*   [`FormShare$clone()`](#method-FormShare-clone)


* * *

#### Method `new()`

Create a new FormShare object.

##### Usage

```R
my_connection = FormShare$new(
  server_url = "https://formshare.org",
  user_id = "",
  api_key = "",
  api_secret = ""
)
```

##### Arguments

`server_url`

Server URL. By default https://formshare.org

`user_id`

The user ID to use

`api_key`

The API Key to use.

`api_secret`

The API Secret to use.

##### Returns

A new `FormShare` object.

* * *

#### Method `get_api_key()`

Get the current API key.

##### Usage

```R
current_api = my_connection$get_api_key()
```

* * *

#### Method `set_api_key()`

Sets the current API key.

##### Usage

```R
my_connection$set_api_key(new_key)
```

##### Arguments

`new_key`

New API key

* * *

#### Method `get_api_secret()`

Get the current API secret

##### Usage

```R
current_secret = my_connection$get_api_secret()
```

* * *

#### Method `set_api_secret()`

Sets the current API secret.

##### Usage

```R
my_connection$set_api_secret(new_secret)
```

##### Arguments

`new_secret`

New API secret

* * *

#### Method `get_server_url()`

Get the current server URL

##### Usage

```R
current_server = my_connection$get_server_url()
```

* * *

#### Method `set_server_url()`

Sets the current server URL.

##### Usage

```R
my_connection$set_server_url(new_url)
```

##### Arguments

`new_url`

New server URL

* * *

#### Method `login()`

Log-in to the FormShare server and stores a API token

##### Usage

```R
my_connection$login()
```

##### Returns

True of False if the connection was successful.

* * *

#### Method `get_repositories()`

Return the repositories that the user has access to.

##### Usage

```R
my_connection$get_repositories()
```

##### Returns

A data frame with repositories that the user has access to.

* * *

#### Method `get_tables()`

Get the tables in a repository.

##### Usage

```R
tables = my_connection$get_tables(repository)
```

##### Arguments

`repository`

The repository to use

##### Returns

A data frame with tables inside a repository.

* * *

#### Method `get_fields()`

Get the fields in a table of a repository.

##### Usage

```R
fields = my_connection$get_fields(repository, table)
```

##### Arguments

`repository`

The repository to use

`table`

The table to use

##### Returns

A data frame with fields inside a table.

* * *

#### Method `execute()`

Executes an SQL and returns it result.

##### Usage

```R
result = my_connection$execute(repository, sql)
```

##### Arguments

`repository`

The repository to use

`sql`

SQL to execute

##### Returns

A data frame with the result of the execution.

* * *

#### Method `get_table()`

A convenient function to return the contents of a table.

##### Usage

```R
data = my_connection$get_table(repository, table)
```

##### Arguments

`repository`

The repository to use

`table`

Table to retrieve

##### Returns

A data frame with data of the table

* * *

#### Method `clone()`

The objects of this class are cloneable with this method.

##### Usage

```R
clone = my_connection$clone(deep = FALSE)
```

##### Arguments

`deep`

Whether to make a deep clone.
