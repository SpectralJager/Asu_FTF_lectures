﻿
Процедура ОбработкаПроведения(Отказ, Режим)     
	Движения.СтоимостьМатериалов.Записывать = Истина ;
	Движения.ОситаткиМатериалов.Записывать = Истина ; 
	Для Каждого ТекСтрокаПереченьНоменклатуры Из ПереченьНоменклатуры Цикл 
		Если ТекСтрокаПереченьНоменклатуры.Номенклатура.ВидНомеклатуры = Перечисления.ВидыНоменклатуры.Материал Тогда 
			Движение = Движения.ОситаткиМатериалов.Добавить(); 
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход; 
			Движение.Период = Дата; 
			Движение.Материал = ТекСтрокаПереченьНоменклатуры.Номенклатура; 
			Движение.Склад = Склад; 
			Движение.Количество = ТекСтрокаПереченьНоменклатуры.Количество; 
			// регистр СтоимостьМатериалов Расход
			Движение = Движения.СтоимостьМатериалов.Добавить( ) ;
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.Материал = ТекСтрокаПереченьНоменклатуры.Номенклатура;
			Движение.Стоимость = ТекСтрокаПереченьНоменклатуры.Количество *
			ТекСтрокаПереченьНоменклатуры.Стоимость;
		КонецЕсли ;
	КонецЦикла ; 
	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ 
КонецПроцедуры
