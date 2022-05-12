#pragma once

#include <iostream>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <string>
#include <sstream>
/*
* way of telling the VC++ compiler to link with library ws2_32.lib so on VC++
* it does this, and the code will work but unfortunately
* since Orwell Dev - Cpp does not have this capability you must perform this task
* manually by linking Ws2_32.lib to the project
*/
#pragma comment (lib, "ws2_32.lib")

class Server {
public:
	Server();
	void initializeWinSock();
	void createSocket();
	void bindSocket();
	void listenSocket();
	void createDescriptor();
	void run();

private:
	WSADATA wsData;
	WORD ver;
	SOCKET listening;
	sockaddr_in hint;
	fd_set master;
};