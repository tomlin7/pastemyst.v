module types

struct RawPasty {
	pub: id       string [json: _id]
	pub: language string [json: language]
	pub: title    string [json: title]
	pub: code     string [json: code]
}

pub struct Pasty {
	pub: language string [json: language] = "autodetect" 
	pub: title    string [json: title]    = "(untitled)"
	pub: code     string [json: code]
}