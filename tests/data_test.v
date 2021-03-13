module tests

import billyeatcookies.pastemyst.endpoints
import billyeatcookies.pastemyst.types

fn test_get_language_by_name() ? {
    assert endpoints.get_language(name: "unknown language") ? !is types.RawLanguage

    mut result := endpoints.get_language(name: "python") ?
    assert result.name == "Python"
}

fn test_get_language_by_extension() ? {
    assert endpoints.get_language(extension: "unknown extension") ? !is types.RawLanguage
    
    mut result := endpoints.get_language(extension: "py") ?
    assert result.name == "Python"
}