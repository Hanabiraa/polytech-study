
// MFClab7Dlg.h : header file
//

#pragma once
#include "CSetDlg.h"

// CMFClab7Dlg dialog
class CMFClab7Dlg : public CDialogEx
{
// Construction
public:
	CMFClab7Dlg(CWnd* pParent = nullptr);	// standard constructor
	CSetDlg m_dlg;

	int m_Radius;
	int m_Direction;
// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFCLAB7_DIALOG };
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
	afx_msg void OnBnClickedExitButton();
	afx_msg void OnDestroy();
	afx_msg void OnTimer(UINT_PTR nIDEvent);
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnBnClickedDrawgraphicsButton();
};
