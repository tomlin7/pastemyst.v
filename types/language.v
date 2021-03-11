module types

pub struct RawLanguage {
	pub: name  string   [json: name]
	pub: mode  string   [json: mode]
	pub: mimes []string [json: mimes]
	pub: ext   []string [json: ext]
	pub: color string   [json: color]
}