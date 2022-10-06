#pragma once

#include <iostream>
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#include <stdlib.h>
#include <string>
#include <sstream>

#pragma comment (lib, "Ws2_32.lib")
#pragma comment (lib, "Mswsock.lib")
#pragma comment (lib, "AdvApi32.lib")

constexpr auto BUFF_SIZE = 1024;

/// <summary>
/// Класс, определяющий клиент, который будет подключаться к серверу
/// </summary>
class Client {
public:
	Client();
	bool connectToServer(std::string, int);
	std::string getMsg();
	bool sendMsg(std::string);
	bool closeClient();
private:
	void initWinSoc();

	SOCKET connectSocket;
	struct addrinfo* result = NULL,
		* ptr = NULL,
		hints;
	std::string ip;
	int port;
	char buffer[BUFF_SIZE];
	bool isExit = false;
};

