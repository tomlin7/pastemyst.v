module tests

import os
import venv

venv.load_env(overwrite: false)
const username = os.getenv('API_USERNAME')
const api_token = os.getenv('API_TOKEN')