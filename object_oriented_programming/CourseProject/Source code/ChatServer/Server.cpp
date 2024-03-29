﻿#include "Server.h"

using std::string;
using std::cout;
using std::cin;
using std::ostringstream;


Server::Server()
{
	this->ver = MAKEWORD(2, 2);
}

/// <summary>
/// Инициализирует библиотеку WINSOC
/// </summary>
void Server::initializeWinSock()
{
	int status = WSAStartup(this->ver, &this->wsData);
	if (status != 0)
	{
		cout << "initializeWinSock: ERROR\n";
		exit(1);
	}
	cout << "initializeWinSock: SUCCESS\n";
}

/// <summary>
/// Метод, инициализирующий сокет и проверяющий его работоспособность
/// </summary>
void Server::createSocket()
{
	/*
	* AF_INET is used to specify the IPv4 address family.
	* SOCK_STREAM is used to specify a stream socket.
	*/
	this->listening = socket(AF_INET, SOCK_STREAM, 0);
	if (this->listening == INVALID_SOCKET)
	{
		cout << "createSocket: ERROR\n";
		exit(1);
	}
	cout << "createSocket: SUCCESS\n";
}

/// <summary>
/// Метод, привязывающий сокет с ipv4 адрессу и порту
/// </summary>
void Server::bindSocket()
{
	this->hint.sin_family = AF_INET;
	this->hint.sin_port = htons(27015);
	this->hint.sin_addr.S_un.S_addr = INADDR_ANY;

	int status = bind(this->listening, (sockaddr*)&this->hint, sizeof(hint));
	if (status == SOCKET_ERROR) {
		cout << "bindSocket: ERROR\n";
		exit(1);
	}
	cout << "bindSocket: SUCCESS\n";
}

/// <summary>
/// Метод, запускающий сокет на прослушивание, т.е. переводящий его в рабочее состояние
/// </summary>
void Server::listenSocket()
{
	int status = listen(this->listening, SOMAXCONN);
	if (status == SOCKET_ERROR) {
		cout << "listenSocket: ERROR\n";
		exit(1);
	}
	cout << "listenSocket: SUCCESS\n";
}

/// <summary>
/// Метод, создающий файловый дескриптор для асинхронного подклчения к серверу клиентов в неограниченном количестве
/// </summary>
void Server::createDescriptor()
{
	/*
	* create main server socket descriptor for listening clients
	*/
	this->master;
	FD_ZERO(&this->master);
	FD_SET(this->listening, &this->master);
}

/// <summary>
/// Основной метод сервера, в котором происходит подключение новых клиентов, чтение и рассылка сообщений между всеми клиентами
/// </summary>
void Server::run()
{
	cout << "\n\n--- Server running... ---\n";
	char ip[INET_ADDRSTRLEN];
	inet_ntop(AF_INET, &(this->hint.sin_addr), ip, INET_ADDRSTRLEN);
	cout << "server ip: " << string(ip) << '\n';
	cout << "server port: " << htons(this->hint.sin_port) << '\n';

	bool running = true;

	while (running)
	{
		fd_set copy = this->master;
		int socketCount = select(0, &copy, nullptr, nullptr, nullptr);

		for (int i = 0; i < socketCount; i++)
		{
			SOCKET sock = copy.fd_array[i];

			if (sock == this->listening)
			{
				SOCKET client = accept(this->listening, nullptr, nullptr);

				FD_SET(client, &this->master);

				string welcomeMsg = "SERVER: Hello!\r\n";
				send(client, welcomeMsg.c_str(), welcomeMsg.size() + 1, 0);
			}
			else
			{
				char buf[4096];
				ZeroMemory(buf, 4096);

				int bytesIn = recv(sock, buf, 4096, 0);
				if (bytesIn <= 0)
				{
					closesocket(sock);
					FD_CLR(sock, &this->master);
				}
				else
				{
					if (buf[0] == '\\')
					{
						string cmd = string(buf, bytesIn);
						if (cmd == "\\quit")
						{
							running = false;
							break;
						}
						continue;
					}
					for (int i = 0; i < this->master.fd_count; i++)
					{
						SOCKET outSock = this->master.fd_array[i];
						if (outSock == this->listening) {
							continue;
						}
						ostringstream ss;
						if (outSock != sock)
						{
							ss << "SOCKET #" << sock << ": ";
						}
						else {
							ss << "Me: ";
						}
						ss << buf << "\r\n";
						string strOut = ss.str();
						send(outSock, strOut.c_str(), strOut.size() + 1, 0);
					}
				}
			}
		}
	}

	FD_CLR(this->listening, &this->master);
	closesocket(this->listening);

	string msg = "Server is shutting down. Goodbye\r\n";

	while (this->master.fd_count > 0)
	{
		SOCKET sock = this->master.fd_array[0];
		send(sock, msg.c_str(), msg.size() + 1, 0);
		FD_CLR(sock, &this->master);
		closesocket(sock);
	}

	WSACleanup();
}
