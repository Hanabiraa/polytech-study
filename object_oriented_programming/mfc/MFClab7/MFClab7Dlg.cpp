
// MFClab7Dlg.cpp : implementation file
//

#include "pch.h"
#include "framework.h"
#include "MFClab7.h"
#include "MFClab7Dlg.h"
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


// CMFClab7Dlg dialog



CMFClab7Dlg::CMFClab7Dlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_MFCLAB7_DIALOG, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMFClab7Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CMFClab7Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_EXIT_BUTTON, &CMFClab7Dlg::OnBnClickedExitButton)
	ON_WM_DESTROY()
	ON_WM_TIMER()
	ON_WM_CREATE()
	ON_BN_CLICKED(IDC_DRAWGRAPHICS_BUTTON, &CMFClab7Dlg::OnBnClickedDrawgraphicsButton)
END_MESSAGE_MAP()


// CMFClab7Dlg message handlers

BOOL CMFClab7Dlg::OnInitDialog()
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
	///Установить системный таймер
	int iInstallResult;
	iInstallResult = SetTimer(1, 50, NULL);
	if (iInstallResult == FALSE)
	{
		MessageBox(L"Cannot install timer",
			L"Error message",
			MB_OK + MB_ICONERROR);
	}

	//Выбрать радиокнопку RED
	m_dlg.m_RedRadio = 0;

	m_Radius = 50;
	m_Direction = 1;

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMFClab7Dlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CMFClab7Dlg::OnPaint()
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
		//Создать объект контекста устройства(DC)
		CPaintDC dc(this);

		//Создать новое перо
		CPen MyNewPen;

		int r = 0;
		int g = 0;
		int b = 0;

		switch (m_dlg.m_RedRadio)
		{
		case 0:
			r = 255;
			break;
		case 1:
			g = 255;
			break;
		case 2:
			b = 255;
			break;
		default:
			break;
		}

		MyNewPen.CreatePen(PS_SOLID, 10, RGB(r, g, b));

		//Выбрать перо
		CPen* pOriginalPen;
		pOriginalPen = dc.SelectObject(&MyNewPen);
		// CRect MyRectangle(20, 10, 120,110);

		CRect MyRectangle(20, 10, 20 + m_Radius * 2, 10 + m_Radius * 2);

		//Нарисовать круг
		dc.Ellipse(&MyRectangle);

		//Выбрать первоначальное перо
		dc.SelectObject(pOriginalPen);
		//CDialogEx::OnPaint();
	}
}

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CMFClab7Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMFClab7Dlg::OnBnClickedExitButton()
{
	// TODO: Add your control notification handler code here
	OnOK();
}


void CMFClab7Dlg::OnDestroy()
{
	CDialogEx::OnDestroy();

	// TODO: Add your message handler code here
	KillTimer(1);
}


void CMFClab7Dlg::OnTimer(UINT_PTR nIDEvent)
{
	// TODO: Add your message handler code here and/or call default

	// MessageBeep((WORD)-2);
	m_Radius = m_Radius + m_Direction;
	if (m_Radius >= 100)
	{
		m_Direction = -1;
	}
	if (m_Radius <= 10)
	{
		m_Direction = 1;
	}
	Invalidate();
	CDialogEx::OnTimer(nIDEvent);
}


int CMFClab7Dlg::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CDialogEx::OnCreate(lpCreateStruct) == -1)
		return -1;

	return 0;
}


void CMFClab7Dlg::OnBnClickedDrawgraphicsButton()
{
	// TODO: Add your control notification handler code here
	m_dlg.DoModal();


	///Создать объект контекста устройства(DC)
	CClientDC dc(this);

	//Создать новое перо
	CPen MyNewPen;
	MyNewPen.CreatePen(PS_SOLID, 10, RGB(255, 0, 0));

	//Выбрать перо
	CPen* pOriginalPen;
	pOriginalPen = dc.SelectObject(&MyNewPen);
	CRect MyRectangle(20, 10, 120, 110);

	//Нарисовать круг
	dc.Ellipse(&MyRectangle);

	//Выбрать первоначальное перо
	dc.SelectObject(pOriginalPen);
}
