*** Settings ***

Documentation     PracticeAutomation
Library           SeleniumLibrary
Suite Setup       Setup Test Suite
Suite Teardown    Close All Browsers

*** variables ***

${SLIDER_INPUT}=      10
${DROPDOWN_VALUE}=    75
${IMAGE}=             tag:img
${SVG}=               id:svgRect
${IMAGE_IFRAME}=      id:myFrame1
${METER_BAR}=         id:meterBar
${SLIDER}=            id:mySlider
${DROPDOWN}=          id:mySelect
${METER_TEXT}=        id:meterLabel
${PROGRESS_BAR}=      id:progressBar
${PROGRESS_TEXT}=     id:progressLabel
${URL_LINK}=          https://seleniumbase.com
${URL}=               https://seleniumbase.io/demo_page/

***Test Cases***

Test svg
    [Tags]    svg
    Check svg animation and color

Test slider
    [Tags]    slider
    Move slider
    Check progress bar

Test meter
    [Tags]    meter
    Select dropdown value and check meter

Test image in iframe
    [Tags]    image
    Check image in iframe

Test iframe text
    [Tags]    i_text
    Check image in iframe

Test url link
    [Tags]    url_link
    Click url and check output

*** Keywords ***

Setup Test Suite
    Set Selenium Timeout    30
    SeleniumLibrary.Set Screenshot Directory    EMBED
    Open Browser    ${URL}    chrome    options=add_argument("--start-maximized")
    Wait Until Page Contains    SeleniumBase

Check svg animation and color
    Sleep    2
    Click Element    ${SVG}
    ${animation_state}=    Execute JavaScript    return window.getComputedStyle(document.querySelector('svg rect')).animationPlayState
    Should Be Equal    ${animation_state}    running
    ${FILL_COLOR}=    Get Element Attribute    ${SVG}    fill
    Should Be Equal    "${FILL_COLOR}"    "#4CA0A0"

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

Select dropdown value and check meter
    Select From List By Label    ${DROPDOWN}    Set to ${DROPDOWN_VALUE}%
    ${TEXT}=    Get Text    ${METER_TEXT}
    Should Contain    ${TEXT}    ${DROPDOWN_VALUE}%
    ${VALUE}=    Get Element Attribute    ${METER_BAR}    value
    ${PERCENTAGE}=    Evaluate    float(${VALUE}) * 100
    Should Be Equal As Numbers    ${PERCENTAGE}    ${DROPDOWN_VALUE}
    ${METER}=    Set Variable    <h2>${TEXT}</h2>
    Log    ${METER}    html=True

Click url and check output
    Page Should Contain Link    ${URL_LINK}
    Click Link    ${URL_LINK}
    Wait Until Page Contains    Web Automation & Testing with Python
    Sleep    2
    Capture Page Screenshot
    Go Back
    Sleep    2
    Capture Page Screenshot

Check image in iframe
    Select Frame    ${IMAGE_IFRAME}
    Wait Until Element Is Visible    ${IMAGE}
    Capture Element Screenshot    ${IMAGE}
    Unselect Frame

Get element width
    [Arguments]    ${ELEMENT_DIV}
    ${X}     ${Y}=    Get Element Size    ${ELEMENT_DIV}
    ${X}=    Convert To Number    ${X}    0
    RETURN    ${X}
