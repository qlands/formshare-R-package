my_connection = FormShare$new(
  server_url = "https://formshare.org",
  user_id = "cquiros",
  api_key = "325c7ae5-ea42-4541-9640-131a10d9395b",
  api_secret = "098f6bcd4621d373cade4e832627b4f6"
)
logged_in = my_connection$login()
expect_equal( object = logged_in, expected =FALSE)
