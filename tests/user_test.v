module tests

import os

import billyeatcookies.pastemyst.endpoints

/**
 * Username used to fetch user object, value is taken from enviromental variables.
 * can be provided manually here.
 */
const username = os.getenv("API_USERNAME")

fn testsuite_begin () {
	println("No API username was set, related tests will be skipped.")
}

/**
 * checks if a user exists.
 */
fn test_user_exists () ? {
	assert endpoints.user_exists(username) ? == true
}

/**
 * gets a user profile.
 */
fn test_get_user () ? {
	mut result := endpoints.get_user(username) ?
	assert result.username == username
}