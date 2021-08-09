# Test suite is to test the registration system takes only completed registration entries into its system
# Test suites ultilize external library Browser, Collections. 
# System taken registration only once. So test case generate unique username and passsword for each test round.


*** Settings ***
Library             Collections
Library             Browser
Suite Setup         Setup Test Suite    headless=false
Suite Teardown      Close Browser
Test Setup          New Page            http://localhost:8080
Test Teardown       Close Context

# to run the test use: robot /path/User_Login.robot
*** Test Cases ***
Login The System
    [Arguments]      ${user}=${EMPTY}    ${pass}=${EMPTY}     ${f_name}=${EMPTY}  ${l_name}=${EMPTY}  ${phone}=${EMPTY}   ${valid}=${True}
    Register User   user=${USER}    pass=${PASS}     f_name=Fake     l_name=Testaaja     phone=0456789       valid=${True}
    Click           xpath=/html/body/section/form/input[6]
    # Validate if the registeration work as expected
    Get Element Count               text=Log In     ==      3
    Click                           text=Log In
    Wait For Elements State         id=username
    Type Text                       id=username     ${user}
    Wait For Elements State         id=password
    Type Text                       id=password     ${pass}
    Click                           xpath=/html/body/section/form/input[3]
        # Validate if the registeration work as expected
    Get Element Count               text=User Information    ==  1


*** Keywords ***
Register User
    [Arguments]      ${user}=${EMPTY}    ${pass}=${EMPTY}    ${f_name}=${EMPTY}  ${l_name}=${EMPTY}  ${phone}=${EMPTY}  ${valid}=${True}
    Wait For Elements State         text=Register
    Click                           text=Register
    Wait For Elements State         id=username
    Type Text       id=username     ${user}
    Wait For Elements State         id=password
    Type Text       id=password     ${pass}
    Wait For Elements State         id=firstname
    Type Text       id=firstname    ${f_name}
    Wait For Elements State         id=lastname
    Type Text       id=lastname     ${l_name}
    Wait For Elements State         id=phone
    Type Text       id=phone        ${phone}

Setup Test Suite
    [Arguments]     ${headless}=true
    New Browser     chromium    headless=${headless}
    ${USER}=        Create Unique Username
    ${PASS}=        Create Unique Password
    Set Suite Variable          ${USER}     ${USER}
    Set Suite Variable          ${PASS}     ${PASS}
    Log To Console              \nCreated new username "${USER}"
    Log To Console              \nCreated new username "${PASS}"

Create Unique Username
    [Documentation]    This keyword creates a 8 character long string with random digits and characters
    ${res_1}=    Evaluate    "".join(random.choice(string.ascii_uppercase+string.digits) for i in range(8))    random, string
    [Return]    ${res_1}

Create Unique Password
    [Documentation]    This keyword creates a 8 character long string with random digits and characters
    ${res_2}=    Evaluate    "".join(random.choice(string.ascii_uppercase+string.digits) for i in range(8))    random, string
    [Return]    ${res_2}
