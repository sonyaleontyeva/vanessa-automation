# language: ru

@IgnoreOn82Builds
@IgnoreOnOFBuilds
@IgnoreOnWeb

@tree


Функциональность: Проверка обработки модального диалога при возникновении ошибки
	Когда возникает модальный диалог, надо попытаться нажать на кнопку ОК
	И снять второй скриншот


	
Сценарий: Проверка обработки модального диалога при возникновении ошибки
	Дано Я закрыл все окна клиентского приложения
	И я закрываю сеанс TESTCLIENT
	Когда я запускаю служебный сеанс TestClient с ключом TestManager в той же базе
	Дано    Я закрыл все окна клиентского приложения

	Когда Я открываю VanessaBehavior в режиме TestClient со стандартной библиотекой
	
	И я перехожу к закладке "Сервис"
	И я перехожу к закладке "Отчет о запуске сценариев"
	И я устанавливаю флаг 'Формировать скриншот при ошибке'
	И в поле каталог скриншотов я указываю путь к относительному каталогу "tools\ScreenShotsTest"
	И я запоминаю значение поля с именем "КаталогOutputСкриншоты" как "КаталогOutputСкриншоты"
	И я очищаю каталог "$КаталогOutputСкриншоты$"
	И я перехожу к закладке "Автоинструкции"
	И В открытой форме в поле "Консольная команда создания скриншотов" я ввожу команду для IrfanView 
	И я перехожу к закладке "Основные"
	И я перехожу к закладке "Запуск сценариев"
	
	И я загружаю служебную фичу и устанавливаю настройки
			И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ФичаПроверкаСнятияСкриншотаМодальныйДиалог"
			И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Behavior TestClient
			И Я нажимаю на кнопку выполнить сценарии в Vanessa-Behavior TestClient
			
	И в каталоге скриншотов появилось 2 файла
	
	
Сценарий: Закрыть TestClient, который был открыт из второго TestManager. ППроверка обработки модального диалога при возникновении ошибки.
	Когда я запускаю служебный сеанс TestClient с ключом TestManager в той же базе
	Дано Я закрыл все окна клиентского приложения кроме "*Vanessa Automation"
	И я загружаю служебную фичу и устанавливаю настройки
			И В поле с именем "КаталогФичСлужебный" я указываю путь к служебной фиче "ЗакрытьПодключенныйTestClient"
			И Я нажимаю на кнопку перезагрузить сценарии в Vanessa-Behavior TestClient
			И Я нажимаю на кнопку выполнить сценарии в Vanessa-Behavior TestClient
			И у элемента "Сценарии выполнены" я жду значения "Да" в течение 20 секунд
	И я закрываю TestClient "TM"	