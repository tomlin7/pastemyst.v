module types

/**
 * Represents a user on the PasteMyst site.
 *
 * NOTE: https://paste.myst.rs/api-docs/user
 */
pub struct RawUser {
pub:
	/**
     * The unique ID of the user.
     */
	id               string  [json: _id]
	/**
     * The full name of the user.
     */
	username         string  [json: username]
	/**
     * The URL of the user's avatar.
     */
	avatar_url       string  [json: avatarUrl]
	/**
     * The default language that is used for the user, when creating new pastes.
     */
	default_lang     string  [json: defaultLang]
	/**
     * Is the profile public?
     */
	public_profile   bool    [json: publicProfile]
	/**
     * How long the user has been a supporter for, 0 if the user is not a supporter.
     */
	supporter_length int     [json: supporterLength]
	/**
     * Is the user a contributor to PasteMyst?
     */
	contributor      bool    [json: contributor]
}
