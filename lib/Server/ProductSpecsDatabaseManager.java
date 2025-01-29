import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductSpecsDatabaseManager {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/your_database_name";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin1234";

    static List<String> productSpecs = new ArrayList<>();

    public static void loadProductSpecsFromDatabase() {
        try (Connection connection = getConnection()) {
            System.out.println("Connected to the database!");

            String query = "SELECT * FROM ProductSpecs";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String productSpecString = constructProductSpecString(resultSet);
                productSpecs.add(productSpecString);
            }
            System.out.println("Product Specs loaded successfully");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String constructProductSpecString(ResultSet rs) throws SQLException {
        return rs.getInt("id") + "~" +
                rs.getString("phoneType") + "~" +
                rs.getString("model") + "~" +
                (rs.getDate("releaseDate") != null ? rs.getDate("releaseDate").toString() : "") + "~" +
                rs.getString("dimensions") + "~" +
                rs.getString("features");
    }

    public static void updateDatabase() {
        try (Connection connection = getConnection()) {
            connection.setAutoCommit(false);

            String insertQuery = "INSERT INTO ProductSpecs (id, phoneType, model, releaseDate, dimensions, features) " +
                    "VALUES (?, ?, ?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE " +
                    "phoneType=VALUES(phoneType), " +
                    "model=VALUES(model), " +
                    "releaseDate=VALUES(releaseDate), " +
                    "dimensions=VALUES(dimensions), " +
                    "features=VALUES(features)";

            try (PreparedStatement stmt = connection.prepareStatement(insertQuery)) {
                for (String productSpecString : productSpecs) {
                    setStatementParameters(stmt, productSpecString);
                    stmt.executeUpdate();
                }
                connection.commit();
                System.out.println("Database updated successfully");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void setStatementParameters(PreparedStatement stmt, String productSpecString) throws SQLException {
        String[] fields = productSpecString.split("~");

        // Set each parameter based on its type
        for (int i = 0; i < fields.length; i++) {
            switch (i) {
                case 0:  // id
                    stmt.setInt(i + 1, Integer.parseInt(fields[i]));
                    break;

                case 3:  // releaseDate
                    if (!fields[i].isEmpty()) {
                        stmt.setDate(i + 1, Date.valueOf(fields[i]));
                    } else {
                        stmt.setNull(i + 1, Types.DATE);
                    }
                    break;

                // String fields
                default:
                    stmt.setString(i + 1, fields[i]);
                    break;
            }
        }
    }

    public static void deleteProductSpec(String productSpecId) {
        try (Connection connection = getConnection()) {
            String deleteQuery = "DELETE FROM ProductSpecs WHERE id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(deleteQuery)) {
                stmt.setInt(1, Integer.parseInt(productSpecId));
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    System.out.println("Product Spec deleted from database successfully");
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