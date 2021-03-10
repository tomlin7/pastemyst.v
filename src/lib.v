module pastemyst

import json
import net.http

const get_paste_endpoint = "https://paste.myst.rs/api/v2/paste/"
const create_paste_endpoint = "https://paste.myst.rs/api/v2/paste"
const delete_paste_endpoint = "https://paste.myst.rs/api/v2/paste/"

/*
 Pasty object
 */
struct RawPasty {
	id       string [json: _id      ]
	language string [json: language ]
	title    string [json: title    ]
	code     string [json: code     ]
}

/*
Edit object
*/
struct RawEdit {
	id        string   [json: _id      ]
	edit_id   string   [json: editId   ]
	edit_type int      [json: editType ]
	metadata  []string [json: metadata ]
	edit      string   [json: edit     ]
	edited_at int      [json: editedAt ]
}


/*
Paste object
*/
struct RawPaste {
	id         string     [json: _id      ]
	owner_id   string     [json: ownerId  ]
	title      string     [json: title    ]
	created_at u64        [json: createdAt]
	expires_in string     [json: expiresIn]
	deletes_at u64        [json: deletesAt]
	stars      u64        [json: stars    ]
	is_private bool       [json: isPrivate]
	is_public  bool       [json: isPublic ]
	tags       []string   [json: tags     ]
	pasties    []RawPasty [json: pasties  ]
	edits      []RawEdit  [json: edits    ]
}

pub struct Pasty {
	language string [json: language] = "autodetect" 
	title    string [json: title]    = "(untitled)"
	code     string [json: code]
}

pub struct Edit {
	title      string  [json: title]
	is_private bool    [json: isPrivate]
	is_public  bool    [json: isPublic]
	tags       string  [json: tags]
	pasties    []Pasty [json: pasties]
}

pub struct Paste {
	title      string  [json: title]     = "(Untitled)"
	expires_in string  [json: expiresIn] = "never"
	is_private bool    [json: isPrivate] = false
	is_public  bool    [json: isPublic ] = false
	tags       string  [json: tags]      = ""
	pasties    []Pasty [json: pasties; required]
}


struct GetPasteConfig {
	id    string [required]
	token string
}

pub fn get_paste (config GetPasteConfig) ?RawPaste {
	mut request := http.new_request(.get, get_paste_endpoint + config.id, "") ?
	if config.token != "" {
		request.add_header("Authorization", config.token)
	}
	response := request.do() ?
	return json.decode(RawPaste, response.text)
}


struct CreatePasteConfig {
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

struct DeletePasteConfig {
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
	return response.status_code == 200
}

// tests

// get public paste
// println("Getting paste")
// println(get_paste(id: '99is6n23'))
// get private paste
// println("Getting private paste")
// println(get_paste(id: 'xc9mvyaq', token: 'token'))
// create public paste 

// fn main () {
//     mut new_pasty := Pasty {
//         language: "autodetect"
//         title   : "test"
//         code    : "print('test')"
//     }
//     mut new_paste := Paste {
//         title   : "test"
//         pasties : [new_pasty]
//     }

//     mut result := create_paste(paste: new_paste) ?
//     print(result.str())
// }