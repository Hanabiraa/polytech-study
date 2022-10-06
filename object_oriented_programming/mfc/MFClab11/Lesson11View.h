
// Lesson11View.h: интерфейс класса CLesson11View
//

#pragma once


class CLesson11View : public CFormView
{
protected: // создать только из сериализации
	CLesson11View();
	DECLARE_DYNCREATE(CLesson11View)

public:
#ifdef AFX_DESIGN_TIME
	enum{ IDD = IDD_LESSON11_FORM };
#endif

// Атрибуты
public:
	CLesson11Doc* GetDocument() const;

// Операции
public:

// Переопределение
public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // поддержка DDX/DDV
	virtual void OnInitialUpdate(); // вызывается в первый раз после конструктора

// Реализация
public:
	virtual ~CLesson11View();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Созданные функции схемы сообщений
protected:
	DECLARE_MESSAGE_MAP()
public:
	BOOL m_EnableTask1Check;
	BOOL m_EnableTask3Check;
	long m_Task1Edit;
	BOOL m_EnableTask2Check;
	long m_Task2Edit;
	long m_Task3Edit;
};

#ifndef _DEBUG  // версия отладки в Lesson11View.cpp
inline CLesson11Doc* CLesson11View::GetDocument() const
   { return reinterpret_cast<CLesson11Doc*>(m_pDocument); }
#endif

