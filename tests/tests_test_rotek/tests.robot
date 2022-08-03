*** Settings ***
Documentation   Tests test Rotek.
# Подключаем файл с основными переменными и ключевыми словами из папки ${EXECDIR}${/}resources/.
Resource        ../../resources/functional_tests/resources.robot    # Ключевые слова, для данных автотестов.
# Прописываем примерные default-теги, для запуска данного теста(ов), в каких-либо тестовых наборах.
Default Tags    Smoke  Regression  Sanitaze  No_parallel
Test Setup      Open browser on the page      ${url_ui}      ${browser}  # Открываем браузер на странице переводчика google. Определяем тип браузера в котором будет произв. проверка. Прописывается в аргум. запуска: --variable BROWSER:chrome.
Test Teardown   Finish the test     # Заканчиваем тест и закрываем браузер.




*** Test Cases ***
# Пишем ОСНОВНОЙ СЦЕНАРИЙ в тест-кейсе, для данного теста по проверке переводчика Google.
Проверить переводчик google
    [Tags]              Проверка работы переводчика google      Regression
    # Создаем переменную состоящую из базового url страницы переводчика и параметра 'sl=auto'.
    # Данную переменную можно передавать в 'Check google translate', для корректного отрабатывания данного кейворда,
    # если он будет вызываться неоднократно, с разными значениями во втором и третьем аргументах.
    ${url_auto} =	Catenate	SEPARATOR=	${url_ui}	?sl=auto
    # Основное ключевое слово, для данного тест-кейса.
     Check google translate        ${url_auto}    ${incorrect_word}   ${right_english_word}


*** Keywords ***
# КЛЮЧЕВЫЕ СЛОВА, по проверке работы переводчика google.

Check google translate
    [Arguments]     ${url}    ${incorrect_word}   ${right_english_word}

    # Создаем переменную с текстом ошибки, если проверка в данном ключевом слове не отработала. Для отправления этого текста в слак.
    Set Suite Variable      ${text_message}    на страничке не отработали 1 или 2 проверки.


    # Вводим в поле слева, для перевода - английское слово "World" с неверной раскладкой.
    Wait until Page Contains Element	${field_for_enter_text_for_translate}
    Press Keys      xpath: ${field_for_enter_text_for_translate}        ${incorrect_word}

    # Т.к. при вводе текста выше, неправильно определяется язык(как монгольский), то вручную переключаемся на таб, для ввода английских слов.
    Wait until Page Contains Element	${button_choice_english_tab}
    Click Element   xpath: ${button_choice_english_tab}

    # Проверяем, что на странице появилась подсказка - "Возможно, вы имели в виду: ".
    Wait until Page Contains Element	${link_did_you_mean}
    Page Should Contain     Возможно, вы имели в виду:
    log to console      На странице появилась подсказка - "Возможно, вы имели в виду: ".

    # Нажимаем на ссылку "world", в тексте появившейся подсказки.
    Click Element   xpath: ${link_did_you_mean}

    # Получаем переведенный текст из поля справа и сравниваем его с ожидаемым из переменной ${right_english_word}.
    # Делаем небольшую паузу, чтобы произошел перевод.
    sleep  3
    ${translated_text_from_box_on_right} =      Get Text    ${field_with_translation}
    Should be equal    ${translated_text_from_box_on_right}     ${right_english_word}      msg=Текст в поле справа отличается от слова "Мир"!
    log to console     Переведенный текст из поля справа, равен ожидаемому, переданному в аргументах запуска теста.

    Go to   ${url}

    # Если данное ключевое слово отработало без ошибок, создаем переменную ${success} со значением True, для продолжения тестов.
    # Можно использовать, если тест-кейсов в наборе, больше одного и они связаны одним сценарием.
    ${success} =    Set Variable    True
    [Return]    ${success}




