module tests

import billyeatcookies.pastemyst.endpoints

fn test_get_language_by_name() ? {
    assert endpoints.get_language(name: "unknown language") is bool

    mut result := endpoints.get_language(name: "python") ?
    if result !is bool {
        assert result.name == "Python"
    }
}

fn test_get_language_by_extension() ? {
    assert endpoints.get_language(extension: "unknown extension") is bool
    
    mut result := endpoints.get_language(extension: "py") ?
    if result !is bool {
        assert result.name == "Python"
    }
}