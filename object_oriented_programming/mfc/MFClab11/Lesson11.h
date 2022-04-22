
// Lesson11.h: основной файл заголовка для приложения Lesson11
//
#pragma once

#ifndef __AFXWIN_H__
	#error "включить pch.h до включения этого файла в PCH"
#endif

#include "resource.h"       // основные символы


// CLesson11App:
// Сведения о реализации этого класса: Lesson11.cpp
//

class CLesson11App : public CWinApp
{
public:
	CLesson11App() noexcept;


// Переопределение
public:
	virtual BOOL InitInstance();

// Реализация
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
	virtual BOOL OnIdle(LONG lCount);
};

extern CLesson11App theApp;
