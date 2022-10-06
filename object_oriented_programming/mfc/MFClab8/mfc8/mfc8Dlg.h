
// mfc8Dlg.h : header file
//

#pragma once


// Cmfc8Dlg dialog
class Cmfc8Dlg : public CDialogEx
{
// Construction
public:
	Cmfc8Dlg(CWnd* pParent = nullptr);	// standard constructor

// Dialog Data
#ifdef AFX_DESIGN_TIME
	enum { IDD = IDD_MFC8_DIALOG };
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
	afx_msg void OnClearbtn();
private:
	CPoint m_LineEnd;
	CPoint m_LineStart;
public:
//	afx_msg void OnLButtonDblClk(UINT nFlags, CPoint point);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
private:
	COLORREF m_PenColor;
	CRect m_PenColorSwatch;
public:
//	afx_msg void OnStnClickedPencolor();
	afx_msg void OnPencolor();
private:
	CPen m_Pen;
public:
	int m_PenWidth;
	int m_PenStyle;
	CComboBox m_ShapesCombo;
private:
	void DrawShape(bool stretch=false);
public:
	bool m_IsDrawing;
	CBrush m_Brush;
	COLORREF m_BrushColor;
	CRect m_BrushColorSwatch;
	CRect m_BrushPreviewSwatch;
	int m_BrushStyle;
	CListBox m_BrushStyleList;
	afx_msg void OnSelchangeBrushstyle();
	void PaintBrushPreview();
	afx_msg void OnBrushcolor();
	CMetaFileDC* m_pMF;
	afx_msg void OnDestroy();
};
