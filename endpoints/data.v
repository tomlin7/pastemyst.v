module endpoints

const data_language_endpoint_name           = "$main_endpoint/data/language"
const data_language_endpoint_extension      = "$main_endpoint/data/languageExt"


pub struct GetLanguageConfig {
	name      string
	extension string
}

pub fn get_language (config GetLanguageConfig) ?RawLanguage {
	if config.name != "" {
		mut request := http.new_request(.get, data_language_endpoint_name + "?name=" + config.name, "") ?
	} else if config.extension != "" {
		mut request := http.new_request(.get, data_language_endpoint_extension + "?extension=" + config.extension, "") ?
	}
	response := request.do() ?
	if response.status_code == http.Status.ok {
		return json.decode(RawLanguage, response.text)
	} else {
		return error("Error while fetching language details")
	}	
}
