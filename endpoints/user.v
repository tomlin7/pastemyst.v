module endpoints

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

const user_endpoint = "$main_endpoint/user/"


pub fn user_exists (username string) ?bool {
	mut request := http.new_request(.get, user_endpoint + username + "/exists") ?
	response := request.do() ?
	return response.status_code == http.Status.ok
}

pub fn get_user(username string) ?types.RawUser {
	mut request := http.new_request(.get, user_endpoint + username) ?
	response := request.do() ?
	if response.status_code == http.Status.ok {
		return json.decode(RawUser, response.text)
	} else {
		return error("Error while fetching user with the name $username")
	}
}