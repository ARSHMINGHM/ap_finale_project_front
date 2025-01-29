import java.net.*;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Iterator;

public class ServerTestProduct {

    static List<String> products = new ArrayList<>(); // for saving products info as strings

    public static void main(String[] args) throws Exception {
        loadProductsFromDatabase();

        // Server socket setup
        System.out.println("WELCOME TO SERVER!");
        ServerSocket ss = new ServerSocket(12345);

        while (true) {
            System.out.println("WAITING FOR CLIENT...");
            Socket socket = ss.accept();
            new Thread(new ClientHandler(socket)).start();
        }
    }
    static void loadProductsFromDatabase() {
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "admin1234")) {
            System.out.println("Connected to the database!");

            String query = "SELECT * FROM Products";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String productString = resultSet.getInt("id") + "~" +
                        resultSet.getString("title") + "~" +
                        resultSet.getString("fullPrice") + "~" +
                        resultSet.getString("price") + "~" +
                        resultSet.getString("rating") + "~" +
                        resultSet.getString("backgroundColor") + "~" +
                        resultSet.getString("strcolor") + "~" +
                        resultSet.getString("color") + "~" +
                        resultSet.getString("img") + "~" +
                        resultSet.getInt("discount") + "~" +
                        resultSet.getBoolean("isAmazingOffer") + "~" +
                        resultSet.getBoolean("isTopProduct") + "~" +
                        resultSet.getInt("stock") + "~" +
                        resultSet.getInt("soldCount") + "~" +
                        resultSet.getFloat("productScore") + "~" +
                        resultSet.getBoolean("isLiked") + "~" +
                        resultSet.getString("category") + "~" +
                        resultSet.getInt("specsId") + "~" +
                        resultSet.getInt("quantity");

                products.add(productString);
            }
            System.out.println("Products loaded successfully");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    static class ClientHandler implements Runnable {
        private Socket socket;
        private BufferedReader in;
        private PrintWriter out;

        public ClientHandler(Socket socket) throws IOException {
            this.socket = socket;
            this.in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            this.out = new PrintWriter(socket.getOutputStream(), true);
            System.out.println("CONNECTED TO THE SERVER!");
        }

        @Override
        public void run() {
            try {
                String command;
                while ((command = in.readLine()) != null && !command.equals("EXIT")) {
                    System.out.println("COMMAND RECEIVED: " + command);

                    if (command.equals("GET_PRODUCTS")) {
                        sendProducts();
                    } else if (command.startsWith("ADD_PRODUCT")) {
                        addProduct(command.substring(12)); // Remove "ADD_PRODUCT " from the start
                    } else if (command.startsWith("DELETE_PRODUCT")) {
                        deleteProduct(command.substring(15)); // Remove "DELETE_PRODUCT " from the start
                    } else {
                        out.println("Unknown command");
                    }
                }

                System.out.println("Client disconnected");
                in.close();
                out.close();
                socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        private void sendProducts() {
            for (String product : products) {
                out.println(product);
            }
            out.println("END_OF_PRODUCTS");
        }

        private void addProduct(String productString) {
            products.add(productString);
            updateDatabase();
            out.println("Product added successfully");
        }

        private void deleteProduct(String productId) {
            boolean removed = false;
            Iterator<String> iterator = products.iterator();
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
                deleteProductFromDatabase(productId);
                out.println("Product deleted successfully");
            } else {
                out.println("Product not found");
            }
        }

        private void deleteProductFromDatabase(String productId) {
            Connection connection = null;
            try {
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "admin1234");
                String deleteQuery = "DELETE FROM Products WHERE id = ?";
                PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
                deleteStatement.setInt(1, Integer.parseInt(productId));
                int rowsAffected = deleteStatement.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Product deleted from database successfully");
                } else {
                    System.out.println("No product found in database with id: " + productId);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (connection != null) {
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    public static void updateDatabase() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "admin1234");
            connection.setAutoCommit(false);  // Start transaction

            String insertQuery = "INSERT INTO Products (id, title, fullPrice, price, rating, backgroundColor, strcolor, color, img, discount, isAmazingOffer, isTopProduct, stock, soldCount, productScore, isLiked, category, specsId, quantity) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE title=VALUES(title), fullPrice=VALUES(fullPrice), price=VALUES(price), rating=VALUES(rating), backgroundColor=VALUES(backgroundColor), strcolor=VALUES(strcolor), color=VALUES(color), img=VALUES(img), discount=VALUES(discount), isAmazingOffer=VALUES(isAmazingOffer), isTopProduct=VALUES(isTopProduct), stock=VALUES(stock), soldCount=VALUES(soldCount), productScore=VALUES(productScore), isLiked=VALUES(isLiked), category=VALUES(category), specsId=VALUES(specsId), quantity=VALUES(quantity)";
            PreparedStatement insertStatement = connection.prepareStatement(insertQuery);

            for (String productString : products) {
                String[] fields = productString.split("~");
                for (int i = 0; i < fields.length; i++) {
                    if (i == 0 || i == 9 || i == 12 || i == 13 || i == 17 || i == 18) {
                        insertStatement.setInt(i + 1, Integer.parseInt(fields[i]));
                    } else if (i == 10 || i == 11 || i == 15) {
                        insertStatement.setBoolean(i + 1, Boolean.parseBoolean(fields[i]));
                    } else if (i == 14) {
                        insertStatement.setFloat(i + 1, Float.parseFloat(fields[i]));
                    } else {
                        insertStatement.setString(i + 1, fields[i]);
                    }
                }
                insertStatement.executeUpdate();
            }

            connection.commit();  // Commit the transaction
            System.out.println("Database updated successfully");

        } catch (SQLException e) {
            e.printStackTrace();
            if (connection != null) {
                try {
                    connection.rollback();  // Rollback in case of error
                    System.out.println("Database update rolled back due to error");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}