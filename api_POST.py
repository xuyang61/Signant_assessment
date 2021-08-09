 #simple test case to ultilize POST API to create a new user account. 

import requests

host_url = "http://localhost:8080"

body = {
    "username": "1111",
    "password": "1111",
    "firstname": "1111",
    "lastname": "1111",
    "phone": "11111",
}

response = requests.post(host_url+"/api/users", data=body)

print(response.text)
print(response.status_code)



