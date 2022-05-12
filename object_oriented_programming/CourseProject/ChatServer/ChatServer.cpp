#include "Server.h"
#include "ChatServer.h"

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