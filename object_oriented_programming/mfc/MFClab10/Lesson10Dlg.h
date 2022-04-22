
// Lesson10Dlg.h: файл заголовка
//

#pragma once


// Диалоговое окно CLesson10Dlg
class CLesson10Dlg : public CDialogEx
{
// Создание
public:
	CLesson10Dlg(CWnd* pParent = nullptr);	// стандартный конструктор

// Данные диалогового окна
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_LESSON10_DIALOG };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// поддержка DDX/DDV


// Реализация
protected:
	HICON m_hIcon;

	// Созданные функции схемы сообщений
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnFileExit();
private:
	BITMAP bm;
	HBITMAP hbm;
public:
	afx_msg void OnFileOpen();
};
