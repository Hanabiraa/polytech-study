
// ChatClientDlg.h : header file
//
#pragma once
#include "Client.h"

// CChatClientDlg dialog
class CChatClientDlg : public CDialogEx
{
// Construction
public:
	CChatClientDlg(CWnd* pParent = nullptr);	// standard constructor
	Client client;

	static UINT __cdecl StaticThreadFunc(LPVOID pParam);
	UINT ThreadFunc();

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_CHATCLIENT_DIALOG };
#endif

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support


// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	// Client message, which need to be send to server
//	CString clientMsg;
	afx_msg void OnDestroy();
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	// for messages from server
	CListBox m_Chat;
	CString m_Msg;
	afx_msg void OnBnClickedSendbtn();
};
