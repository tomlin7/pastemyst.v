module types

/**
 * Represents a paste object on the site.
 *
 * NOTE: A single paste may contain multiple "pasties", which are
 * smaller, contained files, each with their own content and language.
 *
 * NOTE: https://paste.myst.rs/api-docs/objects
 */
pub struct RawPaste {
pub:
	/**
	 * The unique ID of the paste.
	 */
	id         string     [json: _id]
	/**
	 * The ID of the owner. If the paste does not have an owner, this is set to "".
	 */
	owner_id   string     [json: ownerId]
	/**
	 * The title of the paste.
	 */
	title      string     [json: title]
	/**
	 * The unix timestamp of when the paste was created.
	 */
	created_at u64        [json: createdAt]
	/**
	 * When the paste will expire.
	 */
	expires_in string     [json: expiresIn]
	/**
	 * The unix timestamp of when the paste will be deleted.
     * If it does not have an expiry date, this is set to 0.
	 */
	deletes_at u64        [json: deletesAt]
	/**
	 * The number of the stars that the paste has received.
	 */
	stars      u64        [json: stars]
	/**
	 * Is the paste only accessible by the owner?
	 */
	is_private bool       [json: isPrivate]
	/**
	 * Is the paste displayed publicly on the owner's profile?
	 */
	is_public  bool       [json: isPublic]
	/**
	 * The tags of the paste.
	 */
	tags       []string   [json: tags]
	/**
	 * The pasties contained within the paste. This array can not be empty.
	 */
	pasties    []RawPasty [json: pasties]
	/**
	 * The edits that were made to the paste.
	 */
	edits      []RawEdit  [json: edits]
}

/**
 * Represents a new paste object to be created.
 *
 * NOTE: Members of the object marked with `(auth)` can only be accessed if 
 * personal API token has been provided.
 *
 * NOTE: https://paste.myst.rs/api-docs/paste
 */
pub struct Paste {
pub:
	/**
	 * The title of the paste to be created.
	 */
	title      string     [json: title]
	/**
	 * When the paste will expire.
	 */
	expires_in string     [json: expiresIn] = "never"
	/**
	 * Is the new paste only accessible by the owner? (auth)
	 */
	is_private bool       [json: isPrivate]
	/**
	 * Is the new paste displayed publicly on the owner's profile? (auth)
	 */
	is_public  bool       [json: isPublic ]
	/**
	 * The tags of the new paste. (auth)
	 */
	tags       string     [json: tags]
	/**
	 * The pasties contained within the paste. This array can not be empty.
	 */
	pasties    []Pasty    [json: pasties; required]
}
