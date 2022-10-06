#pragma once
#include "afxdialogex.h"


// ConnectDlg dialog

class ConnectDlg : public CDialogEx
{
	DECLARE_DYNAMIC(ConnectDlg)

public:
	ConnectDlg(CWnd* pParent = nullptr);   // standard constructor
	virtual ~ConnectDlg();

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_CONNECT_CHAT };
#endif

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
public:
	CString m_ipv4_input;
	int m_port_input;
	afx_msg void OnBnClickedButton1();
};
