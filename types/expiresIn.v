module pastemyst

enum ExpiresIn {
	never
	one_hour
	two_hours
	ten_hours
	one_day
	two_days
	one_week
	one_month
	one_year
}

fn (e ExpiresIn) str() string {
    return match e {
        .never      { "never" }
        .one_hour   { "1h" }
		.two_hours  { "2h" }
		.ten_hours  { "10h" }
		.one_day    { "1d" }
		.two_days   { "2d" }
		.one_week   { "1w" }
		.one_month  { "1m" }
		.one_year   { "1y" }
}
