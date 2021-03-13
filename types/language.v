module types

/**
 * Represents a (programming) language that is usable on PasteMyst.
 *
 * NOTE: https://paste.myst.rs/api-docs/data
 */
pub struct RawLanguage {
pub:
	/**
	 * The full name of the language.
	 */
	name  string   [json: name]
	/**
	 * The language mode to be used in the editor.
	 */
	mode  string   [json: mode]
	/**
	 * The mimes associated with the language.
	 */
	mimes []string [json: mimes]
	/**
	 * The extensions used by the language.
	 */
	ext   []string [json: ext]
	/**
	 * The colour representing the language.
	 */
	color string   [json: color]
}