package core;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.logging.Logger;

public class TCPServer {
    Logger logger = Logger.getLogger(TCPServer.class.getName());

    ServerSocket ss;
    Socket client;

    public TCPServer(int port) {
        try {
            ss = new ServerSocket(port);
            logger.info("Server listen on port: " + ss.getLocalPort());
        } catch (IOException i) {
            logger.warning(i.toString());
        }
    }

    public void Listening() {
        while (true) {
            try {
                client = ss.accept();
                logger.info("Client connect: " + client.getInetAddress() + ":" + client.getLocalPort());
                this.ListenClientMessages();
            } catch (IOException i) {
                logger.warning("Client connection failed");
                logger.warning(i.toString());
            }
        }
    }

    private void ListenClientMessages() {
        try (
                BufferedReader clientReader = new BufferedReader(new InputStreamReader(client.getInputStream()));
                BufferedWriter clientWriter = new BufferedWriter(new OutputStreamWriter(client.getOutputStream()));
        ) {
            String line;
            while (!"close".equals(line = clientReader.readLine())) {
                // client died by SIGKILL
                if (line == null) {
                    break;
                }
                logger.info("Client sent: " + line);

                String[] tokens = line.split("[ .,]+");

                clientWriter.write(tokens[ThreadLocalRandom.current().nextInt(0, tokens.length)]+"?");
                clientWriter.newLine();
                clientWriter.flush();
            }
            client.close();
            logger.info("Client disconnect");
        } catch (IOException i) {
            logger.warning(i.toString());
        }
    }
}