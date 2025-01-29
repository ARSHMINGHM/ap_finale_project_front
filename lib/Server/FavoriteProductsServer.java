import java.net.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class FavoriteProductsServer {
    private static final int PORT = 12346;  // Different port from previous servers

    public static void main(String[] args) throws Exception {
        // Initialize database
        FavoriteProductsDatabaseManager.loadFavoriteProductsFromDatabase();

        // Create server socket
        ServerSocket serverSocket = new ServerSocket(PORT);
        ExecutorService pool = Executors.newFixedThreadPool(10);

        System.out.println("WELCOME TO FAVORITE PRODUCTS SERVER!");

        while (true) {
            System.out.println("WAITING FOR CLIENT...");
            pool.execute(new FavoriteProductsClientHandler(serverSocket.accept()));
        }
    }
}