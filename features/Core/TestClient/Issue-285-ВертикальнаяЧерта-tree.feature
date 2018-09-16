# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb



Функционал: Проверка парсинга фичи с тегом tree когда есть вертикальная черта

Как разработчик
Я хочу чтобы корректно происходил парсинг фичи с включенным тегом tree, когда используется вертикальная черта в шагах
Чтобы я мог иcпользовать этот тег в своих фичах

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий


Сценарий: Проверка парсинга фичи с тегом tree когда есть вертикальная черта
	Когда Я открываю VanessaBehavior в режиме TestClient
	И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ФичаДляПроверкиРаботыВертикальнойЧерты_Тег_tree"
	И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Behavior TestClient
	И     таблица формы с именем "ДеревоТестов" стала равной:
		| 'Наименование'                                                                | 
		| 'ФичаДляПроверкиРаботыВертикальнойЧерты_Тег_tree.feature'                     |
		| 'Тестовая фича, для проверки работы тега tree, когда есть вертикальная черта' |
		| 'Тестовая фича, для проверки работы тега tree, когда есть вертикальная черта' |
		| 'Когда Шаг один'                                                              |
		| 'И Шаг два'                                                                   |
	
	