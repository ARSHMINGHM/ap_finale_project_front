import java.io.*;
import java.net.Socket;
import java.util.Iterator;

public class FavoriteProductsClientHandler implements Runnable {
    private final Socket socket;
    private final BufferedReader in;
    private final PrintWriter out;

    public FavoriteProductsClientHandler(Socket socket) throws IOException {
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
                case "GET_FAVORITE_PRODUCTS":
                    sendFavoriteProducts();
                    break;
                case String s when s.startsWith("ADD_FAVORITE_PRODUCT_ITEM"):
                    addFavoriteProductItem(s.substring(26));
                    break;
                case String s when s.startsWith("DELETE_FAVORITE_PRODUCT_ITEM"):
                    deleteFavoriteProductItem(s.substring(29));
                    break;
                case String s when s.startsWith("ADD_PRODUCT_TO_FAVORITES"):
                    addProductToFavorites(s.substring(25));
                    break;
                case String s when s.startsWith("REMOVE_PRODUCT_FROM_FAVORITES"):
                    removeProductFromFavorites(s.substring(30));
                    break;
                case String s when s.startsWith("CLEAR_USER_FAVORITES"):
                    clearUserFavorites(s.substring(21));
                    break;
                default:
                    out.println("Unknown command");
            }
        }
    }

    private void sendFavoriteProducts() {
        FavoriteProductsDatabaseManager.favoriteProductItems.forEach(out::println);
        out.println("END_OF_FAVORITE_PRODUCTS");
    }

    private void addFavoriteProductItem(String favoriteProductItemString) {
        FavoriteProductsDatabaseManager.favoriteProductItems.add(favoriteProductItemString);
        FavoriteProductsDatabaseManager.updateDatabase();
        out.println("Favorite Product item added successfully");
    }

    private void deleteFavoriteProductItem(String favoriteProductItemId) {
        boolean removed = false;
        Iterator<String> iterator = FavoriteProductsDatabaseManager.favoriteProductItems.iterator();

        while (iterator.hasNext()) {
            String favoriteProductItem = iterator.next();
            String[] fields = favoriteProductItem.split("~");
            if (fields[0].equals(favoriteProductItemId)) {
                iterator.remove();
                removed = true;
                break;
            }
        }

        if (removed) {
            FavoriteProductsDatabaseManager.deleteFavoriteProductItem(favoriteProductItemId);
            out.println("Favorite Product item deleted successfully");
        } else {
            out.println("Favorite Product item not found");
        }
    }

    private void clearUserFavorites(String userId) {
        FavoriteProductsDatabaseManager.favoriteProductItems.removeIf(favoriteProductItem -> {
            String[] fields = favoriteProductItem.split("~");
            return fields[1].equals(userId);
        });

        FavoriteProductsDatabaseManager.deleteFavoriteProductItemsByUser(userId);
        out.println("User favorites cleared successfully");
    }

    private void addProductToFavorites(String params) {
        // Expecting format: favoriteProductId-productId
        String[] parts = params.split("-");
        if (parts.length == 2) {
            try {
                int favoriteProductId = Integer.parseInt(parts[0]);
                int productId = Integer.parseInt(parts[1]);
                FavoriteProductsDatabaseManager.addProductToFavorites(favoriteProductId, productId);
                out.println("Product added to favorites successfully");
            } catch (NumberFormatException e) {
                out.println("Invalid favorite product or product ID");
            }
        } else {
            out.println("Invalid parameters");
        }
    }

    private void removeProductFromFavorites(String params) {
        // Expecting format: favoriteProductId-productId
        String[] parts = params.split("-");
        if (parts.length == 2) {
            try {
                int favoriteProductId = Integer.parseInt(parts[0]);
                int productId = Integer.parseInt(parts[1]);
                FavoriteProductsDatabaseManager.removeProductFromFavorites(favoriteProductId, productId);
                out.println("Product removed from favorites successfully");
            } catch (NumberFormatException e) {
                out.println("Invalid favorite product or product ID");
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