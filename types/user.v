module types

pub struct RawUser {
	id               string  [json: _id]
	username         string  [json: username]
	avatar_url       string  [json: avatarUrl]
	default_lang     string  [json: defaultLang]
	public_profile   bool    [json: publicProfile]
	supporter_length int     [json: supporterLength]
	contributor      bool    [json: contributor]
}

