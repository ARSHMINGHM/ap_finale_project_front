import java.io.*;
import java.net.Socket;
import java.util.Iterator;

public class ProductSpecsClientHandler implements Runnable {
    private final Socket socket;
    private final BufferedReader in;
    private final PrintWriter out;

    public ProductSpecsClientHandler(Socket socket) throws IOException {
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
                case "GET_PRODUCT_SPECS":
                    sendProductSpecs();
                    break;
                case String s when s.startsWith("ADD_PRODUCT_SPEC"):
                    addProductSpec(s.substring(17));
                    break;
                case String s when s.startsWith("DELETE_PRODUCT_SPEC"):
                    deleteProductSpec(s.substring(20));
                    break;
                default:
                    out.println("Unknown command");
            }
        }
    }

    private void sendProductSpecs() {
        ProductSpecsDatabaseManager.productSpecs.forEach(out::println);
        out.println("END_OF_PRODUCT_SPECS");
    }

    private void addProductSpec(String productSpecString) {
        ProductSpecsDatabaseManager.productSpecs.add(productSpecString);
        ProductSpecsDatabaseManager.updateDatabase();
        out.println("Product Spec added successfully");
    }

    private void deleteProductSpec(String productSpecId) {
        boolean removed = false;
        Iterator<String> iterator = ProductSpecsDatabaseManager.productSpecs.iterator();

        while (iterator.hasNext()) {
            String productSpec = iterator.next();
            String[] fields = productSpec.split("~");
            if (fields[0].equals(productSpecId)) {
                iterator.remove();
                removed = true;
                break;
            }
        }

        if (removed) {
            ProductSpecsDatabaseManager.deleteProductSpec(productSpecId);
            out.println("Product Spec deleted successfully");
        } else {
            out.println("Product Spec not found");
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