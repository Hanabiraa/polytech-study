
// MFClab2.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'pch.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CMFClab2App:
// See MFClab2.cpp for the implementation of this class
//

class CMFClab2App : public CWinApp
{
public:
	CMFClab2App();

// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern CMFClab2App theApp;
