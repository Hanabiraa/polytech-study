package core;

import java.io.*;
import java.net.Socket;
import java.util.logging.Logger;


public class TCPClient {
    Logger logger = Logger.getLogger(TCPClient.class.getName());

    Socket server = null;

    public TCPClient(String address, int port) {
        try {
            server = new Socket(address, port);
            logger.info("connect to server");
        } catch (IOException i) {
            logger.warning("failed connect to server with: " + address + ":" + port);
        }
    }

    public void StartCommunication() {
        try (
                BufferedReader consoleReader = new BufferedReader(new InputStreamReader(System.in));
                BufferedWriter consoleWriter = new BufferedWriter(new OutputStreamWriter(System.out))
        ) {
            StringBuilder greeting = new StringBuilder();
            greeting.append("commands:\n");
            greeting.append("1)send_message\n");
            greeting.append("2)close\n");
            greeting.append("command>");
            consoleWriter.write(greeting.toString());
            consoleWriter.flush();


            boolean RUN_LOOP = true;
            while (RUN_LOOP) {
                switch (consoleReader.readLine()) {
                    case "send_message" -> {
                        synchronized (this) {
                            this.sendMessage();
                        }
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

    private void sendMessage() {
        try (
                BufferedReader serverReader = new BufferedReader(new InputStreamReader(server.getInputStream()));
                BufferedWriter serverWriter = new BufferedWriter(new OutputStreamWriter(server.getOutputStream()));
                BufferedReader console = new BufferedReader(new InputStreamReader(System.in));
        ) {
            System.out.printf("%s", "client>");
            serverWriter.write(console.readLine());
            serverWriter.newLine();
            serverWriter.flush();

            String fromServer = serverReader.readLine();
            System.out.printf("%s%s\n", "server>", fromServer);
        } catch (IOException i) {
            logger.warning(i.toString());
        }
    }

    private void disconnect() {
        try (
                BufferedWriter serverWriter = new BufferedWriter(new OutputStreamWriter(server.getOutputStream()));
        ) {
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