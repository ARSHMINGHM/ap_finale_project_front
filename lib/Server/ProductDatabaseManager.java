import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDatabaseManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/products";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin1234";

    static List<String> products = new ArrayList<>();

    public static void loadProductsFromDatabase() {
        try (Connection connection = getConnection()) {
            System.out.println("Connected to the database!");

            String query = "SELECT * FROM Products";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String productString = constructProductString(resultSet);
                products.add(productString);
            }
            System.out.println("Products loaded successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String constructProductString(ResultSet rs) throws SQLException {
        return rs.getInt("id") + "~" +
                rs.getString("title") + "~" +
                rs.getString("fullPrice") + "~" +
                // ... rest of the fields ...
                rs.getInt("quantity");
    }


    public static void updateDatabase() {
        try (Connection connection = getConnection()) {
            connection.setAutoCommit(false);

            String insertQuery = "INSERT INTO Products (id, title, fullPrice, price, rating, backgroundColor, " +
                    "strcolor, color, img, discount, isAmazingOffer, isTopProduct, stock, soldCount, " +
                    "productScore, isLiked, category, specsId, quantity) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE title=VALUES(title), fullPrice=VALUES(fullPrice), " +
                    "price=VALUES(price), rating=VALUES(rating), backgroundColor=VALUES(backgroundColor), " +
                    "strcolor=VALUES(strcolor), color=VALUES(color), img=VALUES(img), " +
                    "discount=VALUES(discount), isAmazingOffer=VALUES(isAmazingOffer), " +
                    "isTopProduct=VALUES(isTopProduct), stock=VALUES(stock), " +
                    "soldCount=VALUES(soldCount), productScore=VALUES(productScore), " +
                    "isLiked=VALUES(isLiked), category=VALUES(category), specsId=VALUES(specsId), " +
                    "quantity=VALUES(quantity)";

            try (PreparedStatement stmt = connection.prepareStatement(insertQuery)) {
                for (String productString : products) {
                    setStatementParameters(stmt, productString);
                    stmt.executeUpdate();
                }
                connection.commit();
                System.out.println("Database updated successfully");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void setStatementParameters(PreparedStatement stmt, String productString) throws SQLException {
        String[] fields = productString.split("~");

        // Set each parameter based on its type
        for (int i = 0; i < fields.length; i++) {
            switch (i) {
                // Integer fields
                case 0:  // id
                case 9:  // discount
                case 12: // stock
                case 13: // soldCount
                case 17: // specsId
                case 18: // quantity
                    stmt.setInt(i + 1, Integer.parseInt(fields[i]));
                    break;

                // Boolean fields
                case 10: // isAmazingOffer
                case 11: // isTopProduct
                case 15: // isLiked
                    stmt.setBoolean(i + 1, Boolean.parseBoolean(fields[i]));
                    break;

                // Float field
                case 14: // productScore
                    stmt.setFloat(i + 1, Float.parseFloat(fields[i]));
                    break;

                // String fields (all others)
                default:
                    stmt.setString(i + 1, fields[i]);
                    break;
            }
        }
    }
    public static void deleteProduct(String productId) {
        try (Connection connection = getConnection()) {
            String deleteQuery = "DELETE FROM Products WHERE id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
                stmt.setInt(1, Integer.parseInt(productId));
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Product deleted from database successfully");
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