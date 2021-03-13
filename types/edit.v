module types

/**
 * Represents an edit to a paste object.
 *
 * NOTE: https://paste.myst.rs/api-docs/objects
 */
struct RawEdit {
pub:
	/**
	 * The unique ID of the edit.
	 */
	id        string   [json: _id]
	/**
	 * The sequential ID of the edit. 
	 * NOTE: Multiple edits can share the same id, indicating that multiple fields
	 * were changed simultaneously.
	 */
	edit_id   string   [json: editId]
	/**
	 * The type of the edit.
	 */
	edit_type EditType [json: editType]
	/**
	 * Internally used metadata, mainly used to determine which pasty was edited.
	 */
	metadata  []string [json: metadata]
	/**
	 * The actual paste edit, storing old data before the edit. New data is stored
	 * in the actual RawPaste object.
	 */
	edit      string   [json: edit]
	/**
	 * The unix timestamp of when the edit was made at.
	 */
	edited_at int      [json: editedAt]
}

/**
 * Represents a new edit to a paste object, to be created.
 *
 * NOTE: https://paste.myst.rs/api-docs/objects
 */
pub struct Edit {
pub: 
	/**
	 * Desired title for the new paste edit.
	 */
	title      string  [json: title]
	/**
	 * Whether the paste should be changed to private in new edit.
	 */
	is_private bool    [json: isPrivate]
	/**
	 * Whether the paste should be displayed in the user's public profile in the
	 * new edit.
	 */
	is_public  bool    [json: isPublic]
	/**
	 * Tags to be in for the new edit.
	 */
	tags       string  [json: tags]
	/**
	 * Pasties to be in the new edit.
	 * NOTE: you need to provide all of the original pasties, only making the changes you want.
	 * It is not possible to update a single pasty without providing all of the original pasties.
	 */
	pasties    []Pasty [json: pasties]
}

/**
 * Represents the type of a paste edit.
 *
 * NOTE: https://paste.myst.rs/api-docs/objects
 */
enum EditType {
    title = 0
    pasty_title = 1
    pasty_language = 2
    pasty_content = 3
    pasty_added = 4
    pasty_removed = 5
}