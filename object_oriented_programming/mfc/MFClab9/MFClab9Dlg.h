
// MFClab9Dlg.h : header file
//

#pragma once


// CMFClab9Dlg dialog
class CMFClab9Dlg : public CDialogEx
{
// Construction
public:
	CMFClab9Dlg(CWnd* pParent = nullptr);	// standard constructor

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFCLAB9_DIALOG };
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
	HICON m_Club = AfxGetApp()->LoadIcon(IDI_ICON4);
	HICON m_Diamond = AfxGetApp()->LoadIcon(IDI_ICON5);
	HICON m_Heart = AfxGetApp()->LoadIcon(IDI_ICON6);
	HICON m_Spade = AfxGetApp()->LoadIcon(IDI_ICON7);
	CStatic m_Card1;
	CStatic m_Card2;
	CStatic m_Card3;
	CStatic m_Card4;
	CStatic m_Amt_Left;
	double m_Amt_Remaining = 100.0;
	afx_msg void OnBnClickedDealcards();
	void DealCards();
	HICON& PickRandomCard();
	int m_Cards[5];
	void CalculateWinnings();
	afx_msg void OnBnClickedCancel();
};
