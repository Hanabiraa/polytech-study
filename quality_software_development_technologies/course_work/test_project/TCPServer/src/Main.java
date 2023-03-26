import core.TCPServer;

public class Main {
    public static void main(String[] args) {
        TCPServer server = new TCPServer(5678);
        server.Listening();
    }
}
