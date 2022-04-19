
// MFClab8Dlg.cpp : implementation file
//

#include "pch.h"
#include "framework.h"
#include "MFClab8.h"
#include "MFClab8Dlg.h"
#include "afxdialogex.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_ABOUTBOX };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(IDD_ABOUTBOX)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// CMFClab8Dlg dialog



CMFClab8Dlg::CMFClab8Dlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_MFCLAB8_DIALOG, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_PenColor = RGB(0, 0, 0);
}

void CMFClab8Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CMFClab8Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_CLEARBTN, &CMFClab8Dlg::OnBnClickedClearbtn)
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	ON_WM_LBUTTONUP()
	ON_STN_CLICKED(IDC_PENCOLOR, &CMFClab8Dlg::OnStnClickedPencolor)
END_MESSAGE_MAP()


// CMFClab8Dlg message handlers

BOOL CMFClab8Dlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != nullptr)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	// TODO: Add extra initialization here
	//Получить указатель на элемент управления Picture
	CWnd* p_Canvas = GetDlgItem(IDC_CANVAS);

	//Записать координаты окна в переменную m_Canvas
	p_Canvas->GetWindowRect(&m_Canvas);

	//Сопоставить координаты для клиентской области
	ScreenToClient(&m_Canvas);

	//Изменить координаты окна
	m_Canvas.DeflateRect(2, 2, 1, 1);

	//Получить указатель на элемент управления
	CWnd* pPenColor = GetDlgItem(IDC_PENCOLOR);

	//Получить координаты элемента управления
	pPenColor->GetWindowRect(&m_PenColorSwatch);

	//Изменить координаты относительно клиентской области
	ScreenToClient(&m_PenColorSwatch);

	//Cузить рамку 
	m_PenColorSwatch.DeflateRect(2,2,1,1);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMFClab8Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CMFClab8Dlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CMFClab8Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMFClab8Dlg::OnBnClickedClearbtn()
{
	// TODO: Add your control notification handler code here
	CClientDC dc(this);

	//Выбрать нулевое перо
	dc.SelectStockObject(NULL_PEN);

	//Очистить окно
	dc.Rectangle(m_Canvas);
}


void CMFClab8Dlg::OnLButtonDown(UINT nFlags, CPoint point)
{
	// TODO: Add your message handler code here and/or call default
	//Проверить было ли нажатие внутри области рисования.
	if (m_Canvas.PtInRect(point))
	{
		//Присвоить координаты начала двум переменным
		m_LineStart = point;
		m_LineEnd = point;

		m_Pen.DeleteObject();
		m_Pen.CreatePen(PS_SOLID, 1, m_PenColor);

		//Захватить мышь
		SetCapture();
	}

	CDialogEx::OnLButtonDown(nFlags, point);
}


void CMFClab8Dlg::OnMouseMove(UINT nFlags, CPoint point)
{
	// TODO: Add your message handler code here and/or call default
	if ((nFlags & MK_LBUTTON) && m_Canvas.PtInRect(point))
	{

		//Получить указатель на контекст устройства
		CClientDC dc(this);
		dc.SelectObject(&m_Pen);

		//Присвоить координаты щелчка переменной m_LineEnd
		m_LineEnd = point;

		//Нарисовать линию
		dc.MoveTo(m_LineStart);
		dc.LineTo(m_LineEnd);

			/*Присвоить текущее переменной m_LineStart значение позиции курсора*/
			m_LineStart = m_LineEnd;
	}

	CDialogEx::OnMouseMove(nFlags, point);
}


void CMFClab8Dlg::OnLButtonUp(UINT nFlags, CPoint point)
{
	// TODO: Add your message handler code here and/or call default
	ReleaseCapture();
	CDialogEx::OnLButtonUp(nFlags, point);
}


void CMFClab8Dlg::OnStnClickedPencolor()
{
	// TODO: Add your control notification handler code here
	CColorDialog dlg(m_PenColor);

	//Вывод диалогового окна
	if (dlg.DoModal() == IDOK)
	{
		//Установка цвета
		m_PenColor = dlg.GetColor();

		//Создание кисти
		CBrush swatch;
		swatch.CreateSolidBrush(m_PenColor);

		//Получить объект контекста устройства
		CClientDC dc(this);

		//Закрашивание индикатора выбранным цветом
		dc.FillRect(&m_PenColorSwatch, &swatch);
	}
}
