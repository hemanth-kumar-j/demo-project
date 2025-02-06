*** Settings ***

Documentation     PracticeAutomation
Library           SeleniumLibrary
Suite Setup       Setup Test Suite
Suite Teardown    Close All Browsers

*** variables ***

${SLIDER_INPUT}=       10
${DROPDOWN_VALUE}=     75
${IMAGE}=              tag:img
${DRAG_IMAGE}=         id:logo
${DROP_1}=             id:drop1
${DROP_2}=             id:drop2
${SVG}=                id:svgRect
${LINK_TEXT}=          id:myLink2
${IMAGE_IFRAME}=       id:myFrame1
${METER_BAR}=          id:meterBar
${SLIDER}=             id:mySlider
${DROPDOWN}=           id:mySelect
${TEXT_IFRAME}=        id:myFrame2
${CHECKBOX_IFRAME}=    id:myFrame3
${CHECKBOX}=           id:checkBox1
${CHECKBOX_1}=         id:checkBox2
${CHECKBOX_2}=         id:checkBox3
${CHECKBOX_3}=         id:checkBox4
${PRE_CHECKBOX}=       id:checkBox5
${IFRAME_CHECKBOX}=    id:checkBox6
${METER_TEXT}=         id:meterLabel
${PROGRESS_BAR}=       id:progressBar
${RADIO_BUTTON_1}=     id:radioButton1
${RADIO_BUTTON_2}=     id:radioButton2
${PROGRESS_TEXT}=      id:progressLabel
${HIDDEN_ROW}=         class:hidden_row
${I_TEXT}=             xpath:/html/body/h4
${URL_LINK}=           https://seleniumbase.com
${GITHUB_ICON}=        class:octicon-mark-github
${URL}=                https://seleniumbase.io/demo_page/

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
    Check text in iframe

Test radio buttons
    [Tags]    radio
    Select radio buttons and verify

Test checkbox and drag n drop
    [Tags]    drag_n_drop
    Select checkbox and drag n drop the image

Test checkboxes
    [Tags]    checkboxes
    Select checkboxes and verify

Test pre-checkbox
    [Tags]    pre-checkbox
    Unselect pre-check box

Test checkbox in iframe
    [Tags]    iframe-checkbox
    Select checkbox in iframe and verify

Test url link
    [Tags]    url_link
    Click url and check output

Test link with text
    [Tags]    text_link
    Click link with text and verify

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

Check image in iframe
    Select Frame    ${IMAGE_IFRAME}
    Wait Until Element Is Visible    ${IMAGE}
    Capture Element Screenshot    ${IMAGE}
    Unselect Frame

Check text in iframe
    Select Frame    ${TEXT_IFRAME}
    ${TEXT}=    Get Text    ${I_TEXT}
    Should Be Equal    ${TEXT}    iFrame Text
    Unselect Frame

Select radio buttons and verify
    Click Element    ${RADIO_BUTTON_2}
    ${CHECKED}=    Get Element Attribute    ${RADIO_BUTTON_2}    checked
    Should Be Equal    ${CHECKED}    true
    Click Element    ${RADIO_BUTTON_1}
    ${CHECKED}=    Get Element Attribute    ${RADIO_BUTTON_1}    checked
    Should Be Equal    ${CHECKED}    true

Select checkbox and drag n drop the image
    Select Checkbox    ${CHECKBOX}
    Wait Until Element Is Visible    ${DRAG_IMAGE}
    Drag And Drop    ${DRAG_IMAGE}    ${DROP_2}
    Sleep    1
    Capture Element Screenshot    ${HIDDEN_ROW}
    Drag And Drop    ${DRAG_IMAGE}    ${DROP_1}

Select checkboxes and verify
    Select checkbox and verify    ${CHECKBOX_1}
    Select checkbox and verify    ${CHECKBOX_2}
    Select checkbox and verify    ${CHECKBOX_3}

Select checkbox and verify
    [Arguments]    ${CHECKBOX}
    Select Checkbox    ${CHECKBOX}
    ${CHECKED}=    Get Element Attribute    ${CHECKBOX}    checked
    Should Be Equal    ${CHECKED}    true
    Sleep    1

Unselect pre-check box
    ${CHECKED}=    Get Element Attribute    ${PRE_CHECKBOX}    checked
    IF    "${CHECKED}" == "true"
        Unselect Checkbox    ${PRE_CHECKBOX}
    ELSE
        Log    "Checkbox is not pre-checked"
    END

Select checkbox in iframe and verify
    Select Frame    ${CHECKBOX_IFRAME}
    Select Checkbox    ${IFRAME_CHECKBOX}
    ${CHECKED}=    Get Element Attribute    ${IFRAME_CHECKBOX}    checked
    Should Be Equal    ${CHECKED}    true
    Unselect Frame

Click url and check output
    Page Should Contain Link    ${URL_LINK}
    Click Link    ${URL_LINK}
    Wait Until Page Contains    Web Automation & Testing with Python
    Sleep    2
    Capture Page Screenshot
    Go Back
    Sleep    1

Click link with text and verify
    ${TEXT}=    Get Text    ${LINK_TEXT}
    Should Be Equal    ${TEXT}    SeleniumBase on GitHub
    Click Link    ${TEXT}
    ${CURRENT_URL}=    Get Location
    Should Contain    ${CURRENT_URL}    github.com/seleniumbase/SeleniumBase
    Wait Until Element Is Visible    ${GITHUB_ICON}
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
