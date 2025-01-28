import java.io.*;
import java.net.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import com.google.gson.*;
public class server {


    public static void main(String[] args) throws IOException {

        ServerSocket serverSocket = new ServerSocket(8080);
        ExecutorService pool = Executors.newFixedThreadPool(10);
        System.out.println("Server starting...");
        while (true) {
            pool.execute(new ClientHandler(serverSocket.accept()));
            //new ClientHandler(serverSocket.accept()).start();
        }

    }
}

