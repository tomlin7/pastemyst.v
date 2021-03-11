module types

pub struct RawUser {
	pub: id               string  [json: _id]
	pub: username         string  [json: username]
	pub: avatar_url       string  [json: avatarUrl]
	pub: default_lang     string  [json: defaultLang]
	pub: public_profile   bool    [json: publicProfile]
	pub: supporter_length int     [json: supporterLength]
	pub: contributor      bool    [json: contributor]
}

