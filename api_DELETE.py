import requests
import json

host_url = "http://localhost:8080"

response = requests.delete(host_url+"/api/users")

print(response.text)
print(response.status_code)


