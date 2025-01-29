import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class FavoriteProductsDatabaseManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/Products";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin1234";

    static List<String> favoriteProductItems = new ArrayList<>();

    public static void loadFavoriteProductsFromDatabase() {
        try (Connection connection = getConnection()) {
            System.out.println("Connected to the database!");

            String query = "SELECT * FROM FavoriteProducts";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String favoriteProductString = constructFavoriteProductString(resultSet);
                favoriteProductItems.add(favoriteProductString);
            }
            System.out.println("Favorite Products loaded successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String constructFavoriteProductString(ResultSet rs) throws SQLException {
        return rs.getInt("id") + "~" +
                rs.getInt("userId") + "~" +
                rs.getString("productIds") + "~" +
                rs.getInt("quantity");
    }

    public static void updateDatabase() {
        try (Connection connection = getConnection()) {
            connection.setAutoCommit(false);

            String insertQuery = "INSERT INTO FavoriteProducts (id, userId, productIds, quantity) " +
                    "VALUES (?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE " +
                    "userId=VALUES(userId), " +
                    "productIds=VALUES(productIds), " +
                    "quantity=VALUES(quantity)";

            try (PreparedStatement stmt = connection.prepareStatement(insertQuery)) {
                for (String favoriteProductString : favoriteProductItems) {
                    setStatementParameters(stmt, favoriteProductString);
                    stmt.executeUpdate();
                }
                connection.commit();
                System.out.println("Database updated successfully");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void setStatementParameters(PreparedStatement stmt, String favoriteProductString) throws SQLException {
        String[] fields = favoriteProductString.split("~");

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
            }
        }
    }

    public static void deleteFavoriteProductItem(String favoriteProductItemId) {
        try (Connection connection = getConnection()) {
            String deleteQuery = "DELETE FROM FavoriteProducts WHERE id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
                stmt.setInt(1, Integer.parseInt(favoriteProductItemId));
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Favorite Products item deleted from database successfully");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void deleteFavoriteProductItemsByUser(String userId) {
        try (Connection connection = getConnection()) {
            String deleteQuery = "DELETE FROM FavoriteProducts WHERE userId = ?";
            try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
                stmt.setInt(1, Integer.parseInt(userId));
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Favorite Products items for user deleted from database successfully");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to add a product to existing favorite products
    public static void addProductToFavorites(int favoriteProductId, int productId) {
        try (Connection connection = getConnection()) {
            // Retrieve current productIds
            String selectQuery = "SELECT productIds FROM FavoriteProducts WHERE id = ?";
            try (PreparedStatement selectStmt = connection.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, favoriteProductId);
                ResultSet rs = selectStmt.executeQuery();

                if (rs.next()) {
                    String currentProductIds = rs.getString("productIds");

                    // Check if product already exists
                    List<String> productIdList = new ArrayList<>(Arrays.asList(currentProductIds.split("-")));
                    if (!productIdList.contains(String.valueOf(productId))) {
                        productIdList.add(String.valueOf(productId));
                        String updatedProductIds = String.join("-", productIdList);

                        // Update favorite products with new product IDs
                        String updateQuery = "UPDATE FavoriteProducts SET productIds = ? WHERE id = ?";
                        try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                            updateStmt.setString(1, updatedProductIds);
                            updateStmt.setInt(2, favoriteProductId);
                            updateStmt.executeUpdate();
                            System.out.println("Product added to favorites successfully");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to remove a product from existing favorite products
    public static void removeProductFromFavorites(int favoriteProductId, int productId) {
        try (Connection connection = getConnection()) {
            // Retrieve current productIds
            String selectQuery = "SELECT productIds FROM FavoriteProducts WHERE id = ?";
            try (PreparedStatement selectStmt = connection.prepareStatement(selectQuery)) {
                selectStmt.setInt(1, favoriteProductId);
                ResultSet rs = selectStmt.executeQuery();

                if (rs.next()) {
                    String currentProductIds = rs.getString("productIds");

                    // Remove specific product ID
                    List<String> productIdList = new ArrayList<>(Arrays.asList(currentProductIds.split("-")));
                    productIdList.remove(String.valueOf(productId));

                    String updatedProductIds = String.join("-", productIdList);

                    // Update favorite products with new product IDs
                    String updateQuery = "UPDATE FavoriteProducts SET productIds = ? WHERE id = ?";
                    try (PreparedStatement updateStmt = connection.prepareStatement(updateQuery)) {
                        updateStmt.setString(1, updatedProductIds);
                        updateStmt.setInt(2, favoriteProductId);
                        updateStmt.executeUpdate();
                        System.out.println("Product removed from favorites successfully");
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