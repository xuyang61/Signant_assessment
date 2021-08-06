*** Settings ***
Library             Collections
Library             Browser
Suite Setup         Setup Test Suite    headless=false
Suite Teardown      Close Browser
Test Setup          New Page            http://localhost:8080
Test Teardown       Close Context

*** Test Cases ***
Register Without Any Info
    Register User   user=${EMPTY}   pass=${EMPTY}   f_name=${EMPTY}  l_name=${EMPTY}     phone=${EMPTY}    valid=${False}

Register Without Firstname
    Register User   user=${USER}    pass=fakepassword   f_name=${EMPTY}     l_name=Testaaja     phone=0456789         valid=${False}

Register Without familyname
    Register User    user=${USER}    pass=fakepassword  f_name=Tester   l_name=${EMPTY}     phone=0456789          valid=${False}

Register Without Email
    Register User    user=${USER}    pass=fakepassword  f_name=Tester   l_name=Testaaja     phone=${EMPTY}          valid=${False}

Register Without Username
    Register User   user=${EMPTY}   pass=fakepassword   f_name=Tester   l_name=Testaaja   phone=0456789            valid=${False}

Register Without Password
    Register User    user=${USER}    pass=${EMPTY}   f_name=Tester   l_name=Testaaja   phone=0456789            valid=${False}

Register With All Info
    Register User       user=${USER}    pass=fakepass   f_name=Tester     l_name=Testaaja   phone=0456789     valid=${True}


*** Keywords ***
Register User
    [Arguments]     ${f_name}=${EMPTY}  ${l_name}=${EMPTY}  ${phone}=${EMPTY}   ${user}=${EMPTY}    ${pass}=${EMPTY}    ${valid}=${True}
    Wait For Elements State         text=Register
    Click                           text=Register
    Wait For Elements State         id=username
    Type Text       id=username     ${USER}
    Wait For Elements State         id=password
    Type Text       id=password     ${pass}
    Wait For Elements State         id=firstname
    Type Text       id=firstname    ${f_name}
    Wait For Elements State         id=lastname
    Type Text       id=lastname   ${l_name}
    Wait For Elements State         id=phone
    Type Text       id=phone        ${phone}

    Click           xpath=/html/body/section/form/input[6]
    # Validate if the registeration work as expected
    IF              ${valid}
        Get Element Count           text=Log In     ==  3
    ELSE
        Get Element Count           text=Register   ==  3
    END


Setup Test Suite
    [Arguments]     ${headless}=true
    New Browser     chromium    headless=${headless}
    ${USER}=        Create Unique String
    Set Suite Variable          ${USER}     ${USER}
    Log To Console              \nCreated new username "${USER}"


Create Unique String
    [Documentation]    This keyword creates a 8 character long string with random digits and characters
    ${res}=    Evaluate    "".join(random.choice(string.ascii_uppercase+string.digits) for i in range(8))    random, string
    [Return]    ${res}