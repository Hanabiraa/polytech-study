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
            logger.warning("failed connect to server with: " + address + ":" + port);
            logger.warning(i.toString());
        }
    }

    public void StartCommunication() {
        try {
            StringBuilder greeting = new StringBuilder();
            greeting.append("commands:\n");
            greeting.append("1)send_message\n");
            greeting.append("2)close\n");
            consoleWriter.write(greeting.toString());
            consoleWriter.flush();


            boolean RUN_LOOP = true;
            while (RUN_LOOP) {
                consoleWriter.write("command>");
                consoleWriter.flush();
                switch (consoleReader.readLine()) {
                    case "send_message" -> {
                        consoleWriter.write("client>");
                        consoleWriter.flush();
                        this.sendMessage(consoleReader.readLine());
                    }
                    case "close" -> {
                        RUN_LOOP = false;
                        this.disconnect();
                    }
                    default -> {
                        consoleWriter.write("Bad command, Try again");
                        consoleWriter.newLine();
                        consoleWriter.flush();
                    }
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
            System.out.printf("%s%s\n", "server>", fromServer);
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