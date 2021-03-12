module types

pub struct RawPaste {
pub: 
	id         string     [json: _id]
	owner_id   string     [json: ownerId]
	title      string     [json: title]
	created_at u64        [json: createdAt]
	expires_in string     [json: expiresIn]
	deletes_at u64        [json: deletesAt]
	stars      u64        [json: stars]
	is_private bool       [json: isPrivate]
	is_public  bool       [json: isPublic]
	tags       []string   [json: tags]
	pasties    []RawPasty [json: pasties]
	edits      []RawEdit  [json: edits]
}

pub struct Paste {
pub: 
	title      string     [json: title]     = "(Untitled)"
	expires_in string     [json: expiresIn] = "never"
	is_private bool       [json: isPrivate]
	is_public  bool       [json: isPublic ]
	tags       string     [json: tags]
	pasties    []Pasty    [json: pasties; required]
}
