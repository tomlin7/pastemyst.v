import json
import net.http

const get_paste_endpoint = "https://paste.myst.rs/api/v2/paste/"
const create_paste_endpoint = "https://paste.myst.rs/api/v2/paste"

/*
 Pasty object
 */
struct RawPasty {
	id       string [json: _id; skip]
	language string [json: language ]
	title    string [json: title    ]
	code     string [json: code     ]
}

/*
Edit object
*/
struct RawEdit {
	id        string   [json: _id; skip]
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
	id         string    [json: _id; skip]
	owner_id   string    [json: ownerId  ]
	title      string    [json: title    ]
	created_at u64       [json: createdAt]
	expires_in string    [json: expiresIn]
	deletes_at u64       [json: deletesAt]
	stars      u64       [json: stars    ]
	is_private bool      [json: isPrivate]
	is_public  bool      [json: isPublic ]
	tags       []string  [json: tags     ]
	pasties    []RawPasty   [json: pasties  ]
	edits      []RawEdit [json: edits    ]
}

pub struct Pasty {
	language string [json: language ]
	title    string [json: title    ]
	code     string [json: code     ]
}

pub struct Edit {
	title      string  [json: title;       skip]
	is_private bool    [json: isPrivate;   skip]
	is_public  bool    [json: isPublic;    skip]
	tags       string  [json: tags;        skip]
	pasties    []Pasty [json: pasties; required]
}

pub struct Paste {
	title      string  [json: title;       skip]
	expires_in string  [json: expiresIn;   skip]
	is_private bool    [json: isPrivate;   skip]
	is_public  bool    [json: isPublic;    skip]
	tags       string  [json: tags;        skip]
	pasties    []Pasty [json: pasties; required]
}


struct GetPasteConfig {
	id    string [required]
	token string [skip]
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
	token string [skip]
}

pub fn create_paste (config CreatePasteConfig) ?RawPaste {
	mut request := http.new_request(.post, create_paste_endpoint, json.encode(config.paste)) ?
	request.add_header('Content-Type','application/json')
	if config.token != "" {
		request.add_header("Authorization", config.token)
	}
	response := request.do() ?
	return json.decode(RawPaste, response.text)
}


// tests

// get public paste
// println("Getting paste")
// println(get_paste(id: '99is6n23'))
// get private paste
// println("Getting private paste")
// println(get_paste(id: 'xc9mvyaq', token: 'token'))
// create public paste 
print(create_paste(paste: Paste{
	pasties : [
		Pasty{
			"Python",
			"example python",
			"print('hello')"
		}
	]
}))