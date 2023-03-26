package core;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class TCPServer {
    //initialize socket and input stream
    private Socket socket = null;
    private ServerSocket server = null;
    private DataInputStream in = null;
    private File file;
    private FileWriter fileWriter;

    // constructor with port
    public TCPServer(int port) {
        // starts server and waits for a connection
        try {
            server = new ServerSocket(port);
            System.out.println("Server started");

            System.out.println("Waiting for a client ...");

            socket = server.accept();
            System.out.println("Client accepted");

            // takes input from the client socket
            in = new DataInputStream(new BufferedInputStream(socket.getInputStream()));

            String line = "";
            int linecount = 0;

            file = new File("outfile.txt");
            fileWriter = new FileWriter(file);


            // reads message from client until "Over" is sent
            while (linecount++ != 300) {
                try {
                    line = in.readUTF();
                    System.out.println(line);
                    fileWriter.write(line);


                } catch (IOException i) {
                    System.out.println(i);
                }
            }
            System.out.println("Closing connection");
            fileWriter.flush();
            fileWriter.close();
            // close connection
            socket.close();
            in.close();
        } catch (IOException i) {
            System.out.println(i);
        }
    }
}
