﻿&НаКлиенте
Перем Ванесса;

#Область ЭкспортныеПроцедурыИФункции

&НаКлиенте
Процедура ЗапуститьSikuliXСевер(ВанессаФорма,ДопПараметры) Экспорт
	Ванесса = ВанессаФорма;
	
	КаталогиСкриптовSikuliX = Ванесса.Объект.КаталогиСкриптовSikuliX;
	Если НЕ ЗначениеЗаполнено(КаталогиСкриптовSikuliX) Тогда
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не указано значение настройки Vanessa-automation: <КаталогиСкриптовSikuliX>.");
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
	Если Найти(КаталогиСкриптовSikuliX,";") > 0 Тогда
		МассивКаталоговДляОбработки = СтрРазделить(КаталогиСкриптовSikuliX,";");
	Иначе	
		МассивКаталоговДляОбработки = Новый Массив;
		МассивКаталоговДляОбработки.Добавить(КаталогиСкриптовSikuliX);
	КонецЕсли;	 
	
	
	
	ИмяСобранногоСкрипта = "SikuliXServer";
	
	КаталогНовогоСкрипта = МассивКаталоговДляОбработки[0] + ПолучитьРазделительПути() + ИмяСобранногоСкрипта + ".sikuli";
	СоздатьКаталог(КаталогНовогоСкрипта);
	ОчиститьКаталог(КаталогНовогоСкрипта);
	
	ДанныеСкриптов    = Новый Массив;
	ОбщаяСекцияИмпорт = Новый Массив;
	ОбщаяСекцияИмпорт.Добавить("import os");
	ОбщаяСекцияИмпорт.Добавить("import os.path");
	ОбщаяСекцияИмпорт.Добавить("import shutil");
	ОбщаяСекцияИмпорт.Добавить("import json");
	
	
	Для Каждого ТекКаталогСкриптовДляОбработки Из МассивКаталоговДляОбработки Цикл
		Если НЕ ЗначениеЗаполнено(ТекКаталогСкриптовДляОбработки) Тогда
			Продолжить;
		КонецЕсли;	 
		
		Файлы = НайтиФайлы(ТекКаталогСкриптовДляОбработки,"*.sikuli",Истина);
		Для Каждого ФайлКаталогСкрипта Из Файлы Цикл
			Если НРег(ФайлКаталогСкрипта.ПолноеИмя) = НРег(КаталогНовогоСкрипта) Тогда
				Продолжить;
			КонецЕсли;	 
			
			ДанныеСкрипта = ДанныеСкрипта(ФайлКаталогСкрипта.ПолноеИмя,ОбщаяСекцияИмпорт);
			Если ДанныеСкрипта.ТелоСкрипта.Количество() > 0 Тогда
				ДанныеСкриптов.Добавить(ДанныеСкрипта);
			КонецЕсли;	 
		КонецЦикла;	
		
	КонецЦикла;	 
	
	
	ИмяФайлаСкрипта = КаталогНовогоСкрипта + ПолучитьРазделительПути() + ИмяСобранногоСкрипта + ".py";
	ЗТ = Новый ЗаписьТекста(ИмяФайлаСкрипта, "Windows-1251", , Ложь); 
	ЗТ.Закрыть();//убираю BOM
	
	ТекстСкрипта = Новый ЗаписьТекста(ИмяФайлаСкрипта, "UTF-8", , Истина); 
	СтрокаСкрипта0 = "";
	Для Каждого СтрокаСекцияИмпорт Из ОбщаяСекцияИмпорт Цикл
		СтрокаСкрипта0 = СтрокаСкрипта0 + СтрокаСекцияИмпорт + Символы.ПС;
	КонецЦикла;	 
	СтрокаСкрипта0 = СтрокаСкрипта0 + Символы.ПС;
	ТекстСкрипта.ЗаписатьСтроку(СтрокаСкрипта0);
	
	СтрокаСкриптаСлужебнаяЧасть = "
	|sys_argv_1 = ''
	|sys_argv_2 = ''
	|sys_argv_3 = ''
	|sys_argv_4 = ''
	|sys_argv_5 = ''
	|
	|def CallError(ScriptName):
	|    pass
	|
	|def read_comand(dataofcomandlocal):
	|    global sys_argv_1
	|    global sys_argv_2
	|    global sys_argv_3
	|    global sys_argv_4
	|    global sys_argv_5
	|    sys_argv_1 = dataofcomandlocal['sys_argv_1']
	|    sys_argv_2 = dataofcomandlocal['sys_argv_2']
	|    sys_argv_3 = dataofcomandlocal['sys_argv_3']
	|    sys_argv_4 = dataofcomandlocal['sys_argv_4']
	|    sys_argv_5 = dataofcomandlocal['sys_argv_5']
	|
	|def DoResponse(response_filename,str):
	|    temp_name = response_filename + ""_temp""
	|    if os.path.exists(temp_name):
	|        os.remove(temp_name)
	|    data = {}  
	|    data['Response'] = str
	|    with open(temp_name, 'w') as outfile:
	|        json.dump(data, outfile)
	|    if os.path.exists(response_filename):
	|        os.remove(response_filename)
	|    shutil.move(temp_name, response_filename)
	|    #oldfile = io.File(response_filename)
	|    #oldfile.renameTo(response_filename)
	|    #os.rename(response_filename, response_filename)
	|    #logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)
	|    #logging.debug(response_filename)
	|
	|";
	ТекстСкрипта.ЗаписатьСтроку(СтрокаСкриптаСлужебнаяЧасть);
	
	
	Для Каждого ДанныеСкрипта Из ДанныеСкриптов Цикл
		СтрокаВставкиСкрипта = "
	|def %1():";
		СтрокаВставкиСкрипта = СтрЗаменить(СтрокаВставкиСкрипта,"%1",ДанныеСкрипта.ИмяСкрипта);
		Для Каждого СтрокаТелоСкрипта Из ДанныеСкрипта.ТелоСкрипта Цикл
			СтрокаВставкиСкрипта = СтрокаВставкиСкрипта + Символы.ПС + "    " + СтрокаТелоСкрипта;
		КонецЦикла;	 
		ТекстСкрипта.ЗаписатьСтроку(СтрокаВставкиСкрипта);
	КонецЦикла;
	
	СтрокаСкрипта1 = "
	|
	|comand_filename   = sys.argv[1]
	|response_filename = sys.argv[2]
	|DoResponse(response_filename,""sikulix server started"")
	|NeetToExit = False
	|
	|while True:
	|    if not os.path.exists(comand_filename):
	|        sleep(1)
	|        continue
	|    
	|    with open(comand_filename) as data_file_comand:    
	|            dataofcomand = json.load(data_file_comand)
	|            comand = dataofcomand['comand']
	|            if comand == ""exit0"":
	|                NeetToExit = True
	|                break
	|
	|";
	
	ТекстСкрипта.ЗаписатьСтроку(СтрокаСкрипта1);
	
	Для Каждого ДанныеСкрипта Из ДанныеСкриптов Цикл
		СтрокаВставкиСкрипта = "
	|            elif comand == ""%1"":
	|                read_comand(dataofcomand)
	|                %1()
	|                DoResponse(response_filename,'success')
	|";
		СтрокаВставкиСкрипта = СтрЗаменить(СтрокаВставкиСкрипта,"%1",ДанныеСкрипта.ИмяСкрипта);
		ТекстСкрипта.ЗаписатьСтроку(СтрокаВставкиСкрипта);
	КонецЦикла;	 
	
	СтрокаСкрипта2 = "
	|
	|    #f.close()
	|    os.remove(comand_filename)
	|        
	|    if NeetToExit:
	|        break
	|            
	|    sleep(1)        
	|
	|
	|exit(0)
	|";
	
	ТекстСкрипта.ЗаписатьСтроку(СтрокаСкрипта2);
	ТекстСкрипта.Закрыть();
	
	ИмяУправляющиегоФайла = ПолучитьИмяВременногоФайла("txt");
	ИмяФайлаОтвета        = ПолучитьИмяВременногоФайла("txt");
	
	СтрокаКоманды = """" + КаталогНовогоСкрипта + """ --args ""%1"" ""%2""";
	СтрокаКоманды = СтрЗаменить(СтрокаКоманды,"%1",ИмяУправляющиегоФайла);
	СтрокаКоманды = СтрЗаменить(СтрокаКоманды,"%2",ИмяФайлаОтвета);
	ОписаниеОшибки = "";
	ДопПараметрыКоманды = Новый Структура;
	ДопПараметрыКоманды.Вставить("СлужебныйВызов",Истина);
	Рез = Ванесса.ВыполнитьSikuliСкрипт(СтрокаКоманды, 0, ,ОписаниеОшибки,ДопПараметрыКоманды);
	
	SikuliXСеверЗапущен = Ложь;
	Если Рез = 0 Тогда
		//надо дожаться файла ответа сервера
		КоличествоСекундОжиданияОтвета = 10;
		Для СчетчикСекунд = 1 По КоличествоСекундОжиданияОтвета Цикл
			Если Ванесса.ФайлСуществуетКомандаСистемы(ИмяФайлаОтвета) Тогда
				Попытка
					Ответ = ПрочитатьФайлОтвета(ИмяФайлаОтвета);
				Исключение
					Ванесса.sleep(1);
					Продолжить;
				КонецПопытки;
				
				Ванесса.УдалитьФайлыКомандаСистемы(ИмяФайлаОтвета);
				
				Если Ответ = "sikulix server started" Тогда
					SikuliXСеверЗапущен = Истина;
					Прервать;
				КонецЕсли;	 
			КонецЕсли;	 
			
			Ванесса.sleep(1);
		КонецЦикла;	
		
	Иначе
		ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не получилось запустить Sikulix сервер.") + Символы.ПС + ОписаниеОшибки;
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;	 
	
	ДопПараметры.Вставить("SikuliXСеверЗапущен",SikuliXСеверЗапущен);
	ДопПараметры.Вставить("ИмяУправляющиегоФайла",ИмяУправляющиегоФайла);
	ДопПараметры.Вставить("ИмяФайлаОтвета",ИмяФайлаОтвета);
КонецПроцедуры 

&НаКлиенте
Функция ВыполнитьСкрипт(СтрокаКоманды, ЖдатьОкончания, ЗапускЧерезСкрипт,ОписаниеОшибки) Экспорт
	ИмяУправляющиегоФайлаSikuliXСевер = Ванесса.ИмяУправляющиегоФайлаSikuliXСевер();
	Ванесса.УдалитьФайлыКомандаСистемы(ИмяУправляющиегоФайлаSikuliXСевер);
	
	ЗаписатьУправляющийJson(ИмяУправляющиегоФайлаSikuliXСевер,СтрокаКоманды);
	
	Если ЖдатьОкончания Тогда
	//ждём файла ответа
		КоличествоПопытокЧтенияОтвета = 10;
		Ответ = Неопределено;
		ИмяФайлаОтветаSikuliXСевер = Ванесса.ИмяФайлаОтветаSikuliXСевер();
		Для СчетчикПопыток = 1 По КоличествоПопытокЧтенияОтвета Цикл
			Если Ванесса.ФайлСуществуетКомандаСистемы(ИмяФайлаОтветаSikuliXСевер) Тогда
				Ответ = ПрочитатьФайлОтвета(ИмяФайлаОтветаSikuliXСевер);
				Ванесса.УдалитьФайлыКомандаСистемы(ИмяФайлаОтветаSikuliXСевер);
				Прервать;
			КонецЕсли;	
			
			Ванесса.sleep(1);
		КонецЦикла;	
		
		Если Ответ = Неопределено Тогда
			ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не получилось дождаться выполнения SikuliX скрипта <%1>.");
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",СтрокаКоманды); 
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;	
		
		Если Нрег(Ответ) <> "success" Тогда
			ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не получилось выполнить SikuliX скрипт <%1>.");
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",СтрокаКоманды); 
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;	 
	КонецЕсли;	 
	
	Возврат 0;
КонецФункции	 

&НаКлиенте
Процедура ОстановитьSikuliXСервер() Экспорт
	ИмяУправляющиегоФайлаSikuliXСевер = Ванесса.ИмяУправляющиегоФайлаSikuliXСевер();
	ЗаписатьУправляющийJson(ИмяУправляющиегоФайлаSikuliXСевер,"","exit0");
КонецПроцедуры 

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОчиститьКаталог(Каталог)
	ФайлКаталог = Новый Файл(Каталог);
	Если НЕ ФайлКаталог.Существует() Тогда
		Возврат;
	КонецЕсли;	 
	
	Файлы = НайтиФайлы(Каталог,"*",Истина);
	Для Каждого Файл Из Файлы Цикл
		Попытка
			УдалитьФайлы(Файл.ПолноеИмя);
		Исключение
		КонецПопытки;
	КонецЦикла;	
	
	Файлы = НайтиФайлы(Каталог,"*",Истина);
	Для Каждого Файл Из Файлы Цикл
		Попытка
			УдалитьФайлы(Файл.ПолноеИмя);
		Исключение
			ТекстСообщения = Ванесса.ПолучитьТекстСообщенияПользователю("Не смог удалить файл %1");
			ТекстСообщения = СтрЗаменить(ТекстСообщения,"%1",Файл.ПолноеИмя); 
			ВызватьИсключение ТекстСообщения;
		КонецПопытки;
	КонецЦикла;	
КонецПроцедуры 

&НаКлиенте
Функция ДанныеСкрипта(КаталогСкрипта,ОбщаяСекцияИмпорт)
	ФайлКаталогСкрипта = Новый Файл(КаталогСкрипта);
	ИмяСкрипта = ФайлКаталогСкрипта.ИмяБезРасширения;
	
	КартинкиСкрипта = Новый Массив;
	Файлы = НайтиФайлы(КаталогСкрипта,"*.png",Ложь);
	Для Каждого Файл Из Файлы Цикл
		ДанныеКартинки = Новый Структура;
		ДанныеКартинки.Вставить("ИмяФайла",Файл.Имя);
		ДанныеКартинки.Вставить("ПолноеИмя",СтрЗаменить(Файл.ПолноеИмя,"\","/"));
		КартинкиСкрипта.Добавить(ДанныеКартинки);
	КонецЦикла;	
	 
	
	ДанныеСкрипта = Новый Структура;
	
	НашлиФайл = Ложь;
	Файлы = НайтиФайлы(КаталогСкрипта,"*.py",Ложь);
	Для Каждого Файл Из Файлы Цикл
		Если НРег(Файл.ИмяБезРасширения) = НРег(ИмяСкрипта) Тогда
			НашлиФайл = Истина;
			
			ДанныеСкрипта.Вставить("ИмяСкрипта",ИмяСкрипта);	
			СекцияИмпорт = Новый Массив;
			ДанныеСкрипта.Вставить("СекцияИмпорт",СекцияИмпорт);
			ТелоСкрипта = Новый Массив;
			ДанныеСкрипта.Вставить("ТелоСкрипта",ТелоСкрипта);
			
			
			Текст = Новый ЧтениеТекста;
			Текст.Открыть(Файл.ПолноеИмя,"UTF-8");
			
			Пока Истина Цикл
				Стр = Текст.ПрочитатьСтроку();
				Если Стр = Неопределено Тогда
					Прервать;
				КонецЕсли;	 
				
				Если Лев(Стр,6) = "import" Тогда
					Стр = СокрЛП(НРег(Стр));
					Если ОбщаяСекцияИмпорт.Найти(Стр) = Неопределено Тогда
						ОбщаяСекцияИмпорт.Добавить(Стр);
						Продолжить;
					КонецЕсли;	 
				ИначеЕсли Найти(НРег(Стр),".png") > 0 Тогда
					Для Каждого КартинкаСкрипта Из КартинкиСкрипта Цикл
						Стр = СтрЗаменить(Стр,КартинкаСкрипта.ИмяФайла,КартинкаСкрипта.ПолноеИмя);
					КонецЦикла;	 
				ИначеЕсли НРег(СокрЛП(Стр)) = "exit(0)" Тогда
					//надо заменить на пустую команду
					Стр = СтрЗаменить(НРег(Стр),"exit(0)","pass");
				ИначеЕсли НРег(СокрЛП(Стр)) = "exit(1)" Тогда
					КолПробелов = СтрДлина(Стр) - СтрДлина(СокрЛ(Стр));
					Стр = Лев(Стр,КолПробелов) + "CallError(""" + ИмяСкрипта + """)";
				КонецЕсли;	 
				
				Стр = СтрЗаменить(Стр,"sys.argv[1]","sys_argv_1");
				Стр = СтрЗаменить(Стр,"sys.argv[2]","sys_argv_2");
				Стр = СтрЗаменить(Стр,"sys.argv[3]","sys_argv_3");
				Стр = СтрЗаменить(Стр,"sys.argv[4]","sys_argv_4");
				Стр = СтрЗаменить(Стр,"sys.argv[5]","sys_argv_5");
				
				ТелоСкрипта.Добавить(Стр);
			КонецЦикла;	
			
			Текст.Закрыть();
			Прервать;
		КонецЕсли;	 
	КонецЦикла;	
	
	Если Не НашлиФайл Тогда
		ВызватьИсключение "Не найден файл <" + ИмяСкрипта + ".py> в каталоге <" + КаталогСкрипта + ">";
	КонецЕсли;	 
	
	Возврат ДанныеСкрипта; 
КонецФункции

&НаКлиенте
Функция ПрочитатьФайлОтвета(ИмяФайла)
	ЧтениеJSON = Вычислить("Новый ЧтениеJSON");
	ЧтениеJSON.ОткрытьФайл(ИмяФайла);
	СтруктураПараметров = Вычислить("ПрочитатьJSON(ЧтениеJSON)");
	ЧтениеJSON.Закрыть();
	Возврат СтруктураПараметров.Response; 
КонецФункции	 

&НаКлиенте
Процедура ОпределитьАргументыСкрипта(Знач Стр,comand,sys_argv_1,sys_argv_2,sys_argv_3,sys_argv_4,sys_argv_5)
	Поз = Найти(Стр,"--args");
	Если Поз > 0 Тогда
		ЛеваяЧасть = СокрЛП(Лев(Стр,Поз-1));
		Стр = СокрЛП(Сред(Стр,Поз+6));
	Иначе
		Если ЗначениеЗаполнено(Стр) Тогда
			Файл = Новый Файл(Стр);
			comand = Файл.ИмяБезРасширения;
		КонецЕсли;	 
		
		Возврат;
	КонецЕсли;	 
	
	Файл = Новый Файл(ЛеваяЧасть);
	comand = Файл.ИмяБезРасширения;
	
	НашлиПараметрВКавычках = Ложь;
	НашлиПараметр          = Ложь;
	
	НомерПараметра    = 0;
	ЗначениеПараметра = "";
	
	Для Ккк = 1 По СтрДлина(Стр) Цикл
		Символ = Сред(Стр,Ккк,1);
		
		Если Символ = """" И НЕ НашлиПараметрВКавычках Тогда
			НашлиПараметр = Истина;
			НашлиПараметрВКавычках = Истина;
			НомерПараметра = НомерПараметра + 1;
			ЗначениеПараметра = "";
			Продолжить;
		ИначеЕсли Символ = " " И НЕ НашлиПараметрВКавычках Тогда
			НашлиПараметр = Истина;
			НашлиПараметрВКавычках = Ложь;
			НомерПараметра = НомерПараметра + 1;
			ЗначениеПараметра = "";
			Продолжить;
		КонецЕсли;	 
		
		Если НашлиПараметр Тогда
			Если НашлиПараметрВКавычках Тогда
				Если Символ = """" Тогда
					НашлиПараметрВКавычках = Ложь;
					НашлиПараметр          = Ложь;
					
					Если НомерПараметра = 1 Тогда
						sys_argv_1 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 2 Тогда
						sys_argv_2 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 3 Тогда
						sys_argv_3 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 4 Тогда
						sys_argv_4 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 5 Тогда
						sys_argv_5 = ЗначениеПараметра;
					КонецЕсли;	 
				Иначе	
					ЗначениеПараметра = ЗначениеПараметра + Символ;
				КонецЕсли;	 
			Иначе	
				Если Символ = " " Тогда
					НашлиПараметрВКавычках = Ложь;
					НашлиПараметр          = Ложь;
					
					Если НомерПараметра = 1 Тогда
						sys_argv_1 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 2 Тогда
						sys_argv_2 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 3 Тогда
						sys_argv_3 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 4 Тогда
						sys_argv_4 = ЗначениеПараметра;
					ИначеЕсли НомерПараметра = 5 Тогда
						sys_argv_5 = ЗначениеПараметра;
					КонецЕсли;	 
				Иначе	
					ЗначениеПараметра = ЗначениеПараметра + Символ;
				КонецЕсли;	 
			КонецЕсли;	 
		КонецЕсли;	 
		
	КонецЦикла;	
	
КонецПроцедуры 

&НаКлиенте
Процедура ЗаписатьУправляющийJson(ИмяУправляющиегоФайлаSikuliXСевер,СтрокаКоманды,comand = "")
	ВременныйJson = ПолучитьИмяВременногоФайла("json");
	
	ЗаписьJSON = Вычислить("Новый ЗаписьJSON()");
	ЗаписьJSON.ОткрытьФайл(ВременныйJson);
	
	ЗаписьJSON.ЗаписатьНачалоОбъекта();
	
	sys_argv_1 = "";
	sys_argv_2 = "";
	sys_argv_3 = "";
	sys_argv_4 = "";
	sys_argv_5 = "";
	
	ОпределитьАргументыСкрипта(СтрокаКоманды,comand,sys_argv_1,sys_argv_2,sys_argv_3,sys_argv_4,sys_argv_5);
	
	ЗаписьJSON.ЗаписатьИмяСвойства("comand");
	ЗаписьJSON.ЗаписатьЗначение(comand);
	
	ЗаписьJSON.ЗаписатьИмяСвойства("sys_argv_1");
	ЗаписьJSON.ЗаписатьЗначение(sys_argv_1);
	
	ЗаписьJSON.ЗаписатьИмяСвойства("sys_argv_1");
	ЗаписьJSON.ЗаписатьЗначение(sys_argv_1);
	
	ЗаписьJSON.ЗаписатьИмяСвойства("sys_argv_2");
	ЗаписьJSON.ЗаписатьЗначение(sys_argv_2);
	
	ЗаписьJSON.ЗаписатьИмяСвойства("sys_argv_3");
	ЗаписьJSON.ЗаписатьЗначение(sys_argv_3);
	
	ЗаписьJSON.ЗаписатьИмяСвойства("sys_argv_4");
	ЗаписьJSON.ЗаписатьЗначение(sys_argv_4);
	
	ЗаписьJSON.ЗаписатьИмяСвойства("sys_argv_5");
	ЗаписьJSON.ЗаписатьЗначение(sys_argv_5);
	
	ЗаписьJSON.ЗаписатьКонецОбъекта();	
	ЗаписьJSON.Закрыть();
	
	Ванесса.ПереместитьФайлКомандаСистемы(ВременныйJson,ИмяУправляющиегоФайлаSikuliXСевер);
КонецПроцедуры 

#КонецОбласти
