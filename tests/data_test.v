module tests

import billyeatcookies.pastemyst.endpoints
import billyeatcookies.pastemyst.types

fn test_get_language_by_name() ? {
    mut result := endpoints.get_language(name: "python") ?
    assert result.name == "Python"
}

fn test_get_language_by_extension() ? {
    mut result := endpoints.get_language(extension: "py") ?
    assert result.name == "Python"
}