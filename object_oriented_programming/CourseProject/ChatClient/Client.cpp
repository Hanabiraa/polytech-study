#include "pch.h"
#include "Client.h"

#include "Client.h"

using std::string;

void Client::initWinSoc()
{
	WSADATA wsaData;
	int status = WSAStartup(MAKEWORD(2, 2), &wsaData);
	if (status != 0)
	{
		std::cout << "Bad WinSoc initialize\n";
		exit(1);
	}
}

Client::Client()
{
	this->initWinSoc();
	this->connectSocket = socket(AF_INET, SOCK_STREAM, 0);
	memset(&this->hints, 0, sizeof(hints));
}

bool Client::connectToServer(string ip_addr, int port_num)
{
	this->ip = ip_addr;
	this->port = port_num;

	if (this->connectSocket == INVALID_SOCKET) {
		std::cout << "Bad socket\n";
		WSACleanup();
		return false;
	}

	int status = getaddrinfo("localhost", std::to_string(this->port).c_str(), &hints, &result);
	if (status != 0) {
		std::cout << "getaddrinfo failed with error: " << status << '\n';
		return false;
	}

	for (this->ptr = this->result; this->ptr != NULL; this->ptr = this->ptr->ai_next) {

		this->connectSocket = socket(this->ptr->ai_family, this->ptr->ai_socktype,
			this->ptr->ai_protocol);
		if (this->connectSocket == INVALID_SOCKET) {
			std::cout << "socket failed with error: " << WSAGetLastError() << '\n';
			WSACleanup();
			return false;
		}

		status = connect(this->connectSocket, ptr->ai_addr, (int)ptr->ai_addrlen);
		if (status == SOCKET_ERROR) {
			closesocket(this->connectSocket);
			this->connectSocket = INVALID_SOCKET;
			continue;
		}
		break;
	}
	freeaddrinfo(result);

	if (this->connectSocket == INVALID_SOCKET) {
		std::cout << "Unable to connect to server!\n";
		WSACleanup();
		return false;
	}
	return true;
}


std::string Client::getMsg()
{
	recv(this->connectSocket, buffer, BUFF_SIZE, 0);
	string msg = string(buffer);
	memset(this->buffer, ' ', BUFF_SIZE);;
	return msg;
}

bool Client::sendMsg(string msg)
{
	int status = send(this->connectSocket, msg.c_str(), BUFF_SIZE, 0);
	if (status == SOCKET_ERROR) {
		closesocket(this->connectSocket);
		WSACleanup();
		return false;
	}
	return true;
}

bool Client::closeClient()
{
	auto status = shutdown(this->connectSocket, SD_SEND);
	if (status == SOCKET_ERROR) {
		closesocket(this->connectSocket);
		WSACleanup();
		return false;
	}
	return true;
}
