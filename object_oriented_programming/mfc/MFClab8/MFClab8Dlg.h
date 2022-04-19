
// MFClab8Dlg.h : header file
//

#pragma once


// CMFClab8Dlg dialog
class CMFClab8Dlg : public CDialogEx
{
// Construction
public:
	CMFClab8Dlg(CWnd* pParent = nullptr);	// standard constructor

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFCLAB8_DIALOG };
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
private:
	CRect m_Canvas;
public:
	afx_msg void OnBnClickedClearbtn();
private:
	CPoint m_LineEnd;
	CPoint m_LineStart;
public:
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
private:
	COLORREF m_PenColor;
	CRect m_PenColorSwatch;
public:
	afx_msg void OnStnClickedPencolor();
private:
	CPen m_Pen;
};
