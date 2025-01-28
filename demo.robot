*** Settings ***

Documentation     PracticeAutomation
Library           SeleniumLibrary
Suite Setup       Setup Test Suite
Suite Teardown    Close All Browsers

*** variables ***

${SLIDER_INPUT}=     10
${SVG}=              id:svgRect
${SLIDER}=           id:mySlider
${PROGRESS_BAR}=     id:progressBar
${PROGRESS_TEXT}=    id:progressLabel
${WEB_SITE}=         https://seleniumbase.com
${URL}=              https://seleniumbase.io/demo_page/

***Test Cases***

Test svg color
    [Tags]    svg
    ${FILL_COLOR}=    Get Element Attribute    ${SVG}    fill
    Should Be Equal    "${FILL_COLOR}"    "#4CA0A0"

Test slider
    [Tags]    slider
    Move slider
    Check progress bar

Test url link
    [Tags]    url_link
    Click url and check output

*** Keywords ***

Setup Test Suite
    Set Selenium Timeout    30
    SeleniumLibrary.Set Screenshot Directory    EMBED
    Open Browser    ${URL}    chrome    options=add_argument("--start-maximized")
    Wait Until Page Contains    SeleniumBase

Move slider
    ${SLIDER_BAR}=    Get element width    ${SLIDER}
    ${SLIDER_VAL}=    Evaluate    ${SLIDER_BAR} / 100
    ${SLIDER_VALUE}=    Evaluate    ${SLIDER_VAL} * ${SLIDER_INPUT}
    ${SLIDER_HALF}=    Evaluate    ${SLIDER_BAR} / 2
    ${X}=    Evaluate    ${SLIDER_VALUE} - ${SLIDER_HALF}
    ${X}=    Convert To Number    ${X}    0
    Drag And Drop By Offset    ${SLIDER}    ${X}    0
    Sleep    2

Check progress bar
    ${TEXT}=    Get Text    ${PROGRESS_TEXT}
    Should Contain    ${TEXT}    ${SLIDER_INPUT}%
    ${VALUE}=    Get Element Attribute    ${PROGRESS_BAR}    value
    Should Be Equal    ${VALUE}    ${SLIDER_INPUT}
    ${PROGRESS}=    Set Variable    <h2>${TEXT}</h2>
    Log    ${PROGRESS}    html=True

Click url and check output
    Page Should Contain Link    ${WEB_SITE}
    Click Link    ${WEB_SITE}
    Wait Until Page Contains    Web Automation & Testing with Python
    Sleep    2
    Capture Page Screenshot
    Go Back
    Sleep    2
    Capture Page Screenshot

Get element width
    [Arguments]    ${ELEMENT_DIV}
    ${X}     ${Y}=    Get Element Size    ${ELEMENT_DIV}
    ${X}=    Convert To Number    ${X}    0
    RETURN    ${X}
