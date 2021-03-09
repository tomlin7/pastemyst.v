import json
import net.http

const paste_endpoint = "https://paste.myst.rs/api/v2/paste/"

/*
 Pasty object
 */
struct Pasty{
	id       string [json: _id]
	language string [json: language ]
	title    string [json: title    ]
	code     string [json: code     ]
}

/*
Edit object
*/
struct Edit{
	id        string   [json: _id]
	edit_id   string   [json: editId   ]
	edit_type int      [json: editType ]
	metadata  []string [json: metadata ]
	edit      string   [json: edit     ]
	edited_at int      [json: editedAt ]
}


/*
Paste object
*/
struct Paste {
	id         string   [json: _id]
	owner_id   string   [json: ownerId  ]
	title      string   [json: title    ]
	created_at u64      [json: createdAt]
	expires_in string   [json: expiresIn]
	deletes_at u64      [json: deletesAt]
	stars      u64      [json: stars    ]
	is_private bool     [json: isPrivate]
	is_public  bool     [json: isPublic ]
	tags       []string [json: tags     ]
	pasties    []Pasty  [json: pasties  ]
	edits      []Edit   [json: edits    ]
}

pub fn get_paste(id string) ?Paste {
	response := http.get(paste_endpoint + id) ?
	return json.decode(Paste, response.text)
}

// fn get_private_paste(id string, token string) ?string {
// 	response := http.get(paste_endpoint + id)
// 	return response.text
// }

println("Getting paste")
println(get_paste('99is6n23'))
// println("Getting private paste")
// println(get_private_paste('99is6n23', 'token'))