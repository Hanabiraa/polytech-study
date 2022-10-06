
// MFClab5Dlg.h : header file
//

#pragma once


// CMFClab5Dlg dialog
class CMFClab5Dlg : public CDialogEx
{
// Construction
public:
	CMFClab5Dlg(CWnd* pParent = nullptr);	// standard constructor

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFCLAB5_DIALOG };
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
	int m_SpeedEdit=0;
	afx_msg void OnChangeSpeedEdit();
	afx_msg void OnFileCurrentspeed();
	afx_msg void OnFileExit();
	afx_msg void OnHelpAbout();
};
