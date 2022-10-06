
// MFClab2Dlg.h : header file
//

#pragma once


// CMFClab2Dlg dialog
class CMFClab2Dlg : public CDialogEx
{
// Construction
public:
	CMFClab2Dlg(CWnd* pParent = nullptr);	// standard constructor

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFCLAB2_DIALOG };
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
	afx_msg void OnEnChangeEdit1();
	BOOL m_VisibleCheck;
	BOOL m_EnableCheck;
	CString m_TestEdit;
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnClickedExitButton();
	afx_msg void OnClickedTestButton();
	afx_msg void OnClickedClearButton();
	afx_msg void OnClickedVisibleCheck();
	afx_msg void OnClickedEnabledCheck();
	afx_msg void OnChangeTestEdit();
	afx_msg void OnStnClickedMfclab2Dialog();
};
