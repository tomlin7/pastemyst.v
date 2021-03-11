module types

struct RawEdit {
pub:
	id        string   [json: _id]
	edit_id   string   [json: editId]
	edit_type int      [json: editType]
	metadata  []string [json: metadata]
	edit      string   [json: edit]
	edited_at int      [json: editedAt]
}

pub struct Edit {
pub: 
	title      string  [json: title]
	is_private bool    [json: isPrivate]
	is_public  bool    [json: isPublic]
	tags       string  [json: tags]
	pasties    []Pasty [json: pasties]
}

enum EditType {
    title = 0
    pasty_title = 1
    pasty_language = 2
    pasty_content = 3
    pasty_added = 4
    pasty_removed = 5
}