
// MFClab6.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'pch.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CMFClab6App:
// See MFClab6.cpp for the implementation of this class
//

class CMFClab6App : public CWinApp
{
public:
	CMFClab6App();

// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern CMFClab6App theApp;
