﻿# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb8310


@tree


Функционал: Нажатие команды интерфейса в открытом окне

Как Разработчик я хочу
Чтобы у меня был функционал для нажатия команды интерфейса в открытом окне при работе с TestClient
Для того чтобы использовать эти команды



Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий
	
	
	
Сценарий: Я нажмаю команду интерфейса в открытом окне
	Когда В панели разделов я выбираю "Основная"
	И     В панели функций я выбираю "Справочник1"
	Тогда открылось окно "Справочник1"
	И     В открытой форме я нажимаю на кнопку с заголовком "Создать"
	Тогда открылось окно "Справочник1 (создание)"
	И     В открытой форме в поле с именем "Наименование" я ввожу текст "Тест"
	И     В текущем окне я нажимаю кнопку командного интерфейса "Общая команда для справочника1"
	Если версия платформы "<=" "8.3.9.10000" Тогда
		И     В текущем окне я нажимаю кнопку командного интерфейса "Главное"
		
	#В 8.3.10 поведение исправили	
	Если версия платформы ">=" "8.3.10" Тогда
		И     В текущем окне я нажимаю кнопку командного интерфейса "Основное"	
		
	И     В открытой форме я нажимаю на кнопку с заголовком "Записать и закрыть"
