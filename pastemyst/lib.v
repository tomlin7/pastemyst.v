import net.http

const paste_endpoint = "https://paste.myst.rs/api/v2/paste/"

fn get_paste(id string) ?string {
	response := http.get(paste_endpoint + id) ?
	return response.text
}

// fn get_private_paste(id string, token string) ?string {
// 	response := http.get(paste_endpoint + id)
// 	return response.text
// }

println("Getting paste")
println(get_paste('99is6n23'))
// println("Getting private paste")
// println(get_private_paste('99is6n23', 'token'))