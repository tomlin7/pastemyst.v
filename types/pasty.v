module types

struct RawPasty {
	id       string [json: _id]
	language string [json: language]
	title    string [json: title]
	code     string [json: code]
}

pub struct Pasty {
	language string [json: language] = "autodetect" 
	title    string [json: title]    = "(untitled)"
	code     string [json: code]
}