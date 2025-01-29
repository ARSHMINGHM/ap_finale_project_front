import java.io.*;
import java.net.Socket;
import java.util.Iterator;

public class ProductClientHandler implements Runnable {
    private final Socket socket;
    private final BufferedReader in;
    private final PrintWriter out;

    public ProductClientHandler(Socket socket) throws IOException {
        this.socket = socket;
        this.in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        this.out = new PrintWriter(socket.getOutputStream(), true);
        System.out.println("CONNECTED TO THE SERVER!");
    }

    @Override
    public void run() {
        try {
            handleClientCommands();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    private void handleClientCommands() throws IOException {
        String command;
        while ((command = in.readLine()) != null && !command.equals("EXIT")) {
            System.out.println("COMMAND RECEIVED: " + command);

            switch (command) {
                case "GET_PRODUCTS":
                    sendProducts();
                    break;
                case String s when s.startsWith("ADD_PRODUCT"):
                    addProduct(s.substring(12));
                    break;
                case String s when s.startsWith("DELETE_PRODUCT"):
                    deleteProduct(s.substring(15));
                    break;
                default:
                    out.println("Unknown command");
            }
        }
    }

    private void sendProducts() {
        ProductDatabaseManager.products.forEach(out::println);
        out.println("END_OF_PRODUCTS");
    }

    private void addProduct(String productString) {
        ProductDatabaseManager.products.add(productString);
        ProductDatabaseManager.updateDatabase();
        out.println("Product added successfully");
    }

    private void deleteProduct(String productId) {
        boolean removed = false;
        Iterator<String> iterator = ProductDatabaseManager.products.iterator();

        while (iterator.hasNext()) {
            String product = iterator.next();
            String[] fields = product.split("~");
            if (fields[0].equals(productId)) {
                iterator.remove();
                removed = true;
                break;
            }
        }

        if (removed) {
            ProductDatabaseManager.deleteProduct(productId);
            out.println("Product deleted successfully");
        } else {
            out.println("Product not found");
        }
    }

    private void closeConnections() {
        try {
            in.close();
            out.close();
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}