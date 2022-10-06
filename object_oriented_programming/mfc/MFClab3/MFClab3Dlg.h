
// MFClab3Dlg.h : header file
//

#pragma once


// CMFClab3Dlg dialog
class CMFClab3Dlg : public CDialogEx
{
// Construction
public:
	CMFClab3Dlg(CWnd* pParent = nullptr);	// standard constructor

	int m_PrevX;
	int m_PrevY;

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFCLAB3_DIALOG };
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
	afx_msg void OnStnClickedInstructionStatic();
	afx_msg void OnClickedExitButton();
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
};
