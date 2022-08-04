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
Variables       ${EXECDIR}${/}page_objects/Elements.py
Variables       ${EXECDIR}${/}page_objects/Variables.py

*** Variables ***
# Создаем переменную базового url, для данного теста.
${url_ui}      https://translate.google.com/


*** Keywords ***
#---ОБЩИЕ КЛЮЧЕВЫЕ СЛОВА, ДЛЯ РАЗЛИЧНЫХ ТЕСТОВ.----#

# UI:
# Открываем браузер.
Open browser on the page
    [Arguments]     ${url}      ${type_browsers}
    Open Browser    ${url}      browser=${type_browsers}
    #Set Window Size     1600	900
    Maximize Browser Window
    Set Suite Variable     ${name_browsers}    ${type_browsers}

# Завершаем тест
Finish the test
    # Закрываем браузер и завершаем тест.
    Close Browser
    Sleep   2
















