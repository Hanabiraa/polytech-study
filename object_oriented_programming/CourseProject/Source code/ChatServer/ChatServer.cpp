#include "Server.h"
#include "ChatServer.h"

/// <summary>
/// Точка входа программы, при успешном старте сервера - запускается
/// бесконечный цикл
/// </summary>
/// <returns>
/// int значение 0, иначе ошибка
/// </returns>
int main()
{
    Server server;
    server.initializeWinSock();
    server.createSocket();
    server.bindSocket();
    server.listenSocket();
    server.createDescriptor();
    server.run();
    return 0;
}