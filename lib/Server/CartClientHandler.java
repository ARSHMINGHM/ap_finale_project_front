import java.io.*;
import java.net.Socket;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class CartClientHandler implements Runnable {
    private final Socket socket;
    private final BufferedReader in;
    private final PrintWriter out;

    public CartClientHandler(Socket socket) throws IOException {
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
                case "GET_CART_ITEMS":
                    sendCartItems();
                    break;
                case String s when s.startsWith("ADD_CART_ITEM"):
                    addCartItem(s.substring(14));
                    break;
                case String s when s.startsWith("DELETE_CART_ITEM"):
                    deleteCartItem(s.substring(17));
                    break;
                case String s when s.startsWith("ADD_PRODUCT_TO_CART"):
                    addProductToCart(s.substring(20));
                    break;
                case String s when s.startsWith("REMOVE_PRODUCT_FROM_CART"):
                    removeProductFromCart(s.substring(25));
                    break;
                case String s when s.startsWith("CLEAR_USER_CART"):
                    clearUserCart(s.substring(16));
                    break;
                default:
                    out.println("Unknown command");
            }
        }
    }

    private void sendCartItems() {
        CartDatabaseManager.cartItems.forEach(out::println);
        out.println("END_OF_CART_ITEMS");
    }

    private void addCartItem(String cartItemString) {
        CartDatabaseManager.cartItems.add(cartItemString);
        CartDatabaseManager.updateDatabase();
        out.println("Cart item added successfully");
    }

    private void deleteCartItem(String cartItemId) {
        boolean removed = false;
        Iterator<String> iterator = CartDatabaseManager.cartItems.iterator();

        while (iterator.hasNext()) {
            String cartItem = iterator.next();
            String[] fields = cartItem.split("~");
            if (fields[0].equals(cartItemId)) {
                iterator.remove();
                removed = true;
                break;
            }
        }

        if (removed) {
            CartDatabaseManager.deleteCartItem(cartItemId);
            out.println("Cart item deleted successfully");
        } else {
            out.println("Cart item not found");
        }
    }

    private void clearUserCart(String userId) {
        CartDatabaseManager.cartItems.removeIf(cartItem -> {
            String[] fields = cartItem.split("~");
            return fields[1].equals(userId);
        });

        CartDatabaseManager.deleteCartItemsByUser(userId);
        out.println("User cart cleared successfully");
    }

    private void addProductToCart(String params) {
        // Expecting format: cartId-productId
        String[] parts = params.split("-");
        if (parts.length == 2) {
            try {
                int cartId = Integer.parseInt(parts[0]);
                int productId = Integer.parseInt(parts[1]);
                CartDatabaseManager.addProductToCart(cartId, productId);
                out.println("Product added to cart successfully");
            } catch (NumberFormatException e) {
                out.println("Invalid cart or product ID");
            }
        } else {
            out.println("Invalid parameters");
        }
    }

    private void removeProductFromCart(String params) {
        // Expecting format: cartId-productId
        String[] parts = params.split("-");
        if (parts.length == 2) {
            try {
                int cartId = Integer.parseInt(parts[0]);
                int productId = Integer.parseInt(parts[1]);
                CartDatabaseManager.removeProductFromCart(cartId, productId);
                out.println("Product removed from cart successfully");
            } catch (NumberFormatException e) {
                out.println("Invalid cart or product ID");
            }
        } else {
            out.println("Invalid parameters");
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