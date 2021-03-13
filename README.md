# pastemyst.v

An API wrapper for [paste.myst.rs](https://paste.myst.rs/), written in [V](https://vlang.io/).

All aspects of the v2 endpoint are currently implemented.

## Installation

You can install the library via [vpm](https://vpm.vlang.io/):

```bash
v install billyeatcookies.pastemyst
```

## Usage

The `endpoints` are grouped inside the library as a submodule. For example, information on a paste can be retrieved as such:

```go
import billyeatcookies.pastemyst.endpoints

// optional; some endpoints require authorization through your personal
//   api token, retrieved through your profile settings.

const my_paste = endpoints.get_paste(id: "my_paste_id") ?
```

You can find a list of endpoints over on PasteMyst's [API docs](https://paste.myst.rs/api-docs/). Each of these endpoints has an equivalent wrapper method in the library. Since the library is written in V with a fully-documented codebase, usage can easily be extrapolated from the documentation and IntelliSense.

## License

This project is available under a [MIT](./LICENSE) license.

## Acknowledgements

Thanks to [discord/vlang](https://discord.gg/vlang) community for helping me out a lot on writing this, and for providing valuable feedback on the project.

<!--
# pastemyst.v

### Main Features
|Features|Public|Private|Optimized|
| :----: | :----:| :----:| :----:|
|get_paste|✅|✅|✅|
|create_paste|✅|✅|✅|
|edit_paste|❗|✅|✅|
|delete_paste|❗|✅|✅|

### Misc Features
| Features|Available|Optimized|
|:---:|:---:|:---:|
|check_user|✅|✅|
|user_exists|✅|✅|
|get_language|✅|✅|

-->