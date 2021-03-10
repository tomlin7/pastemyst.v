module pastemyst

const time_endpoint_expires_in_to_unix_time = "$main_endpoint/time/expiresInToUnixTime"


pub struct ExpiresInToUnixTimeStampConfig {
	created_at int
	expires_in ExpiresIn
}

pub fn expires_in_to_unix_timestamp (config ExpiresInToUnixTimeStampConfig) ?int {
	if (config.created_at == 0) {
		return error("Invalid arguments passed or arguments passed are not enough")
	} else {
		mut request := http.new_request(.get, time_endpoint_expires_in_to_unix_time + "?createdAt=" + config.created_at + "&expiresIn=" + config.expires_in.str()) ?
		response := request.do()

		if response.status_code == http.Status.ok {
			return request.text
		} else {
			return error("Error while converting passed arguments to unix timestamp")
		}
	}
}