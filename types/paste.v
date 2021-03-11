module types

pub struct RawPaste {
	pub: id         string     [json: _id]
	pub: owner_id   string     [json: ownerId]
	pub: title      string     [json: title]
	pub: created_at u64        [json: createdAt]
	pub: expires_in string     [json: expiresIn]
	pub: deletes_at u64        [json: deletesAt]
	pub: stars      u64        [json: stars]
	pub: is_private bool       [json: isPrivate]
	pub: is_public  bool       [json: isPublic]
	pub: tags       []string   [json: tags]
	pub: pasties    []RawPasty [json: pasties]
	pub: edits      []RawEdit  [json: edits]
}

pub struct Paste {
	pub: title      string     [json: title]     = "(Untitled)"
	pub: expires_in string     [json: expiresIn] = "never"
	pub: is_private bool       [json: isPrivate]
	pub: is_public  bool       [json: isPublic ]
	pub: tags       string     [json: tags]
	pub: pasties    []Pasty    [json: pasties; required]
}
