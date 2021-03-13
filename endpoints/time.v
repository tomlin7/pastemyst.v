module endpoints

import json
import net.http

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

/**
 * Represents an endpoint for useful, PasteMyst-related time operations.
 *
 * NOTE: https://paste.myst.rs/api-docs/time
 */

const time_endpoint_expires_in_to_unix_time = "$pastemyst.main_endpoint/time/expiresInToUnixTime"

pub struct ExpiresInToUnixTimeStampConfig {
	created_at int
	expires_in types.ExpiresIn
}

/**
 * Converts an `expires_in` value to a specified paste expiry time.
 *
 * PARAM: created_at; The unix timestamp of a creation date.
 * PARAM: expires_in; The expiry of a hypothetical paste.
 *
 * RETURNS: int; The unix timestamp of the expiry. (types.RawTime.result)
 */
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