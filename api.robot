*** Settings ***
Library         REST    http://localhost:8080
Library         Collections
Library         String
Library         RequestsLibrary
Library         OperatingSystem

*** Variables ***
${new_props}=   {  "username": "1111", "password": "1111" , "firstname": "1111" , "lastname" : "1111" , "phone" : "1111" }
# ${url}=   http://localhost:8080


*** Test Cases ***
GET all existing users, write result to a file
    GET         /users
    [Teardown]  Output  response body       ${OUTPUTDIR}/output/all_users.html

POST to create a new user from file
  POST          /users                      ${CURDIR}/user1.json
  Integer     response status               201         #404
  [Teardown]  Output  response body         ${OUTPUTDIR}/output/new_user.html

POST to create a new user from parameter
  POST          /users                      ${new_props}
  Integer     response status               201         #404
  [Teardown]  Output  response body         ${OUTPUTDIR}/output/new_user.html

DELETE the existing successfully, save the history of all requests
  DELETE      /users                      # status can be any of the below
  Integer     response status             200    202     204    #404
  [Teardown] Rest instances  ${OUTPUTDIR}/output/all.html  # all the instances so far


*** Keywords ***

