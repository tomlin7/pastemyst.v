module endpoints

import json
import net.http

import billyeatcookies.pastemyst
import billyeatcookies.pastemyst.types

/**
 * Represents an endpoint for managing pastes.
 *
 * NOTE: https://paste.myst.rs/api-docs/paste
 */

const get_paste_endpoint    = "$pastemyst.main_endpoint/paste/"
const create_paste_endpoint = "$pastemyst.main_endpoint/paste"
const delete_paste_endpoint = "$pastemyst.main_endpoint/paste/"
const edit_paste_endpoint   = "$pastemyst.main_endpoint/paste/"

pub struct GetPasteConfig {
	id    string [required]
	token string
}

/**
 * Fetches a paste by its ID.
 *
 * NOTE: if you want to fetch a private paste, you need to authorize
 * the request by passing your personal API token as a parameter.
 *
 * PARAM: id; The ID of the paste to fetch.
 * PARAM: token; Personal API token used to authorize the request.
 * RETURNS: types.RawPaste; The fetched RawPaste object or none if no paste was found.
 */
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

/**
 * Creates a new paste using the specified fields.
 *
 * NOTE: If you want the paste to be tied to your account, or want it
 * to be private, or want to use tags you need to authorize the request
 * by passing your personal API token as a parameter.
 *
 * PARAM: paste; The types.Paste object to use to create the paste.
 * PARAM: token; Personal API token used to authorize the request.
 * RETURNS: types.RawPaste; The created RawPaste object or none if no paste was found.
 */
pub fn create_paste (config CreatePasteConfig) ?types.RawPaste {
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

/**
 * Deletes the paste with the specified ID.
 *
 * NOTE: You can only delete pastes tied to your account. To ensure this, you 
 * need to authorize the request by passing your personal API token as a parameter.
 *
 * Additionally,  note that this action is irreversible.
 *
 * PARAM: id; The ID of the paste to delete.
 * PARAM: token; Personal API token used to authorize the request.
 * RETURNS: bool; Whether the paste was successfully deleted.
 */
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

/**
 * Applies a set of changes to an existing paste.
 *
 * NOTE: You can only edit pastes tied to your own account. To ensure this,
 * you need to authorize the request by pasing your personal API token
 * as a parameter.
 *
 * Additionally, when modifying the pasties of a post, note that you need to provide
 * all of the original pasties, only making the changes you want. It is not possible
 * to update a single pasty without providing all of the original pasties.
 *
 * PARAM: id; The ID of the paste to edit.
 * PARAM: edit; The types.Edit object to modify in the paste.
 * PARAM: token; Personal API token used to authorize the request.
 * RETURNS: types.RawPaste; The modified RawPaste object or non if the paste was not 
 * found or something went wrong.
 */
pub fn edit_paste (config EditPasteConfig) ?types.RawPaste {
	mut request := http.new_request(.patch, edit_paste_endpoint + config.id, json.encode(config.edit)) ?
	request.add_header('Content-Type','application/json')

	if config.token != "" {
		request.add_header("Authorization", config.token)
	} else {
		return error("Token not provided, editing is an account only feature.")
	}
	response := request.do() ?
	return json.decode(types.RawPaste, response.text)
	// if response.status_code == int(http.Status.ok) {
	// 	return json.decode(types.RawPaste, response.text)
	// } else {
	// 	return error("Error occured while editing paste")
	// }
}
