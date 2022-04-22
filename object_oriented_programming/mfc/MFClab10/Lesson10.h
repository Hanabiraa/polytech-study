
// Lesson10.h: главный файл заголовка для приложения PROJECT_NAME
//

#pragma once

#ifndef __AFXWIN_H__
	#error "включить pch.h до включения этого файла в PCH"
#endif

#include "resource.h"		// основные символы


// CLesson10App:
// Сведения о реализации этого класса: Lesson10.cpp
//

class CLesson10App : public CWinApp
{
public:
	CLesson10App();

// Переопределение
public:
	virtual BOOL InitInstance();

// Реализация

	DECLARE_MESSAGE_MAP()
};

extern CLesson10App theApp;
