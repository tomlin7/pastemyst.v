module pastemyst

const get_paste_endpoint    = "$main_endpoint/paste/"
const create_paste_endpoint = "$main_endpoint/paste"
const delete_paste_endpoint = "$main_endpoint/paste/"
const edit_paste_endpoint   = "$main_endpoint/paste/"


pub struct GetPasteConfig {
	id    string [required]
	token string
}

pub fn get_paste (config GetPasteConfig) ?RawPaste {
	mut request := http.new_request(.get, get_paste_endpoint + config.id, "") ?
	if config.token != "" {
		request.add_header("Authorization", config.token)
	}
	response := request.do() ?
	if response.status_code != http.Status.not_found {
		return json.decode(RawPaste, response.text)
	} else {
		println("Paste not found, check the id and token given")
		return none
	}
}

pub struct CreatePasteConfig {
	paste Paste  [required]
	token string
}

pub fn create_paste (config CreatePasteConfig) ?RawPaste {
	mut request := http.new_request(.post, create_paste_endpoint, json.encode(config.paste)) ?
	request.add_header('Content-Type','application/json')
	
	if config.token == "" && (config.paste.is_private || config.paste.is_public || config.paste.tags != "") {
		return error("Using account only features, but the token isn't provided.")
	}
	if config.token != "" {
		request.add_header("Authorization", config.token)
	}
	response := request.do() ? 
	return json.decode(RawPaste, response.text)
}

pub struct DeletePasteConfig {
	id string    [required]
	token string [required]
}

pub fn delete_paste (config DeletePasteConfig) ?bool {
	mut request := http.new_request(.delete, delete_paste_endpoint + config.id, "") ?
	if config.token != "" {
		request.add_header("Authorization", config.token)
	} else {
		return error("Token not provided, deletion is an account only feature.")
	}
	response := request.do() ?
	return response.status_code == http.Status.ok
}

pub struct EditPasteConfig {
	id    string [required]
	edit  Edit   [required]
	token string [required]
}

pub fn edit_paste (config EditPasteConfig) ?RawEdit {
	mut request := http.new_request(.patch, edit_paste_endpoint + config.id, json.encode(edit)) ?
	if config.token != "" {
		request.add_header("Authorization", config.token)
	} else {
		return error("Token not provided, editing is an account only feature.")
	}
	response := request.do() ?
	return json.decode(RawEdit, response.text)
}
