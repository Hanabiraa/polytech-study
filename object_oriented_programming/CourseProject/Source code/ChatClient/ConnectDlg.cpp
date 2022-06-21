// ConnectDlg.cpp : implementation file
//

#include "pch.h"
#include "ChatClient.h"
#include "afxdialogex.h"
#include "ConnectDlg.h"


// ConnectDlg dialog

IMPLEMENT_DYNAMIC(ConnectDlg, CDialogEx)

ConnectDlg::ConnectDlg(CWnd* pParent /*=nullptr*/)
	: CDialogEx(IDD_CONNECT_CHAT, pParent)
	, m_ipv4_input(_T(""))
	, m_port_input(0)
{

}

ConnectDlg::~ConnectDlg()
{
}

void ConnectDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_IPV4_INPUT, m_ipv4_input);
	DDV_MaxChars(pDX, m_ipv4_input, 10);
	DDX_Text(pDX, IDC_PORT_INPUT, m_port_input);
	DDV_MinMaxInt(pDX, m_port_input, 0, 90000);
}


BEGIN_MESSAGE_MAP(ConnectDlg, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON1, &ConnectDlg::OnBnClickedButton1)
END_MESSAGE_MAP()


// ConnectDlg message handlers


void ConnectDlg::OnBnClickedButton1()
{
	// TODO: Add your control notification handler code here
	OnOK();
}
