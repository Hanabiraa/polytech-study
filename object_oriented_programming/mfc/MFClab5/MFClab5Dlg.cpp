
// MFClab5Dlg.cpp : implementation file
//

#include "pch.h"
#include "framework.h"
#include "MFClab5.h"
#include "MFClab5Dlg.h"
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
public:
	afx_msg void OnFileSayhello();
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


// CMFClab5Dlg dialog



CMFClab5Dlg::CMFClab5Dlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_MFCLAB5_DIALOG, pParent)
	, m_SpeedEdit(0)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMFClab5Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_SPEED_EDIT, m_SpeedEdit);
	DDV_MinMaxInt(pDX, m_SpeedEdit, 0, 100);
}

BEGIN_MESSAGE_MAP(CMFClab5Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_EN_CHANGE(IDC_SPEED_EDIT, &CMFClab5Dlg::OnChangeSpeedEdit)
	ON_COMMAND(ID_FILE_CURRENTSPEED, &CMFClab5Dlg::OnFileCurrentspeed)
	ON_COMMAND(ID_FILE_EXIT, &CMFClab5Dlg::OnFileExit)
	ON_COMMAND(ID_HELP_ABOUT, &CMFClab5Dlg::OnHelpAbout)
	ON_COMMAND(ID_FILE_SAYHELLO, &CAboutDlg::OnFileSayhello)
END_MESSAGE_MAP()


// CMFClab5Dlg message handlers

BOOL CMFClab5Dlg::OnInitDialog()
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

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMFClab5Dlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CMFClab5Dlg::OnPaint()
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
HCURSOR CMFClab5Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMFClab5Dlg::OnChangeSpeedEdit()
{
	// TODO:  If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialogEx::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.

	// TODO:  Add your control notification handler code here
	UpdateData(TRUE);
}


void CMFClab5Dlg::OnFileCurrentspeed()
{
	// TODO: Add your command handler code here
	CString strSpeed;
	strSpeed.Format(L"%i", m_SpeedEdit);
	MessageBox((CString)strSpeed);
}


void CMFClab5Dlg::OnFileExit()
{
	// TODO: Add your command handler code here
	OnOK();
}


void CMFClab5Dlg::OnHelpAbout()
{
	// TODO: Add your command handler code here
	//Создать объект класса CAboutDlg
	CAboutDlg dlg;
	//Вывести диалоговую панель About
	dlg.DoModal();
}


void CAboutDlg::OnFileSayhello()
{
	// TODO: Add your command handler code here
	CString str = L"Hello!";
	MessageBox(str);
}
