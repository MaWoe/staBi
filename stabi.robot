*** Settings ***
Library  Selenium2Library
Library  OperatingSystem
Resource  userAccounts.robot
Suite Teardown  Close Browser

*** Test Cases ***

Test
  Log To Console  Calling login for user "${USER_NAME}"
  ${account}=  Set Variable  &{accounts}[${USER_NAME}]
  Login  @{account}
  Get List Of Borrowed Books

*** Keywords ***

Get List Of Borrowed Books
  Wait For Element And Click
  ...  xpath://a[text() = "Konto"]
  
  Wait For Element And Click
  ...  xpath://li//*[starts-with(text(), "Ausleihen")]
  
  Wait Until Page Contains Element
  ...  xpath://*[@id="tab-content"]//div[contains(@class, "box-header")]//h2[text() = "Ausleihen"]
  
  ${src}=  Get Source
  OperatingSystem.Create File  ${OUTPUT_DIR}/source.html  ${src}
  
Login

  [Arguments]  ${userId}  ${password}
  
  Open Browser
  ...  url=https://katalog.stadtbibliothek.freiburg.de/
  ...  browser=Chrome
  
  Wait For Element And Click
  ...  xpath://*[@id="login"]/a
  
  Wait Until Page Contains Element
  ...  xpath://*[@id="Kennung"]
  
  Input Text
  ...  xpath://*[@id="Kennung"]
  ...  text=${userId}
  
  Input Password
  ...  xpath://*[@id="password"]
  ...  password=${password}
  
  Click Button
  ...  xpath://*[@id="LoginBean"]/div/div/fieldset/table/tbody/tr[3]/td/input
  
  Wait Until Page Contains  Benutzernummer
  Wait Until Page Contains  ${userId}
  
  Log To Console  Successfully logged in

Open Browser

    [Arguments]
    ...  ${url}
    ...  ${browser}
    ...  ${alias}=None
    ...  ${remote_url}=False
    ...  ${desired_capabilities}=None
    ...  ${ff_profile_dir}=None

    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  headless
    ${options}=  Call Method  ${options}  to_capabilities

    Create WebDriver
    ...  driver_name=Chrome
    ...  alias=${alias}
    ...  desired_capabilities=${options}

    Go To  ${url}
  
Wait For Element And Click

  [Arguments]  ${locator}

  Wait Until Page Contains Element
  ...  ${locator}

  Click Element
  ...  ${locator}

