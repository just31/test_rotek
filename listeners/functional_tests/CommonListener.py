import logging

from robot.libraries.BuiltIn import BuiltIn

# Импортируем все необходимые функции из вспомогательного модуля utils:
import sys

sys.path.append("listeners/")
from utils import *

logger = logging.getLogger(__name__)


# Формируем класс, для общего листенера, по функциональным тестам.
class CommonListener(object):
    ROBOT_LISTENER_API_VERSION = 3

    # В конструкторе класса, можем принимать различные переменные, переданные в аргументах запуска 'args'.
    # Передаем в аргументах запуска: ["<английское слово с неверной раскладкой>", <правильный перевод слова>"].
    def __init__(self, args):
        self.ROBOT_LIBRARY_LISTENER = self

        # Получаем список аргументов, переданных из командной строки.
        self.parametrs = args.split(':')

    # Метод запускаюшщий прогон тест-сьюита по всем тестам папки tests_test_rotek.
    def start_suite(self, suite, result):
        suite.doc = 'АВТОМАТИЗАЦИЯ ТЕСТОВ ROTEK.'

        # Создаем для сьюита robot-переменные: английского слова с неверной раскладкой и правильного перевода слова, из списка выше.
        BuiltIn().set_suite_variable("${incorrect_word}", self.parametrs[0])
        BuiltIn().set_suite_variable("${right_english_word}", self.parametrs[1])

    # Метод отлавливающий ошибки, в прохожении всех тест-кейсов. И формирующий текст для сообщения в слак, по ним.
    # Также здесь формируем на лету скриншот для allure, в случае не прохождения теста(ов).
    def log_message(self, msg):
        if msg.level == 'FAIL' and not msg.html:
            msg.html = True

            self.msg_level = msg.level

            # Получаем скриншот страницы, где не прошел тест. Для вывода его в аллюре-отчетности.
            s2l = BuiltIn().get_library_instance('SeleniumLibrary')
            s2l.capture_page_screenshot()
            s2l.close_browser()

            # Получаем переменные с текстом ошибки, для отравления его в слак. И с url странички.
            text_message = BuiltIn().get_variable_value('${text_message}')
            url = BuiltIn().get_variable_value('${url}')

            # Вызываем функцию, формирующую текст для слака.
            message_text_formation(url, text_message)

    # Метод вызывающийся в конце всего тестового прогона.
    # Его можно использовать в тестах, в которых необходимо совершать какие либо действия, после прогона всего тестового набора.
    def close(self):
        pass
