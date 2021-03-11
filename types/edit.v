module types

struct RawEdit {
	pub: id        string   [json: _id]
	pub: edit_id   string   [json: editId]
	pub: edit_type int      [json: editType]
	pub: metadata  []string [json: metadata]
	pub: edit      string   [json: edit]
	pub: edited_at int      [json: editedAt]
}

pub struct Edit {
	pub: title      string  [json: title]
	pub: is_private bool    [json: isPrivate]
	pub: is_public  bool    [json: isPublic]
	pub: tags       string  [json: tags]
	pub: pasties    []Pasty [json: pasties]
}

enum EditType {
    title = 0
    pasty_title = 1
    pasty_language = 2
    pasty_content = 3
    pasty_added = 4
    pasty_removed = 5
}