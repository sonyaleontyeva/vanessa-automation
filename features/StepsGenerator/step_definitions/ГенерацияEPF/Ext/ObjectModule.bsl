﻿Перем Ванесса;

Функция ДобавитьШагВМассивТестов(МассивТестов,Снипет,ИмяПроцедуры,ПредставлениеТеста = Неопределено,Транзакция = Неопределено,Параметр = Неопределено)
	Структура = Новый Структура;
	Структура.Вставить("Снипет",Снипет);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ИмяПроцедуры",ИмяПроцедуры);
	Структура.Вставить("ПредставлениеТеста",ПредставлениеТеста);
	Структура.Вставить("Транзакция",Транзакция);
	Структура.Вставить("Параметр",Параметр);
	МассивТестов.Добавить(Структура);
КонецФункции

Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	ДобавитьШагВМассивТестов(ВсеТесты,"ЯПерешелНаЗакладкуГенераторEPF()","ЯПерешелНаЗакладкуГенераторEPF","И я перешел на закладку генератор EPF");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЕслиОжидаемыйФайлEpfУжеСуществуетТоОнБудетУдален()","ЕслиОжидаемыйФайлEpfУжеСуществуетТоОнБудетУдален","И если ожидаемый файл epf уже существует, то он будет удален");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯНажалНаКнопку(Парам01)","ЯНажалНаКнопку","И я нажал на кнопку ""СоздатьШаблоныОбработок""");
	ДобавитьШагВМассивТестов(ВсеТесты,"ЯПолучилСгенерированныйEpfФайлВОжидаемомКаталоге()","ЯПолучилСгенерированныйEpfФайлВОжидаемомКаталоге","Тогда я получил сгенерированный epf файл в ожидаемом каталоге");
	ДобавитьШагВМассивТестов(ВсеТесты,"СгенерированныйEpfПрошелПроверкуНаКорректность()","СгенерированныйEpfПрошелПроверкуНаКорректность","И сгенерированный epf прошел проверку на корректность");
	ДобавитьШагВМассивТестов(ВсеТесты,"СгенерированныйEpfЗнакМинусВСценарииПрошелПроверкуНаКорректность()","СгенерированныйEpfЗнакМинусВСценарииПрошелПроверкуНаКорректность","И сгенерированный epf ЗнакМинусВСценарии прошел проверку на корректность");

	Возврат ВсеТесты;
КонецФункции

Процедура ПередНачаломСценария() Экспорт
КонецПроцедуры

Процедура ПередОкончаниемСценария() Экспорт
	ИмяОжидаемогоФайла = Контекст.ИмяОжидаемогоФайла;
	Файл = Новый Файл(ИмяОжидаемогоФайла);
	Если Файл.Существует() Тогда
		Ванесса.ПолучитьФорму("Форма").СделатьСообщение("ПередОкончаниемСценария(). Удаляю файл " + ИмяОжидаемогоФайла);
		УдалитьФайлы(ИмяОжидаемогоФайла);
	КонецЕсли;  
	
	Если Контекст.Свойство("ОткрытаяФормаVanessaBehavoir") Тогда
		Если Контекст.ОткрытаяФормаVanessaBehavoir.Открыта() Тогда
			Контекст.ОткрытаяФормаVanessaBehavoir.Закрыть();
		КонецЕсли;  
		
	КонецЕсли;  
	
КонецПроцедуры


//я перешел на закладку генератор EPF
//@ЯПерешелНаЗакладкуГенераторEPF()
Процедура ЯПерешелНаЗакладкуГенераторEPF() Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	ОткрытаяФормаVanessaBehavoir.ЭлементыФормы.пЗапускСценариев.ТекущаяСтраница = ОткрытаяФормаVanessaBehavoir.ЭлементыФормы.пЗапускСценариев.Страницы.СтраницаГенераторEPF;
КонецПроцедуры

//ожидаемый файл epf уже существует, то он будет удален
//@ЕслиОжидаемыйФайлEpfУжеСуществуетТоОнБудетУдален()
Процедура ЕслиОжидаемыйФайлEpfУжеСуществуетТоОнБудетУдален() Экспорт
	ИмяОжидаемогоФайла = Контекст.ОткрытаяФормаVanessaBehavoir.КаталогИнструментов + "\features\Support\Templates\step_definitions\" + Контекст.ИмяТестовойФичи + ".epf";
	Контекст.Вставить("ИмяОжидаемогоФайла",ИмяОжидаемогоФайла);
	
	ИмяОжидаемогоФайла = Контекст.ИмяОжидаемогоФайла;
	Файл = Новый Файл(ИмяОжидаемогоФайла);
	Если Файл.Существует() Тогда
		ТекстСообщения = "Удаляю файл %1";
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ИмяОжидаемогоФайла);
		Сообщить(ТекстСообщения);
		УдалитьФайлы(ИмяОжидаемогоФайла);
	КонецЕсли;  
	
	Контекст.Вставить("ИмяОжидаемогоФайла",ИмяОжидаемогоФайла);
	
КонецПроцедуры


//я нажал на кнопку "СоздатьШаблоныОбработок"
//@ЯНажалНаКнопку(Парам01Строка)
Процедура ЯНажалНаКнопку(ИмяКнопки) Экспорт
	ОткрытаяФормаVanessaBehavoir = Контекст.ОткрытаяФормаVanessaBehavoir;
	
	Если ИмяКнопки = "СоздатьШаблоныОбработок" Тогда
		ОткрытаяФормаVanessaBehavoir.СоздатьШаблоныОбработок();
	Иначе
		ТекстСообщения = "Не смог обработать нажатие кнопки: %1";
		ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",ИмяКнопки);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;  
	
КонецПроцедуры

//я получил сгенерированный epf файл в ожидаемом каталоге
//@ЯПолучилСгенерированныйEpfФайлВОжидаемомКаталоге()
Процедура ЯПолучилСгенерированныйEpfФайлВОжидаемомКаталоге() Экспорт
	ИмяОжидаемогоФайла = Контекст.ИмяОжидаемогоФайла;
	Файл = Новый Файл(ИмяОжидаемогоФайла);
	Ванесса.ПроверитьРавенство(Файл.Существует(),Истина,"Был создан epf в нужном каталоге");
	
КонецПроцедуры

//сгенерированный epf прошел проверку на корректность
//@СгенерированныйEpfПрошелПроверкуНаКорректность()
Процедура СгенерированныйEpfПрошелПроверкуНаКорректность() Экспорт
	ИмяОжидаемогоФайла = Контекст.ИмяОжидаемогоФайла;
	СозданнаяОбработка = ВнешниеОбработки.Создать(ИмяОжидаемогоФайла);
	
	//должна быть эта процедура, и она должна быть без параметров
	Попытка
		СозданнаяОбработка.ФичаСодержитСтрокуСТочкойВКонце();
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		Если Найти(ОписаниеОшибки,"Не реализовано.") = 0 Тогда
			ТекстСообщения = "Не верно сгенерировалась epf. ФичаСодержитСтрокуСТочкойВКонце.%1";
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Символы.ПС + ОписаниеОшибки);
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;  
	КонецПопытки;
	
	Попытка
		СозданнаяОбработка.ФичаСодержитЧислоИЗапятуюПослеНего(10);
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		Если Найти(ОписаниеОшибки,"Не реализовано.") = 0 Тогда
			ТекстСообщения = "Не верно сгенерировалась epf. ФичаСодержитЧислоИЗапятуюПослеНего().%1";
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Символы.ПС + ОписаниеОшибки);
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;  
	КонецПопытки;
	
	Попытка
		СозданнаяОбработка.УстанавливаетсяПустойМок_ВСистемуТестирования();
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		Если Найти(ОписаниеОшибки,"Не реализовано.") = 0 Тогда
			ТекстСообщения = "Не верно сгенерировалась epf. УстанавливаетсяПустойМок_ВСистемуТестирования()%1";
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Символы.ПС + ОписаниеОшибки);
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;  
	КонецПопытки;
	
КонецПроцедуры

//И сгенерированный epf ЗнакМинусВСценарии прошел проверку на корректность
//@СгенерированныйEpfЗнакМинусВСценарииПрошелПроверкуНаКорректность()
Процедура СгенерированныйEpfЗнакМинусВСценарииПрошелПроверкуНаКорректность() Экспорт
	ИмяОжидаемогоФайла = Контекст.ИмяОжидаемогоФайла;
	СозданнаяОбработка = ВнешниеОбработки.Создать(ИмяОжидаемогоФайла);
КонецПроцедуры
