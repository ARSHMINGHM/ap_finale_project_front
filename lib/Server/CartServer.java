import java.net.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CartServer {
    private static final int PORT = 12345;

    public static void main(String[] args) throws Exception {
        // Initialize database
        CartDatabaseManager.loadCartFromDatabase();

        // Create server socket
        ServerSocket serverSocket = new ServerSocket(PORT);
        ExecutorService pool = Executors.newFixedThreadPool(10);

        System.out.println("WELCOME TO CART SERVER!");

        while (true) {
            System.out.println("WAITING FOR CLIENT...");
            pool.execute(new CartClientHandler(serverSocket.accept()));
        }
    }
}