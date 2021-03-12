module tests

import billyeatcookies.pastemyst.endpoints
import billyeatcookies.pastemyst.types


struct Client {
mut:
    created_pastes []types.Paste
}

fn (mut client Client) add_paste (paste types.Paste) {
    client.created_pastes << paste
}
fn (mut c Client) get_all_created_pastes () ?[]string {
    return created_pastes.pastes
}

const client := Client{}

const sample_pasty = types.Pasty{
	title: "Test Pasty",
	language: "plain text",
	code: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
}
const api_token = $env('API_TOKEN')

fn testsuite_begin () {
	if api_token == "" {
		println("No API token was supplied in the environment variables. " + "Unit tests that require authorization may not pass.")
	}
}


fn test_get_public_paste () ? {
	mut paste := endpoints.get_paste(id: "99is6n23") ?

	assert paste is types.RawPaste
	if mut paste is types.RawPaste {
		assert paste.title == "public paste example title" 
	}
}

fn test_get_private_paste () ? {
	mut paste := endpoints.get_paste(id: "grajzo1h", token: api_token) ?

	assert paste is types.RawPaste
	if mut paste is types.RawPaste {
		assert paste.title == "private paste example title" 
	}
}

fn test_create_public_paste () ? {
	mut title     := "[pastemyst.v] Public Paste Create Test"
	mut new_paste := types.Paste {
		title      : title,
		expires_in : "1h",
		pasties    : [sample_pasty]
	}

	mut created_paste := endpoints.create_paste(paste: new_paste) ?

	assert created_paste is types.RawPaste
	if mut created_paste is types.RawPaste {
		assert created_paste.title == title
		
		client.add_paste(created_paste)
	}
}

fn test_create_private_paste () ? {
	mut title     := "[pastemyst.v] Private Paste Create Test"
	mut new_paste := types.Paste {
		title      : title,
		expires_in : "1h",
		is_private : true
		pasties    : [sample_pasty]
	}

	created_paste := endpoints.create_paste(paste: new_paste, token: api_token) ?

	assert created_paste is types.RawPaste
	if mut created_paste is types.RawPaste {
		assert created_paste.title == title
		assert created_paste.is_private == true

		client.add_paste(created_paste)
	}
}


fn test_delete_paste () ? {
	mut new_paste := types.Paste {
		pasties   : [sample_pasty]
	}
	mut created_paste := endpoints.create_paste(paste: new_paste) ?

	assert created_paste is types.RawPaste
	if mut created_paste is types.RawPaste {
		mut is_paste_deleted := endpoints.delete_paste(id: created_paste.id, token: api_token) ?
		assert is_paste_deleted == true
	}
}

fn test_edit_paste () ? {
	mut new_paste := types.Paste {
		pasties   : [sample_pasty]
	}
	mut created_paste := endpoints.create_paste(paste: new_paste) ?

	assert created_paste is types.RawPaste

	if mut created_paste is types.RawPaste {
		mut desired_title := "[pastemyst.v] Paste Edit Test"
		mut desired_edit  := types.Edit {
			title      : desired_title,
			tags       : "edit, test",
			pasties    : [sample_pasty]
		}
		mut edited_paste := endpoints.edit_paste(id: paste._id, edit: desired_edit, token: api_token) ?

		assert edited_paste is types.RawPaste
		if mut edited_paste is types.RawPaste {
			assert editedPaste.title == desiredTitle

			client.add_paste(created_paste)
		}
	}
}


fn testsuite_end () ? {
	if created_pastes.len > 0 {
		println("==== Paste Cleanup ====")
		for created_paste in client.get_all_created_pastes {
			println("Cleaning up paste with id: $created_paste.id, title: $created_paste.title")
			mut is_paste_deleted := endpoints.delete_paste(id: created_paste.id, token: api_token) ?
			if is_paste_deleted {
				println("Paste deleted")
			} else {
				println("Couldn't delete paste $created_paste.id")
			}
		}
		println("=======================")
	}
}