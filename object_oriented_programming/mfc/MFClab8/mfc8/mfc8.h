
// mfc8.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'pch.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CPaintORamaApp:
// See mfc8.cpp for the implementation of this class
//

class CPaintORamaApp : public CWinApp
{
public:
	CPaintORamaApp();

// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern CPaintORamaApp theApp;
