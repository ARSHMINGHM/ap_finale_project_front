import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class CartDatabaseManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/Products";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin1234";

    static List<String> cartItems = new ArrayList<>();

    public static void loadCartFromDatabase() {
        try (Connection connection = getConnection()) {
            System.out.println("Connected to the database!");

            String query = "SELECT * FROM Cart";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String cartItemString = constructCartItemString(resultSet);
                cartItems.add(cartItemString);
            }
            System.out.println("Cart items loaded successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String constructCartItemString(ResultSet rs) throws SQLException {
        return rs.getInt("id") + "~" +
                rs.getInt("userId") + "~" +
                rs.getString("productIds") + "~" +
                rs.getInt("quantity") + "~" +
                (rs.getTimestamp("dateAdded") != null ? rs.getTimestamp("dateAdded").toString() : "");
    }

    public static void updateDatabase() {
        try (Connection connection = getConnection()) {
            connection.setAutoCommit(false);

            String insertQuery = "INSERT INTO Cart (id, userId, productIds, quantity, dateAdded) " +
                    "VALUES (?, ?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE " +
                    "userId=VALUES(userId), " +
                    "productIds=VALUES(productIds), " +
                    "quantity=VALUES(quantity), " +
                    "dateAdded=VALUES(dateAdded)";

            try (PreparedStatement stmt = connection.prepareStatement(insertQuery)) {
                for (String cartItemString : cartItems) {
                    setStatementParameters(stmt, cartItemString);
                    stmt.executeUpdate();
                }
                connection.commit();
                System.out.println("Database updated successfully");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void setStatementParameters(PreparedStatement stmt, String cartItemString) throws SQLException {
        String[] fields = cartItemString.split("~");

        // Set each parameter based on its type
        for (int i = 0; i < fields.length; i++) {
            switch (i) {
                case 0:  // id
                case 1:  // userId
                case 3:  // quantity
                    stmt.setInt(i + 1, Integer.parseInt(fields[i]));
                    break;

                case 2:  // productIds
                    stmt.setString(i + 1, fields[i]);
                    break;

                case 4:  // dateAdded
                    if (!fields[i].isEmpty()) {
                        stmt.setTimestamp(i + 1, Timestamp.valueOf(fields[i]));
                    } else {
                        stmt.setTimestamp(i + 1, new Timestamp(System.currentTimeMillis()));
                    }
                    break;
            }
        }
    }

    public static void deleteCartItem(String cartItemId) {
        try (Connection connection = getConnection()) {
            String deleteQuery = "DELETE FROM Cart WHERE id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
                stmt.setInt(1, Integer.parseInt(cartItemId));
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Cart item deleted from database successfully");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteCartItemsByUser(String userId) {
        try (Connection connection = getConnection()) {
            String deleteQuery = "DELETE FROM Cart WHERE userId = ?";
            try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
                stmt.setInt(1, Integer.parseInt(userId));
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Cart items for user deleted from database successfully");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to add a product to an existing cart
    public static void addProductToCart(int cartId, int productId) {
        try (Connection connection = getConnection()) {
            // Retrieve current productIds
            String selectQuery = "SELECT productIds FROM Cart WHERE id = ?";
            try (PreparedStatement selectStmt = connection.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, cartId);
                ResultSet rs = selectStmt.executeQuery();

                if (rs.next()) {
                    String currentProductIds = rs.getString("productIds");

                    // Check if product already exists
                    List<String> productIdList = new ArrayList<>(Arrays.asList(currentProductIds.split("-")));
                    if (!productIdList.contains(String.valueOf(productId))) {
                        productIdList.add(String.valueOf(productId));
                        String updatedProductIds = String.join("-", productIdList);

                        // Update cart with new product IDs
                        String updateQuery = "UPDATE Cart SET productIds = ? WHERE id = ?";
                        try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, updatedProductIds);
                            updateStmt.setInt(2, cartId);
                            updateStmt.executeUpdate();
                            System.out.println("Product added to cart successfully");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to remove a product from an existing cart
    public static void removeProductFromCart(int cartId, int productId) {
        try (Connection connection = getConnection()) {
            // Retrieve current productIds
            String selectQuery = "SELECT productIds FROM Cart WHERE id = ?";
            try (PreparedStatement selectStmt = connection.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, cartId);
                ResultSet rs = selectStmt.executeQuery();

                if (rs.next()) {
                    String currentProductIds = rs.getString("productIds");

                    // Remove specific product ID
                    List<String> productIdList = new ArrayList<>(Arrays.asList(currentProductIds.split("-")));
                    productIdList.remove(String.valueOf(productId));

                    String updatedProductIds = String.join("-", productIdList);

                    // Update cart with new product IDs
                    String updateQuery = "UPDATE Cart SET productIds = ? WHERE id = ?";
                    try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                        updateStmt.setString(1, updatedProductIds);
                        updateStmt.setInt(2, cartId);
                        updateStmt.executeUpdate();
                        System.out.println("Product removed from cart successfully");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}