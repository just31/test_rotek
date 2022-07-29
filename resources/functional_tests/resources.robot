# Данный файл с ресурсами объединяет 2 вида автотестов: ui и api. Чтобы показать в тестовом, сразу два вида автотестов.
# В идеале конечно нужно разделять эти два вида автотестов, на 2 файла ресурсов.

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
# Подключаем общие для всех тестов, page object переменные.
Variables       ${EXECDIR}${/}page_objects/Elements.py

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
    [Teardown]    Close Browser
    Sleep   2
















