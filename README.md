# Practice Automation Test Suite

This repository contains a Robot Framework test suite for automating web-based interactions using the SeleniumLibrary. The tests are designed to demonstrate and validate interactions with various elements on a demo website.

## Features

- Automates interactions with sliders, SVG elements, progress bars, and more.
- Uses variables for easy customization of test parameters.
- Includes setup and teardown procedures to manage browser sessions.

## Prerequisites

To run this test suite, ensure you have the following installed:

1. [Python](https://www.python.org/downloads/) (3.6 or later)
2. [pip](https://pip.pypa.io/en/stable/installation/)
3. [Robot Framework](https://robotframework.org/)
4. [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/)
5. A compatible web driver (e.g., ChromeDriver or GeckoDriver) added to your PATH

## Installation

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Create and activate a virtual environment (optional but recommended):

   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. Install the required Python libraries:

   ```bash
   pip install -r requirements.txt
   ```

   Ensure that `requirements.txt` contains:

   ```
   robotframework
   robotframework-seleniumlibrary
   ```

## File Overview

- **`demo.robot`**: The main Robot Framework test suite containing:
  - **Settings**: Documentation, imported libraries, and suite-level setup/teardown.
  - **Variables**: Common variables for site URLs, element locators, and test parameters.
  - **Test Cases**: Automated test scenarios for validating web-based interactions.

## How to Run the Tests

1. Navigate to the directory containing the `demo.robot` file.
2. Execute the test suite using the Robot Framework:

   ```bash
   robot demo.robot
   ```

3. View the generated `log.html` and `report.html` files for detailed test results.

## Test Cases

### Test svg color

- Tags: `svg`
- Validates the color property of an SVG element.

### Additional Tests

- Tests for sliders, progress bars, and other interactive elements.

## Suite Setup and Teardown

- **Setup**: Initializes the test environment and opens the browser.
- **Teardown**: Closes all browser sessions at the end of the suite.

## References

- [Robot Framework Documentation](https://robotframework.org/)
- [SeleniumLibrary Documentation](https://robotframework.org/SeleniumLibrary/)
- [Demo Website](https://seleniumbase.io/demo_page/)

## Contributing

Feel free to fork this repository, submit issues, or create pull requests for any enhancements or bug fixes.
