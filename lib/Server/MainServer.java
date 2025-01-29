import java.io.*;
import java.net.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import com.google.gson.*;

public class MainServer {
    private static final int USER_PORT = 8080;
    private static final int PRODUCT_PORT = 12345;

    public static void main(String[] args) {
        try {
            // Initialize database for products
            MainDataBaseManager.loadProductsFromDatabase();

            // Create server sockets for both services
            ServerSocket userServerSocket = new ServerSocket(USER_PORT);
            ServerSocket productServerSocket = new ServerSocket(PRODUCT_PORT);

            // Create thread pools for both services
            ExecutorService serverPool = Executors.newFixedThreadPool(20);

            System.out.println("Main Server starting...");
            System.out.println("User service running on port " + USER_PORT);
            System.out.println("Product service running on port " + PRODUCT_PORT);

            // Start separate threads for handling each service
            new Thread(() -> handleConnections(userServerSocket, serverPool, "user")).start();
            new Thread(() -> handleConnections(productServerSocket, serverPool, "product")).start();

        } catch (IOException e) {
            System.err.println("Server startup failed: " + e.getMessage());
        }
    }

    private static void handleConnections(ServerSocket serverSocket, ExecutorService pool, String serviceType) {
        while (true) {
            try {
                System.out.println("Waiting for " + serviceType + " client...");
                Socket clientSocket = serverSocket.accept();
                pool.execute(new MainClientHandler(clientSocket));
            } catch (IOException e) {
                System.err.println("Error accepting " + serviceType + " client: " + e.getMessage());
            }
        }
    }

    // Optional: Method to gracefully shutdown the server
    private static void shutdown(ExecutorService pool) {
        try {
            System.out.println("Shutting down server...");
            pool.shutdown();
        } catch (Exception e) {
            System.err.println("Error during shutdown: " + e.getMessage());
        }
    }
}