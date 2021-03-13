module endpoints

import json
import net.http

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

/**
 * Represents an endpoint for retrieving various kinds of simple data.
 *
 * NOTE: https://paste.myst.rs/api-docs/data
 */
const data_language_endpoint_name           = "$pastemyst.main_endpoint/data/language"
const data_language_endpoint_extension      = "$pastemyst.main_endpoint/data/languageExt"

pub struct GetLanguageConfig {
	name      string
	extension string
}

/**
 * Retrieves the language definition for a specified language.
 *
 * PARAM: The name or extension of the language to look up.
 * RETURNS: The language definition or none if no matching language was found.
 */
pub fn get_language (config GetLanguageConfig) ?types.RawLanguage {
	if config.name != "" {
		mut request := http.new_request(.get, data_language_endpoint_name + "?name=" + config.name, "") ?
		response := request.do() ?

		if response.status_code == int(http.Status.ok) {
			return json.decode(types.RawLanguage, response.text)
		} else {
			return error("Error while fetching language details")
		}
	} else if config.extension != "" {
		mut request := http.new_request(.get, data_language_endpoint_extension + "?extension=" + config.extension, "") ?
		response := request.do() ?

		if response.status_code == int(http.Status.ok) {
			return json.decode(types.RawLanguage, response.text)
		} else {
			return error("Error while fetching language details")
		}
	}
		
}
