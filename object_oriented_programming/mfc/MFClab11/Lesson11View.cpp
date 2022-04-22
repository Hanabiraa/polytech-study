
// Lesson11View.cpp: реализация класса CLesson11View
//

#include "pch.h"
#include "framework.h"
// SHARED_HANDLERS можно определить в обработчиках фильтров просмотра реализации проекта ATL, эскизов
// и поиска; позволяет совместно использовать код документа в данным проекте.
#ifndef SHARED_HANDLERS
#include "Lesson11.h"
#endif

#include "Lesson11Doc.h"
#include "Lesson11View.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CLesson11View

IMPLEMENT_DYNCREATE(CLesson11View, CFormView)

BEGIN_MESSAGE_MAP(CLesson11View, CFormView)
END_MESSAGE_MAP()

// Создание или уничтожение CLesson11View

CLesson11View::CLesson11View() : m_EnableTask1Check(FALSE), m_EnableTask3Check(FALSE), CFormView(IDD_LESSON11_FORM)
, m_Task1Edit(0)
, m_EnableTask2Check(FALSE)
, m_Task2Edit(0)
, m_Task3Edit(0)
{
	// TODO: добавьте код создания

}

CLesson11View::~CLesson11View()
{
}

void CLesson11View::DoDataExchange(CDataExchange* pDX)
{
	CFormView::DoDataExchange(pDX);
	DDX_Check(pDX, IDC_ENABLE_TASK1_CHECK, m_EnableTask1Check);
	DDX_Check(pDX, IDC_ENABLE_TASK3_CHECK, m_EnableTask3Check);
	DDX_Text(pDX, IDC_TASK1_EDIT, m_Task1Edit);
	DDX_Check(pDX, IDC_ENABLE_TASK2_CHECK, m_EnableTask2Check);
	DDX_Text(pDX, IDC_TASK2_EDIT, m_Task2Edit);
	DDX_Text(pDX, IDC_TASK3_EDIT, m_Task3Edit);
}

BOOL CLesson11View::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: изменить класс Window или стили посредством изменения
	//  CREATESTRUCT cs

	return CFormView::PreCreateWindow(cs);
}

void CLesson11View::OnInitialUpdate()
{
	CFormView::OnInitialUpdate();
	GetParentFrame()->RecalcLayout();
	ResizeParentToFit();

	//Без комментариев
	m_EnableTask1Check = TRUE;
	m_EnableTask2Check = TRUE;
	m_EnableTask3Check = TRUE;
	UpdateData(FALSE);

}


// Диагностика CLesson11View

#ifdef _DEBUG
void CLesson11View::AssertValid() const
{
	CFormView::AssertValid();
}

void CLesson11View::Dump(CDumpContext& dc) const
{
	CFormView::Dump(dc);
}

CLesson11Doc* CLesson11View::GetDocument() const // встроена неотлаженная версия
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CLesson11Doc)));
	return (CLesson11Doc*)m_pDocument;
}
#endif //_DEBUG


// Обработчики сообщений CLesson11View
