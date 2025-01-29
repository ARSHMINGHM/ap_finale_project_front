import java.net.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ProductSpecsServer {
    private static final int PORT = 12345;

    public static void main(String[] args) throws Exception {
        // Initialize database
        ProductSpecsDatabaseManager.loadProductSpecsFromDatabase();

        // Create server socket
        ServerSocket serverSocket = new ServerSocket(PORT);
        ExecutorService pool = Executors.newFixedThreadPool(10);

        System.out.println("WELCOME TO PRODUCT SPECS SERVER!");

        while (true) {
            System.out.println("WAITING FOR CLIENT...");
            pool.execute(new ProductSpecsClientHandler(serverSocket.accept()));
        }
    }
}