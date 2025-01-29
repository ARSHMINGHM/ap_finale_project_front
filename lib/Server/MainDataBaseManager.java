import java.io.*;
import java.sql.*;
import java.util.*;

public class MainDataBaseManager {
    // Product Database Constants
    private static final String DB_URL = "jdbc:mysql://localhost:3306/products";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin1234";

    // User File Constants
    private static final String USER_FILE_PATH = "C:\\ap_finale_project_front\\lib\\Server\\users.txt";
    private static int lastUserId = 1;

    // Product List
    static List<String> products = new ArrayList<>();

    // Product Database Methods
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
                rs.getString("price") + "~" +
                rs.getString("rating") + "~" +
                rs.getString("backgroundColor") + "~" +
                rs.getString("strcolor") + "~" +
                rs.getString("color") + "~" +
                rs.getString("img") + "~" +
                rs.getInt("discount") + "~" +
                rs.getBoolean("isAmazingOffer") + "~" +
                rs.getBoolean("isTopProduct") + "~" +
                rs.getInt("stock") + "~" +
                rs.getInt("soldCount") + "~" +
                rs.getFloat("productScore") + "~" +
                rs.getBoolean("isLiked") + "~" +
                rs.getString("category") + "~" +
                rs.getInt("specsId") + "~" +
                rs.getInt("quantity");
    }

    public static void updateProductDatabase() {
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

    private static void setStatementParameters(PreparedStatement stmt, String productString) throws SQLException {
        String[] fields = productString.split("~");
        for (int i = 0; i < fields.length; i++) {
            switch (i) {
                case 0:  case 9:  case 12: case 13: case 17: case 18:
                    stmt.setInt(i + 1, Integer.parseInt(fields[i]));
                    break;
                case 10: case 11: case 15:
                    stmt.setBoolean(i + 1, Boolean.parseBoolean(fields[i]));
                    break;
                case 14:
                    stmt.setFloat(i + 1, Float.parseFloat(fields[i]));
                    break;
                default:
                    stmt.setString(i + 1, fields[i]);
                    break;
            }
        }
    }

    private static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // User File Methods
    public static int userLogin(String username, String password) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(USER_FILE_PATH))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info.length >= 8) {
                    if (info[1].equals(username) && info[6].equals(password)) {
                        try {
                            return Integer.parseInt(info[0]);
                        } catch (NumberFormatException e) {
                            System.err.println("Error: Invalid user ID format.");
                            return -1;
                        }
                    }
                    lastUserId = Integer.parseInt(info[0]);
                }
                line = br.readLine();
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error: File not found - " + USER_FILE_PATH);
        }
        return -1;
    }

    public static int userSignUp(String username, String firstName, String lastName, String email, String password) throws IOException {
        boolean isUsernameDuplicate = false;
        boolean isEmailDuplicate = false;

        try (BufferedReader br = new BufferedReader(new FileReader(USER_FILE_PATH))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info.length >= 8) {
                    if (info[1].equals(username)) isUsernameDuplicate = true;
                    if (info[4].equals(email)) isEmailDuplicate = true;
                    lastUserId = Integer.parseInt(info[0]);
                }
                line = br.readLine();
            }
        }

        if (isUsernameDuplicate) return 400;
        if (isEmailDuplicate) return 401;

        lastUserId++;
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(USER_FILE_PATH, true))) {
            bw.write(lastUserId + "-" + username + "-" + firstName + "-" + lastName + "-" +
                    email + "-" + "09********" + "-" + password + "-" + "normal" + "-" + "\n");
            bw.flush();
        } catch (IOException e) {
            System.err.println("Error: An I/O error occurred while writing to the file.");
            return 500;
        }
        return 200;
    }

    // User Edit Methods
    public static int editUserName(String username, String firstName, String lastName) throws IOException {
        return updateUserFile(username, (info) -> {
            info[2] = firstName;
            info[3] = lastName;
        });
    }

    public static int editUserPhone(String username, String phone) throws IOException {
        return updateUserFile(username, (info) -> info[5] = phone);
    }

    public static int editUserEmail(String username, String email) throws IOException {
        return updateUserFile(username, (info) -> info[4] = email);
    }

    public static int editUserPassword(String username, String password) throws IOException {
        return updateUserFile(username, (info) -> info[6] = password);
    }

    public static int editUserSubscription(String username, String subscription) throws IOException {
        return updateUserFile(username, (info) -> info[7] = subscription);
    }

    public static int addUserAddress(String username, String address) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(USER_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] info = line.split("-");
                if (info.length > 1 && info[1].equals(username)) {
                    if (info.length > 8) {
                        List<String> addresses = new ArrayList<>(Arrays.asList(info[8].split(",")));
                        if (addresses.contains(address)) return 400;
                        fileLines.add(line + "," + address);
                    } else {
                        fileLines.add(line + address);
                    }
                    isUserFound = true;
                } else {
                    fileLines.add(line);
                }
            }
        }

        if (!isUserFound) return 404;

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(USER_FILE_PATH))) {
            for (String line : fileLines) {
                bw.write(line);
                bw.newLine();
            }
        }
        return 200;
    }

    // Helper interface for user file updates
    private interface UserInfoUpdater {
        void update(String[] info);
    }

    private static int updateUserFile(String username, UserInfoUpdater updater) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(USER_FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] info = line.split("-");
                if (info[1].equals(username)) {
                    updater.update(info);
                    line = String.join("-", info);
                    isUserFound = true;
                }
                fileLines.add(line);
            }
        }

        if (!isUserFound) return 404;

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(USER_FILE_PATH))) {
            for (String line : fileLines) {
                bw.write(line);
                bw.newLine();
            }
        }
        return 200;
    }
}