﻿Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка) 
	СтандартнаяОбработка = Ложь; 
	Поля.Добавить( "Наименование" ); 
	Поля.Добавить( "ВидНомеклатуры" );	 
КонецПроцедуры       

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка) 
	СтандартнаяОбработка = Ложь;
	Если ЗначениеЗаполнено(Данные.ВидНомеклатуры) Тогда 
		Представление = Данные.Наименование + " ("+НРег(Строка(Данные.ВидНомеклатуры)) + ")"; 
	Иначе 
		Представление = Данные.Наименование; 
	КонецЕсли; 
КонецПроцедуры