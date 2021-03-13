module endpoints

import json
import net.http

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

const time_endpoint_expires_in_to_unix_time = "$pastemyst.main_endpoint/time/expiresInToUnixTime"

pub struct ExpiresInToUnixTimeStampConfig {
	created_at int
	expires_in types.ExpiresIn
}

pub fn expires_in_to_unix_timestamp (config ExpiresInToUnixTimeStampConfig) ?int {
	if config.created_at == 0 {
		return error("Invalid arguments passed or arguments passed are not enough")
	} else {
		mut request := http.new_request(.get, time_endpoint_expires_in_to_unix_time + "?createdAt=" + config.created_at.str() + "&expiresIn=" + config.expires_in.str() ,"") ?
		response := request.do() ?

		if response.status_code == int(http.Status.ok) {
			mut expiry := json.decode(types.RawTime, response.text) ?
			return expiry.result
		} else {
			return error("Error while converting passed arguments to unix timestamp")
		}
	}
}