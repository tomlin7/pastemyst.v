module tests

import billyeatcookies.pastemyst.endpoints
import billyeatcookies.pastemyst.types

/**
 * Template object for tests.
 */
struct TestTemplate {
	created_at int
	expires_in types.ExpiresIn
	expected   int
}

/**
 * Calculates expiry time.
 */
fn test_expires_in_to_unix_timestamp () ? {
	mut test_a := TestTemplate {
		created_at : 1615242814,
		expires_in : types.ExpiresIn.two_hours,
		expected   : 1615250014
	}

	mut test_b := TestTemplate {
		created_at : 1615121479,
		expires_in : types.ExpiresIn.one_day,
		expected   : 1615207879
	}

	mut test_c := TestTemplate {
		created_at : 1615297946,
		expires_in : types.ExpiresIn.one_week,
		expected   : 1615902746
	}

	preferred_tests := [test_a, test_b, test_c]

	for preferred_test in preferred_tests {
		mut expiry := endpoints.expires_in_to_unix_timestamp(
			created_at : preferred_test.created_at,
			expires_in : preferred_test.expires_in
		) ?
		assert expiry == preferred_test.expected
	}
}