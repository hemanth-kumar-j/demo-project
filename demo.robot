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
${PARAGRAPH}=          id:pText
${DROP_A}=             id:drop1
${DROP_B}=             id:drop2
${DEMO_PAGE}=          id:myForm
${SVG}=                id:svgRect
${LINK_TEXT_1}=        id:myLink2
${LINK_TEXT_2}=        id:myLink4
${IMAGE_IFRAME}=       id:myFrame1
${METER_BAR}=          id:meterBar
${SLIDER}=             id:mySlider
${DROPDOWN}=           id:mySelect
${TEXT_IFRAME}=        id:myFrame2
${CHECKBOX_IFRAME}=    id:myFrame3
${BUTTON}=             id:myButton
${CHECKBOX}=           id:checkBox1
${CHECKBOX_1}=         id:checkBox2
${CHECKBOX_2}=         id:checkBox3
${CHECKBOX_3}=         id:checkBox4
${PRE_CHECKBOX}=       id:checkBox5
${IFRAME_CHECKBOX}=    id:checkBox6
${METER_TEXT}=         id:meterLabel
${TEXT_AREA}=          id:myTextarea
${HOVER_DROPDOWN}=     id:myDropdown
${PROGRESS_BAR}=       id:progressBar
${TEXT_INPUT}=         id:myTextInput
${DROPDOWN_LINK_1}=    id:dropOption1
${DROPDOWN_LINK_2}=    id:dropOption2
${DROPDOWN_LINK_3}=    id:dropOption3
${READONLY_FIELD}=     id:readOnlyText
${RADIO_BUTTON_1}=     id:radioButton1
${RADIO_BUTTON_2}=     id:radioButton2
${PRE_FILLED_TEXT}=    id:myTextInput2
${PROGRESS_TEXT}=      id:progressLabel
${HIDDEN_ROW}=         class:hidden_row
${PLACEHOLDER}=        id:placeholderText
${I_TEXT}=             xpath:/html/body/h4
${URL_LINK_2}=         https://seleniumbase.io
${URL_LINK_1}=         https://seleniumbase.com
${GITHUB_ICON}=        class:octicon-mark-github
${URL}=                https://seleniumbase.io/demo_page/
${DROP_A_IMG}=         xpath://*[@id="drop1"]/*[@id="logo"]
${DROP_B_IMG}=         xpath://*[@id="drop2"]/*[@id="logo"]
${DROPDOWN_OUTPUT}=    xpath://*[@id="tbodyId"]/tr[1]/td[4]/h3

***Test Cases***

Test hover dropdown
    [Tags]    dropdown
    Check hover dropdown option and verify

Test text input field
    [Tags]    text_field
    Check text input field and verify

Test text area
    [Tags]    text area
    Check text area and verify

Test pre-field text filled
    [Tags]    pre_filled_text
    Verify pre-filled text

Test placeholder
    [Tags]    placeholder
    Verify placeholder disappears on typing

Test button color change
    [Tags]    button
    Verify button color before and after click

Test read-only text field
    [Tags]    read_only_text
    Verify read-only text field

Test paragraph with text
    [Tags]    paragraph
    Verify paragraph with text

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
    Check url link and verify

Test link with text
    [Tags]    text_link
    Check link with text

*** Keywords ***

Setup Test Suite
    Set Selenium Timeout    30
    SeleniumLibrary.Set Screenshot Directory    EMBED
    Open Browser    ${URL}    chrome    options=add_argument("--start-maximized")
    Wait Until Page Contains    SeleniumBase

Check hover dropdown option and verify
    Select hover dropdown option and verify    ${DROPDOWN_LINK_1}    Link One Selected
    Select hover dropdown option and verify    ${DROPDOWN_LINK_2}    Link Two Selected
    Select hover dropdown option and verify    ${DROPDOWN_LINK_3}    Link Three Selected

Select hover dropdown option and verify
    [Arguments]    ${DROPDOWN_LINK}    ${OUTPUT}
    Mouse Over    ${HOVER_DROPDOWN}
    Wait Until Element Is Visible    ${DROPDOWN_LINK}
    Click Element    ${DROPDOWN_LINK}
    Wait Until Element Contains    ${DROPDOWN_OUTPUT}    ${OUTPUT}

Check text input field and verify
    Input text and verify    ${TEXT_INPUT}    This is a sample text.

Check text area and verify
    Input text and verify    ${TEXT_AREA}    This is a sample text for the text area.

Input text and verify
    [Arguments]    ${TEXT_FIELD}    ${INPUT_TEXT}
    Input Text    ${TEXT_FIELD}    ${INPUT_TEXT}
    ${TEXT}=    Get Value    ${TEXT_FIELD}
    Should Be Equal    ${TEXT}    ${INPUT_TEXT}

Verify pre-filled text
    ${TEXT}=    Get Value    ${PRE_FILLED_TEXT}
    Should Be Equal    ${TEXT}    Text...
    Input Text    ${PRE_FILLED_TEXT}    Hello World!

Verify placeholder disappears on typing
    ${BEFORE_TEXT}=    Get Element Attribute    ${PLACEHOLDER}    placeholder
    Should Be Equal    ${BEFORE_TEXT}    Placeholder Text Field
    Input Text    ${PLACEHOLDER}    HELLO WORLD
    ${AFTER_TEXT}=    Get Value    ${PLACEHOLDER}
    Should Be Equal    ${AFTER_TEXT}    HELLO WORLD

Verify button color before and after click
    ${INITIAL_COLOR}=    Get Element Attribute    ${BUTTON}    style
    Should Contain    ${INITIAL_COLOR}    color: green
    Click Button    ${BUTTON}
    ${NEW_COLOR}=    Get Element Attribute    ${BUTTON}    style
    Should Contain    ${NEW_COLOR}    color: purple

Verify read-only text field
    ${READONLY}=    Get Element Attribute    ${READONLY_FIELD}    readonly
    Should Not Be Empty    ${READONLY}
    ${TEXT}=    Get Value    ${READONLY_FIELD}
    Should Be Equal    ${TEXT}    The Color is Purple

Verify paragraph with text
    ${TEXT}=    Get Text    ${PARAGRAPH}
    Should Be Equal    ${TEXT}    This Text is Purple
    ${STYLE}=    Get Element Attribute    ${PARAGRAPH}    style
    Should Contain    ${STYLE}    color: purple

Check svg animation and color
    Click Element    ${SVG}
    Sleep    2
    ${ANIMATION_STATE}=    Execute JavaScript    return window.getComputedStyle(document.querySelector('svg rect')).animationPlayState
    Should Be Equal    ${ANIMATION_STATE}    running
    Verify animation color

Verify animation color
    ${FILL_COLOR}=    Get Element Attribute    ${SVG}    fill
    Should Be Equal    "${FILL_COLOR}"    "#4CA0A0"

Move slider
    ${SLIDER_BAR}=    Get element width    ${SLIDER}
    ${SLIDER_VAL}=    Evaluate    ${SLIDER_BAR} / 100
    ${SLIDER_VALUE}=    Evaluate    ${SLIDER_VAL} * ${SLIDER_INPUT}
    ${SLIDER_HALF}=    Evaluate    ${SLIDER_BAR} / 2
    Move slider by input value    ${SLIDER_VALUE}    ${SLIDER_HALF}

Move slider by input value
    [Arguments]    ${SLIDER_VALUE}    ${SLIDER_HALF}
    ${X}=    Evaluate    ${SLIDER_VALUE} - ${SLIDER_HALF}
    ${X}=    Convert To Number    ${X}    0
    Drag And Drop By Offset    ${SLIDER}    ${X}    0
    Sleep    2

Check progress bar
    ${TEXT}=    Get Text    ${PROGRESS_TEXT}
    Should Contain    ${TEXT}    ${SLIDER_INPUT}%
    ${VALUE}=    Get Element Attribute    ${PROGRESS_BAR}    value
    Should Be Equal    ${VALUE}    ${SLIDER_INPUT}
    Log progress bar value    ${TEXT}

Log progress bar value
    [Arguments]    ${TEXT}
    ${PROGRESS}=    Set Variable    <h2>${TEXT}</h2>
    Log    ${PROGRESS}    html=True

Select dropdown value and check meter
    Select From List By Label    ${DROPDOWN}    Set to ${DROPDOWN_VALUE}%
    ${TEXT}=    Get Text    ${METER_TEXT}
    Should Contain    ${TEXT}    ${DROPDOWN_VALUE}%
    Check Meter    ${TEXT}

Check Meter
    [Arguments]    ${TEXT}
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
    ${CHECKED}=    Get Element Attribute    ${RADIO_BUTTON_1}    checked
    Should Not Be Equal    ${CHECKED}    true

Select checkbox and drag n drop the image
    Select Checkbox    ${CHECKBOX}
    Wait Until Element Is Visible    ${DRAG_IMAGE}
    Drag And Drop    ${DRAG_IMAGE}    ${DROP_B}
    Verify drop-A and drop-B

Verify drop-A and drop-B
    Page Should Contain Element    ${DROP_B_IMG}
    Capture Element Screenshot    ${HIDDEN_ROW}
    Page Should Not Contain Element    ${DROP_A_IMG}

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

Check url link and verify
    Click url and check output    ${URL_LINK_1}    Web Automation & Testing with Python
    Click url and check output    ${URL_LINK_2}    SeleniumBase Docs

Click url and check output
    [Arguments]    ${URL_LINK}    ${VERIFY_TEXT}
    Page Should Contain Link    ${URL_LINK}
    Click Link    ${URL_LINK}
    Wait Until Page Contains    ${VERIFY_TEXT}
    Go back after screenshot

Go back after screenshot
    Sleep    2
    Capture Page Screenshot
    Go Back
    Sleep    1

Check link with text
    Click link with text and verify    ${LINK_TEXT_1}    SeleniumBase on GitHub    github.com/seleniumbase/SeleniumBase    ${GITHUB_ICON}
    Go Back
    Sleep    1
    Capture Page Screenshot
    Click link with text and verify    ${LINK_TEXT_2}    SeleniumBase Demo Page    https://seleniumbase.io/demo_page    ${DEMO_PAGE}

Click link with text and verify
    [Arguments]    ${LINK_TEXT}    ${LINK_NAME}    ${EXPECTED_URL}    ${EXPECTED_ELEMENT}
    ${TEXT}=    Get Text    ${LINK_TEXT}
    Should Be Equal    ${TEXT}    ${LINK_NAME}
    Click Link    ${TEXT}
    Capture screenshot after verify the current location    ${EXPECTED_URL}    ${EXPECTED_ELEMENT}

Capture screenshot after verify the current location
    [Arguments]    ${EXPECTED_URL}    ${EXPECTED_ELEMENT}
    ${CURRENT_URL}=    Get Location
    Should Contain    ${CURRENT_URL}    ${EXPECTED_URL}
    Wait Until Page Contains Element        ${EXPECTED_ELEMENT}
    Sleep    2
    Capture Page Screenshot

Get element width
    [Arguments]    ${ELEMENT_DIV}
    ${X}     ${Y}=    Get Element Size    ${ELEMENT_DIV}
    ${X}=    Convert To Number    ${X}    0
    RETURN    ${X}
