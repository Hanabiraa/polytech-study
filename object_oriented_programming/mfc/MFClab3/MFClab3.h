
// MFClab3.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'pch.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CMFClab3App:
// See MFClab3.cpp for the implementation of this class
//

class CMFClab3App : public CWinApp
{
public:
	CMFClab3App();

// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern CMFClab3App theApp;
