module endpoints

import json
import net.http

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

const get_paste_endpoint    = "$pastemyst.main_endpoint/paste/"
const create_paste_endpoint = "$pastemyst.main_endpoint/paste"
const delete_paste_endpoint = "$pastemyst.main_endpoint/paste/"
const edit_paste_endpoint   = "$pastemyst.main_endpoint/paste/"

pub struct GetPasteConfig {
	id    string [required]
	token string
}

pub fn get_paste (config GetPasteConfig) ?types.RawPaste {
	mut request := http.new_request(.get, get_paste_endpoint + config.id, "") ?
	request.add_header('Content-Type','application/json')
	
	if config.token != "" {
		request.add_header("Authorization", config.token)
	}
	response := request.do() ?
	if response.status_code == int(http.Status.ok) {
		return json.decode(types.RawPaste, response.text)
	} else {
		return error("Paste not found, check the id and token given")
	}
}

pub struct CreatePasteConfig {
	paste types.Paste  [required]
	token string
}

pub fn create_paste (config CreatePasteConfig) ?types.RawPast {
	mut request := http.new_request(.post, create_paste_endpoint, json.encode(config.paste)) ?
	request.add_header('Content-Type','application/json')
	
	if config.token == "" && (config.paste.is_private || config.paste.is_public || config.paste.tags != "") {
		return error("Using account only features, but the token isn't provided.")
	}
	if config.token != "" {
		request.add_header("Authorization", config.token)
	}
	response := request.do() ? 
	if response.status_code == int(http.Status.ok) {
		return json.decode(types.RawPaste, response.text)
	} else {
		return error("Error occured while creating paste")
	}
}

pub struct DeletePasteConfig {
	id string    [required]
	token string [required]
}

pub fn delete_paste (config DeletePasteConfig) ?bool {
	mut request := http.new_request(.delete, delete_paste_endpoint + config.id, "") ?
	request.add_header('Content-Type','application/json')

	if config.token != "" {
		request.add_header("Authorization", config.token)
	} else {
		return error("Token not provided, deletion is an account only feature.")
	}
	response := request.do() ?
	if response.status_code != int(http.Status.ok) {
		println("Error occured while deleting paste $config.id")
	}
	return response.status_code == int(http.Status.ok)
}


pub struct EditPasteConfig {
	id    string [required]
	edit  types.Edit [required]
	token string [required]
}

pub fn edit_paste (config EditPasteConfig) ?types.RawPaste {
	mut request := http.new_request(.patch, edit_paste_endpoint + config.id, json.encode(config.edit)) ?
	request.add_header('Content-Type','application/json')

	if config.token != "" {
		request.add_header("Authorization", config.token)
	} else {
		return error("Token not provided, editing is an account only feature.")
	}
	response := request.do() ?
	if response.status_code == int(http.Status.ok) {
		return json.decode(types.RawPaste, response.text)
	} else {
		return error("Error occured while editing paste")
	}
}
