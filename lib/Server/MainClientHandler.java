import java.io.*;
import java.net.Socket;
import java.util.*;
import com.google.gson.*;

public class MainClientHandler implements Runnable {
    private final Socket socket;
    private final BufferedReader in;
    private final DataOutputStream out;
    private static final String USER_FILE_PATH = "C:\\ap_finale_project_front\\lib\\Server\\users.txt";

    public UnifiedClientHandler(Socket socket) throws IOException {
        this.socket = socket;
        this.in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        this.out = new DataOutputStream(socket.getOutputStream());
        System.out.println("Client connected to server!");
    }

    @Override
    public void run() {
        try {
            handleClientCommands();
        } catch (IOException e) {
            System.err.println("Error handling client: " + e.getMessage());
        } finally {
            closeConnections();
        }
    }

    private void handleClientCommands() throws IOException {
        String command;
        while ((command = in.readLine()) != null && !command.equalsIgnoreCase("exit")) {
            System.out.println("Request from client: " + command);

            // User Management Commands
            if (command.startsWith("login")) {
                handleLogin(command);
            } else if (command.startsWith("signUp")) {
                handleSignUp(command);
            } else if (command.startsWith("editName")) {
                handleEditName(command);
            } else if (command.startsWith("editPhone")) {
                handleEditPhone(command);
            } else if (command.startsWith("editEmail")) {
                handleEditEmail(command);
            } else if (command.startsWith("editPassword")) {
                handleEditPassword(command);
            } else if (command.startsWith("editSubscription")) {
                handleEditSubscription(command);
            } else if (command.startsWith("AddAddress")) {
                handleAddAddress(command);
            }
            // Product Management Commands
            else if (command.equals("GET_PRODUCTS")) {
                sendProducts();
            } else if (command.startsWith("ADD_PRODUCT")) {
                handleAddProduct(command.substring(12));
            } else if (command.startsWith("DELETE_PRODUCT")) {
                handleDeleteProduct(command.substring(15));
            } else {
                out.writeBytes("Invalid command\n");
            }
        }
    }

    // User Management Methods
    private void handleLogin(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            out.writeBytes("Invalid login command\n");
            return;
        }
        String username = parts[1];
        String password = parts[2];
        int userId = DatabaseManager.userLogin(username, password);

        if (userId != -1) {
            String userInfoJson = getUserInfoJson(username);
            if (userInfoJson.equals("not found")) {
                out.writeBytes("User data retrieval error\n");
            } else {
                out.writeBytes(userInfoJson + "\n");
            }
        } else {
            out.writeBytes("Invalid credentials\n");
        }
    }

    private void handleSignUp(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 6) {
            out.writeBytes("Invalid signUp command\n");
            return;
        }

        String username = parts[1];
        String fname = parts[2];
        String lname = parts[3];
        String email = parts[4];
        String password = parts[5];

        int status = DatabaseManager.userSignUp(username, fname, lname, email, password);
        if (status == 200) {
            String userInfoJson = getUserInfoJson(username);
            out.writeBytes(userInfoJson + "\n");
        } else if (status == 400) {
            out.writeBytes("This user name already exists\n");
        } else if (status == 401) {
            out.writeBytes("This email already exists\n");
        } else {
            out.writeBytes("Invalid credentials\n");
        }
    }

    // User Edit Methods
    private void handleEditName(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 4) {
            out.writeBytes("Invalid editName command\n");
            return;
        }
        int status = DatabaseManager.editUserName(parts[1], parts[2], parts[3]);
        out.writeBytes(status == 200 ? "Edit name successful\n" : "Edit name failed or user not found\n");
    }

    private void handleEditPhone(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            out.writeBytes("Invalid editPhone command\n");
            return;
        }
        int status = DatabaseManager.editUserPhone(parts[1], parts[2]);
        sendEditResponse(status, "phone");
    }

    private void handleEditEmail(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            out.writeBytes("Invalid editEmail command\n");
            return;
        }
        int status = DatabaseManager.editUserEmail(parts[1], parts[2]);
        sendEditResponse(status, "email");
    }

    private void handleEditPassword(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            out.writeBytes("Invalid editPassword command\n");
            return;
        }
        int status = DatabaseManager.editUserPassword(parts[1], parts[2]);
        sendEditResponse(status, "password");
    }

    private void handleEditSubscription(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            out.writeBytes("Invalid editSubscription command\n");
            return;
        }
        int status = DatabaseManager.editUserSubscription(parts[1], parts[2]);
        sendEditResponse(status, "subscription");
    }

    private void handleAddAddress(String request) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            out.writeBytes("Invalid AddAddress command\n");
            return;
        }
        int status = DatabaseManager.addUserAddress(parts[1], parts[2]);
        if (status == 200) {
            out.writeBytes("Add Address successful\n");
        } else if (status == 400) {
            out.writeBytes("The address is duplicate\n");
        } else if (status == 404) {
            out.writeBytes("User not found\n");
        } else {
            out.writeBytes("Error\n");
        }
    }

    // Product Management Methods
    private void sendProducts() throws IOException {
        for (String product : DatabaseManager.products) {
            out.writeBytes(product + "\n");
        }
        out.writeBytes("END_OF_PRODUCTS\n");
    }

    private void handleAddProduct(String productString) throws IOException {
        DatabaseManager.products.add(productString);
        DatabaseManager.updateProductDatabase();
        out.writeBytes("Product added successfully\n");
    }

    private void handleDeleteProduct(String productId) throws IOException {
        boolean removed = false;
        Iterator<String> iterator = DatabaseManager.products.iterator();

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
            DatabaseManager.deleteProduct(productId);
            out.writeBytes("Product deleted successfully\n");
        } else {
            out.writeBytes("Product not found\n");
        }
    }

    // Helper Methods
    private void sendEditResponse(int status, String field) throws IOException {
        if (status == 200) {
            out.writeBytes("Edit " + field + " successful\n");
        } else if (status == 404) {
            out.writeBytes("User not found\n");
        } else {
            out.writeBytes("Invalid credentials\n");
        }
    }

    private String getUserInfoJson(String username) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(USER_FILE_PATH))) {
            String line;
            List<String> addresses = new ArrayList<>();
            while ((line = br.readLine()) != null) {
                String[] info = line.split("-");
                if (info.length >= 8 && info[1].equals(username)) {
                    if (info.length > 8) {
                        addresses = Arrays.asList(info[8].split(","));
                    }
                    Gson gson = new Gson();
                    User user = new User(info[1], info[2], info[3], info[4], info[5], info[6], info[7], addresses);
                    return gson.toJson(user);
                }
            }
        }
        return "not found";
    }

    private void closeConnections() {
        try {
            in.close();
            out.close();
            socket.close();
        } catch (IOException e) {
            System.err.println("Error closing connections: " + e.getMessage());
        }
    }
}