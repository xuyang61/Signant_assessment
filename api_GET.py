#simple test case to test GET API. validation. 

import requests

host_url = "http://localhost:8080"
response = requests.get(host_url+"/api/users")

print(response.text)
print(response.status_code)

