module endpoints

import net.http
import json

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

/**
 * Represents the endpoint for getting users.
 *
 * NOTE: https://paste.myst.rs/api-docs/user
 */

const user_endpoint = "$pastemyst.main_endpoint/user/"

/* user_exists
 * Checks if a user with the specified name exists.
 *
 * PARAM: username; The name to check.
 * RETURNS: bool; Whether the user exists.
 */
pub fn user_exists (username string) ?bool {
	mut request := http.new_request(.get, user_endpoint + username + "/exists", "") ?
	response := request.do() ?
	return response.status_code == int(http.Status.ok)
}

/* get_user
 * Retrieves a user by their name. Returns undefined if no user can be found.
 *
 * NOTE: Users with private profiles are hidden from the public API,
 * and will therefore also return none.
 *
 * PARAM: username The name to fetch.
 * RETURNS: types.RawUser; The fetched RawUser object or none if no user was found.
 */
pub fn get_user(username string) ?types.RawUser {
	mut request := http.new_request(.get, user_endpoint + username, "") ?
	response := request.do() ?
	if response.status_code == int(http.Status.ok) {
		return json.decode(types.RawUser, response.text)
	} else {
		return error("Error while fetching user with the name $username")
	}
}