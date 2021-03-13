module tests

import os

import billyeatcookies.pastemyst.endpoints
import billyeatcookies.pastemyst.types

const username = os.getenv("API_USERNAME")

fn testsuite_begin () {
	println("No API username was set, related tests will be skipped.")
}

fn test_user_exists () ? {
	assert endpoints.user_exists(username) ? == true
}

fn test_get_user () ? {
	mut result := endpoints.get_user(username) ?
	assert result.username == username
}