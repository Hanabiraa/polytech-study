// CSetDlg.cpp : implementation file
//

#include "pch.h"
#include "MFClab7.h"
#include "afxdialogex.h"
#include "CSetDlg.h"


// CSetDlg dialog

IMPLEMENT_DYNAMIC(CSetDlg, CDialogEx)

CSetDlg::CSetDlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_CUSTOM_DIALOG, pParent)
	, m_RedRadio(0)
{

}

CSetDlg::~CSetDlg()
{
}

void CSetDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Radio(pDX, IDC_RED_RADIO, m_RedRadio);
}


BEGIN_MESSAGE_MAP(CSetDlg, CDialogEx)
	ON_BN_CLICKED(IDC_RED_RADIO, &CSetDlg::OnBnClickedRedRadio)
	ON_BN_CLICKED(IDC_GREEN_RADIO, &CSetDlg::OnBnClickedGreenRadio)
	ON_BN_CLICKED(IDC_BLUE_RADIO, &CSetDlg::OnBnClickedBlueRadio)
END_MESSAGE_MAP()


// CSetDlg message handlers


void CSetDlg::OnBnClickedRedRadio()
{
	// TODO: Add your control notification handler code here
	UpdateData(TRUE);
}


BOOL CSetDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();



	return TRUE;  // return TRUE unless you set the focus to a control
				  // EXCEPTION: OCX Property Pages should return FALSE
}


void CSetDlg::OnBnClickedGreenRadio()
{
	UpdateData(TRUE);
	// TODO: Add your control notification handler code here
}


void CSetDlg::OnBnClickedBlueRadio()
{
	UpdateData(TRUE);
	// TODO: Add your control notification handler code here
}
