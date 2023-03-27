package core;

import java.io.*;
import java.net.Socket;
import java.util.logging.Logger;


public class TCPClient {
    Logger logger = Logger.getLogger(TCPClient.class.getName());

    Socket server = null;

    BufferedReader consoleReader = null;
    BufferedWriter consoleWriter = null;

    BufferedReader serverReader = null;
    BufferedWriter serverWriter = null;

    public TCPClient(String address, int port) {
        try {
            server = new Socket(address, port);
            logger.info("connect to server");

            consoleReader = new BufferedReader(new InputStreamReader(System.in));
            consoleWriter = new BufferedWriter(new OutputStreamWriter(System.out));
            logger.info("setup console reader/writer");


            serverReader = new BufferedReader(new InputStreamReader(server.getInputStream()));
            serverWriter = new BufferedWriter(new OutputStreamWriter(server.getOutputStream()));
            logger.info("setup socket reader/writer");
        } catch (IOException i) {
            logger.warning("failed connect to server with: " + address + ":" + port + "\n" + i.toString());
        }
    }

    public void StartCommunication() {
        try {
            boolean RUN_LOOP = true;
            while (RUN_LOOP) {
                consoleWriter.write("client>");
                consoleWriter.flush();

                String msg = consoleReader.readLine();
                switch (msg) {
                    case "close" -> {
                        RUN_LOOP = false;
                        this.disconnect();
                    }
                    default -> this.sendMessage(msg);
                }
            }
        } catch (IOException i) {
            logger.warning(i.toString());
        }
    }

    private void sendMessage(String msg) {
        try {
            serverWriter.write(msg);
            serverWriter.newLine();
            serverWriter.flush();

            String fromServer = serverReader.readLine();
            consoleWriter.write("server>" + fromServer);
            consoleWriter.newLine();
            consoleWriter.flush();
        } catch (IOException i) {
            logger.warning(i.toString());
        }
    }

    private void disconnect() {
        try {
            serverWriter.write("close");
            serverWriter.newLine();
            serverWriter.flush();
            server.close();
            logger.info("disconnect from server");
        } catch (IOException i) {
            logger.warning(i.toString());
        }
    }
}