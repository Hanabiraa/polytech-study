
// MFClab2Dlg.cpp : implementation file
//

#include "pch.h"
#include "framework.h"
#include "MFClab2.h"
#include "MFClab2Dlg.h"
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


// CMFClab2Dlg dialog



CMFClab2Dlg::CMFClab2Dlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_MFCLAB2_DIALOG, pParent)
	, m_VisibleCheck(FALSE)
	, m_EnableCheck(FALSE)
	, m_TestEdit(_T(""))
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMFClab2Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Check(pDX, IDC_VISIBLE_CHECK, m_VisibleCheck);
	DDX_Check(pDX, IDC_ENABLED_CHECK, m_EnableCheck);
	DDX_Text(pDX, IDC_TEST_EDIT, m_TestEdit);
}

BEGIN_MESSAGE_MAP(CMFClab2Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_EXIT_BUTTON, &CMFClab2Dlg::OnClickedExitButton)
	ON_BN_CLICKED(IDC_TEST_BUTTON, &CMFClab2Dlg::OnClickedTestButton)
	ON_BN_CLICKED(IDC_CLEAR_BUTTON, &CMFClab2Dlg::OnClickedClearButton)
	ON_BN_CLICKED(IDC_VISIBLE_CHECK, &CMFClab2Dlg::OnClickedVisibleCheck)
	ON_BN_CLICKED(IDC_ENABLED_CHECK, &CMFClab2Dlg::OnClickedEnabledCheck)
	ON_EN_CHANGE(IDC_TEST_EDIT, &CMFClab2Dlg::OnChangeTestEdit)
END_MESSAGE_MAP()


// CMFClab2Dlg message handlers

BOOL CMFClab2Dlg::OnInitDialog()
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
	m_EnableCheck = TRUE;
	m_VisibleCheck = TRUE;
	UpdateData(FALSE);


	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMFClab2Dlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CMFClab2Dlg::OnPaint()
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
HCURSOR CMFClab2Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}




void CMFClab2Dlg::OnClickedExitButton()
{
	// TODO: Add your control notification handler code here
	OnOK();
}


void CMFClab2Dlg::OnClickedTestButton()
{
	// TODO: Add your control notification handler code here
	m_TestEdit = "This is a Test";
	UpdateData(FALSE);
}


void CMFClab2Dlg::OnClickedClearButton()
{
	// TODO: Add your control notification handler code here
	m_TestEdit = " ";
	
	UpdateData(FALSE);
}


void CMFClab2Dlg::OnClickedVisibleCheck()
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	///Если отметка флажка Visible cделать окно редактирования видимым
	///А если нет - то невидимым
	if (m_VisibleCheck == TRUE)
		GetDlgItem(IDC_TEST_EDIT)->ShowWindow(SW_SHOW);
	else
		GetDlgItem(IDC_TEST_EDIT)->ShowWindow(SW_HIDE);
}


void CMFClab2Dlg::OnClickedEnabledCheck()
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
	///Если отметка флажка Enable зделать окно редактирования видимым
	///А если нет - то невидимым
	if (m_EnableCheck == TRUE)
		GetDlgItem(IDC_TEST_EDIT)->EnableWindow(SW_SHOW);
	else
		GetDlgItem(IDC_TEST_EDIT)->EnableWindow(SW_HIDE);
}


void CMFClab2Dlg::OnChangeTestEdit()
{
	// TODO:  If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialogEx::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.

	// TODO:  Add your control notification handler code here
	///Обновить переменные
	UpdateData(TRUE);
	///Содать переменную типа CString, присвоить ей значение
	///переменной m_TestEdit и выполнить перевод символов в верхний
	///регистр.
	CString UpperValue;
	UpperValue = m_TestEdit;
	UpperValue.MakeUpper();

	///Если в окне редактирования напечатано PAINT
	///запускается редактор PAINT и окно редактирования становится пустым.
	if (UpperValue == "PAINT")
	{
		system("pbrush.exe");
		m_TestEdit = " ";
		UpdateData(FALSE);
	}

	///Если в окне редактирования напечатано CALCULATOR
	///запускается калькулятор и окно редактирования становится пустым.
	if (UpperValue == "CALCULATOR")
	{
		system("calc.exe");
		m_TestEdit = " ";
		UpdateData(FALSE);
	}

	if (UpperValue == "BEEP")
	{
		MessageBeep((WORD)-2);
	}
}