
// MFClab6Dlg.h : header file
//

#pragma once


// CMFClab6Dlg dialog
class CMFClab6Dlg : public CDialogEx
{
// Construction
public:
	CMFClab6Dlg(CWnd* pParent = nullptr);	// standard constructor

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFCLAB6_DIALOG };
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
	CString m_ResultsEdit;
	afx_msg void OnBnClickedExitButton();
	afx_msg void OnBnClickedOkcancelButton();
	afx_msg void OnBnClickedYesnocancelButton();
	afx_msg void OnBnClickedRetrycancelButton();
	afx_msg void OnBnClickedYesnoButton();
};
