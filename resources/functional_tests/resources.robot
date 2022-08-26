# Список общих ключевых слов (кейвордсов). Для различных тестов.

# Подключаем возможные необходимые, для работы библиотеки.
*** Settings ***
Documentation   Keywords for check work buttons
Library         SeleniumLibrary
Library         Collections
Library         DateTime
Library         String
Library	        Screenshot
Library         RequestsLibrary
Library         DateTime
Library         String
Library         ../../Library/SeleniumLibraryHelper.py
# Подключаем общие для всех тестов, page-object переменные. И переменные с входными данными, для различных тестов.
Variables       ${EXECDIR}${/}variables/Elements.py
Variables       ${EXECDIR}${/}variables/Variables.py

*** Variables ***
# Создаем переменную базового url, для данного теста.
${url_ui}      https://translate.google.com/
${SELENOID_SERVER}      http://localhost:4444/wd/hub/
&{selenoid:options}         enableVNC=${True}       enableVideo=${False}
&{desired_caps}    selenoid:options=&{selenoid:options}      screenResolution=1920x1080x24        acceptInsecureCerts = true


*** Keywords ***
#---ОБЩИЕ КЛЮЧЕВЫЕ СЛОВА, ДЛЯ РАЗЛИЧНЫХ ТЕСТОВ.----#

# UI:
# Открываем браузер.
Open browser on the page
    [Arguments]     ${url}      ${type_browsers}
    # Open Browser    ${url}      browser=${type_browsers}
    Open Browser    ${url}      ${type_browsers}      remote_url=${SELENOID_SERVER}     desired_capabilities=&{desired_caps}
    #Set Window Size     1600	900
    Maximize Browser Window
    Set Suite Variable     ${name_browsers}    ${type_browsers}

# Завершаем тест
Finish the test
    # Закрываем браузер и завершаем тест.
    Close Browser
    Sleep   2
















