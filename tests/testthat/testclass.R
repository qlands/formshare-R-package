my_connection = FormShare$new(
  server_url = "https://formshare.org",
  user_id = "",
  api_key = "",
  api_secret = ""
)
current_url = my_connection$get_server_url()
expect_equal( object = current_url, expected ="https://formshare.org")
