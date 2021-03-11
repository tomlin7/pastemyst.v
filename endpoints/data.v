module endpoints

import billyeatcookies.pastemyst

const data_language_endpoint_name           = "$pastemyst.main_endpoint/data/language"
const data_language_endpoint_extension      = "$pastemyst.main_endpoint/data/languageExt"


pub struct GetLanguageConfig {
	name      string
	extension string
}

pub fn get_language (config GetLanguageConfig) ?RawLanguage {
	if config.name != "" {
		mut request := pastemyst.http.new_request(.get, data_language_endpoint_name + "?name=" + config.name, "") ?
	} else if config.extension != "" {
		mut request := pastemyst.http.new_request(.get, data_language_endpoint_extension + "?extension=" + config.extension, "") ?
	}
	response := request.do() ?
	if response.status_code == pastemyst.http.Status.ok {
		return pastemyst.json.decode(RawLanguage, response.text)
	} else {
		return error("Error while fetching language details")
	}	
}
