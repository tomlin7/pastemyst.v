module endpoints

import net.http
import json

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

const user_endpoint = "$pastemyst.main_endpoint/user/"


pub fn user_exists (username string) ?bool {
	mut request := http.new_request(.get, user_endpoint + username + "/exists", "") ?
	response := request.do() ?
	return response.status_code == int(http.Status.ok)
}

type GetUserReturnType = types.RawUser | bool

pub fn get_user(username string) ?GetUserReturnType {
	mut request := http.new_request(.get, user_endpoint + username, "") ?
	response := request.do() ?
	if response.status_code == int(http.Status.ok) {
		return json.decode(types.RawUser, response.text)
	} else {
		println("Error while fetching user with the name $username")
		return false
	}
}