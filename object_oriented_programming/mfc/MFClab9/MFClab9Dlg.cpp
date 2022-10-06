
// MFClab9Dlg.cpp : implementation file
//

#include "pch.h"
#include "framework.h"
#include "MFClab9.h"
#include "MFClab9Dlg.h"
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


// CMFClab9Dlg dialog



CMFClab9Dlg::CMFClab9Dlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_MFCLAB9_DIALOG, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_Amt_Remaining = 0.0;
}

void CMFClab9Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_CARD1, m_Card1);
	DDX_Control(pDX, IDC_CARD2, m_Card2);
	DDX_Control(pDX, IDC_CARD3, m_Card3);
	DDX_Control(pDX, IDC_CARD4, m_Card4);
	DDX_Control(pDX, IDC_AMT_LEFT, m_Amt_Left);
}

BEGIN_MESSAGE_MAP(CMFClab9Dlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_DEALCARDS, &CMFClab9Dlg::OnBnClickedDealcards)
	ON_BN_CLICKED(IDCANCEL, &CMFClab9Dlg::OnBnClickedCancel)
END_MESSAGE_MAP()


// CMFClab9Dlg message handlers

BOOL CMFClab9Dlg::OnInitDialog()
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
	m_Amt_Remaining = 100;
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMFClab9Dlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CMFClab9Dlg::OnPaint()
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
HCURSOR CMFClab9Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMFClab9Dlg::OnBnClickedDealcards()
{
	// TODO: Add your control notification handler code here
	//Отнять два доллара при сдаче карт
	m_Amt_Remaining -= 2.00;

	//Сдать карты
	DealCards();

	//Подсчитать выйгрыш
	CalculateWinnings();

	//Изменить заголовок элемента Group Box
	CString s;
	s.Format(L"Amount Remaining $ %.2f", m_Amt_Remaining);
	m_Amt_Left.SetWindowText(s);
}


void CMFClab9Dlg::DealCards()
{
	// TODO: Add your implementation code here.
	//Обнуляем заначение выпавших карт одной масти
	for (int i = 0; i < 4; i++) m_Cards[i] = 0;

	//Меняем иконку в элементах управления иконками
	m_Card1.SetIcon(PickRandomCard());
	m_Card2.SetIcon(PickRandomCard());
	m_Card3.SetIcon(PickRandomCard());
	m_Card4.SetIcon(PickRandomCard());
}


HICON& CMFClab9Dlg::PickRandomCard()
{
	// TODO: Add your implementation code here.
	// // O: insert return statement here
	//Выбрать номер карты случайным образом
	int num = (rand() % 4);
	/*Проссумировать кол-во выпавших карт одной масти*/
	m_Cards[num]++;

	/*В зависимости от выпавшего номера вернуть адрес иконки*/
	switch (num)
	{
	case 0: return m_Club;
	case 1: return m_Diamond;
	case 2: return m_Heart;
	}
	return m_Spade;
}


void CMFClab9Dlg::CalculateWinnings()
{
	// TODO: Add your implementation code here.
	int pairs = 0;
	for (int i = 0; i < 4; i++)
	{
		if (m_Cards[i] == 2)
		{
			if (pairs > 0)
			{
				m_Amt_Remaining += 3.00;
				break;
			}
			else
			{
				pairs++;
			}
		}
		else if (m_Cards[i] == 3)
		{
			m_Amt_Remaining += 6.00;
			break;

		}
		else if (m_Cards[i] == 4)
		{
			m_Amt_Remaining += 9.00;
			break;
		}
	}
}


void CMFClab9Dlg::OnBnClickedCancel()
{
	// TODO: Add your control notification handler code here
	///-Ваш код начинается здесь-///

	CString s;
	//Добавить в сторку размер выйгрыша
	s.Format(L"Good game! I have $ %.2f.", m_Amt_Remaining);
	//Выдать окно сообщения
	MessageBox(s, L"Thank you for game in FourUp!");

	///-Ваш код заканчивается здесь-///
	CDialogEx::OnCancel();
}
