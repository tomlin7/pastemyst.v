module types

/**
 * Represents a pasty, which is an individual file in a larger paste object.
 *
 * NOTE: https://paste.myst.rs/api-docs/objects
 */
struct RawPasty {
pub:
	/**
     * The ID of the pasty.
     */
	id       string [json: _id]
	/**
     * The language of the pasty.
     */
	language string [json: language]
	/**
     * The title of the pasty.
     */
	title    string [json: title]
	/**
     * The contents of the pasty.
     */
	code     string [json: code]
}

/**
 * Represents a new pasty object, to be added to new paste or edit object.
 *
 * NOTE: https://paste.myst.rs/api-docs/paste
 */
pub struct Pasty {
pub:
	/**
     * The language of the pasty.
     */
	language string [json: language] = "autodetect" 
	/**
     * The title of the pasty.
     */
	title    string [json: title]
	/**
     * The contents of the pasty. [required]
     */
	code     string [json: code]
}
