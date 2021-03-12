module tests

import os
import venv

import billyeatcookies.pastemyst.endpoints
import billyeatcookies.pastemyst.types

venv.load_env(overwrite: false)
const username = os.getenv('API_USERNAME')

fn testsuite_begin () {
	
	println("#############" + username + "#############")
	println("No API username was set, related tests will be skipped.")
}

fn test_user_exists () ? {
	assert endpoints.user_exists(username) ? == true
}

fn test_get_user () ? {
	mut result := endpoints.get_user(username) ?
	assert result is types.RawUser
	if mut result is types.RawUser {
		assert result.username == username
	}
}