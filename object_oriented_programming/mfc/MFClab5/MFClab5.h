
// MFClab5.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'pch.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CMFClab5App:
// See MFClab5.cpp for the implementation of this class
//

class CMFClab5App : public CWinApp
{
public:
	CMFClab5App();

// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
	afx_msg void OnFileCurrentspeed();
};

extern CMFClab5App theApp;
