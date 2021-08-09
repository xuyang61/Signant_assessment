# Test suite is to test the registration system API (GET, POST, PUT, DELETE)
# There is not update of the info, so PUT API is not applied. 
# As maintainance of system, test includes DELETE API into suite. 
# Test suites ultilize external library REST, Collections, Requestslibrary. 


*** Settings ***
Library         REST    http://localhost:8080
Library         Collections
Library         RequestsLibrary

*** Variables ***
${old_props}=   {  "username": "xxxx", "password": "xxxx" }
${new_props}=   {  "username": "1111", "password": "1111" , "firstname": "1111" , "lastname" : "1111" , "phone" : "1111" }
${host_url}=   http://localhost:8080


*** Test Cases ***
GET all existing users, write result to a file
    GET         ${host_url}/api/users
    [Teardown]  Output  response body       ${OUTPUTDIR}/output/all_users.html

POST to create a new user from parameter
    POST        ${host_url}/api/users       ${new_props}
    Integer     response status             201         #404
    [Teardown]  Output  response body       ${OUTPUTDIR}/output/new_user.html

DELETE the existing successfully, save the history of all requests
    DELETE      ${host_url}/api/users                  # status can be any of the below
    Integer     response status             200    201     202    204  #404
    [Teardown]  Output  response body       ${OUTPUTDIR}/output/all.html  # all the instances so far


*** Keywords ***

