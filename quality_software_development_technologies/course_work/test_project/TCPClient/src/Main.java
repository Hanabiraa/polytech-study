import core.TCPClient;

public class Main {
    public static void main(String[] args) {
        TCPClient client = new TCPClient("0.0.0.0", 5678);
        client.StartCommunication();
    }
}
