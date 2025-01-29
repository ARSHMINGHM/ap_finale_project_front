import java.io.*;
import java.net.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import com.google.gson.*;

class ClientHandler implements Runnable {
    private final Socket socket;
    private static final String filePath = "E:\\AP_java\\test_server\\src\\users.txt";
    private static final String AddressFilePath = "E:\\AP_java\\test_server\\src\\userAddress.txt";

    public ClientHandler(Socket socket) {
        this.socket = socket;
    }

    @Override
    public void run() {
        try (BufferedReader din = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             DataOutputStream dout = new DataOutputStream(socket.getOutputStream())) {

            String str1;
            while ((str1 = din.readLine()) != null) {
                if (str1.equalsIgnoreCase("exit")) {
                    break;
                }

                System.out.println("Request from client: " + str1);

                if (str1.startsWith("login")) {
                    handleLogin(str1, dout);
                } else if (str1.startsWith("signUp")) {
                    handleSignUp(str1, dout);
                } else if (str1.startsWith("editName")) {
                    handleEditName(str1, dout);
                } else if (str1.startsWith("editPhone")) {
                    handleEditPhone(str1, dout);
                } else if (str1.startsWith("editEmail")) {
                    handleEditEmail(str1, dout);
                } else if (str1.startsWith("editPassword")) {
                    handleEditPassword(str1, dout);
                } else if (str1.startsWith("editSubscription")) {

                    handleEditSubscription(str1, dout);
                }
                else if (str1.startsWith("AddAddress")) {
                    handleAddAddress(str1, dout);
                }else {
                    dout.writeBytes("Invalid command\n");
                }
            }
        } catch (IOException e) {
            System.err.println("Error handling client: " + e.getMessage());
        } finally {
            try {
                socket.close();
            } catch (IOException e) {
                System.err.println("Error closing socket: " + e.getMessage());
            }
        }
    }

    private void handleLogin(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            dout.writeBytes("Invalid login command\n");
            return;
        }
        String username = parts[1];
        String password = parts[2];
        int userId = DataBaseManager.login(username, password);

        if (userId != -1) {
            String userInfoJson = getUserInfoJson(username);
            if (userInfoJson.equals("not found")) {
                dout.writeBytes("User data retrieval error\n");
            } else {
                dout.writeBytes(userInfoJson + "\n");
            }
        } else {
            dout.writeBytes("Invalid credentials\n");
        }
    }


    private void handleSignUp(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 6) {
            dout.writeBytes("Invalid signUp command\n");
            return;
        }

        String username = parts[1];
        String fname = parts[2];
        String lname = parts[3];
        String email = parts[4];
        String password = parts[5];

        int status = DataBaseManager.signUp(username, fname, lname, email, password);
        if (status == 200) {
            String userInfoJson = getUserInfoJson(username);
            dout.writeBytes(userInfoJson + "\n");
        } else if (status == 400) {
            dout.writeBytes("This user name already exists\n");
        } else if (status == 401) {
            dout.writeBytes("This email already exists\n");
        } else {
            dout.writeBytes("Invalid credentials\n");
        }
    }

    private void handleEditName(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 4) {
            dout.writeBytes("Invalid editName command\n");
            return;
        }

        String username = parts[1];
        String fname = parts[2];
        String lname = parts[3];

        int status = DataBaseManager.editName(username, fname, lname);
        if (status == 200) {
            dout.writeBytes("Edit name successful\n");
        } else {
            dout.writeBytes("Edit name failed or user not found\n");
        }
    }

    private void handleEditPhone(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            dout.writeBytes("Invalid editPhone command\n");
            return;
        }

        String username = parts[1];
        String phone = parts[2];

        int status = DataBaseManager.editPhone(username, phone);
        if (status == 200) {
            dout.writeBytes("Edit phone successful\n");
        } else if(status == 404){
            dout.writeBytes("user not found\n");
        } else{
            dout.writeBytes("Invalid credentials\n");
        }
    }

    private void handleEditEmail(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            dout.writeBytes("Invalid editEmail command\n");
            return;
        }
        String username = parts[1];
        String email = parts[2];

        int status = DataBaseManager.editEmail(username, email);
        if (status == 200) {
            dout.writeBytes("Edit email successful\n");
        } else if(status == 404){
            dout.writeBytes("user not found\n");
        }

        else{
            dout.writeBytes("400\n");
        }
    }

    private void handleEditPassword(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            dout.writeBytes("Invalid editPassword command\n");
            return;
        }

        String username = parts[1];
        String password = parts[2];

        int status = DataBaseManager.editPassword(username, password);
        if (status == 200) {
            dout.writeBytes("Edit password successful\n");
        } else {
            dout.writeBytes("Edit password failed\n");
        }
    }

    private void handleEditSubscription(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            dout.writeBytes("Invalid editSubscription command\n");
            return;
        }
        String username = parts[1];
        String subscription = parts[2];
        int status = DataBaseManager.editSubscription(username, subscription);
        if (status == 200) {
            dout.writeBytes("Edit Subscription successful\n");
        } else {
            dout.writeBytes("not valid\n");
        }
    }
    private void handleAddAddress(String request, DataOutputStream dout) throws IOException {
        String[] parts = request.split(" ");
        if (parts.length < 3) {
            dout.writeBytes("Invalid AddAddress  command\n");
            return;
        }
        String username = parts[1];
        String address = parts[2];
        int status = DataBaseManager.addAddress(username, address);
        if (status == 200) {
            dout.writeBytes("Add Address successful\n");
        } else if(status == 400) {
            dout.writeBytes("The address is duplicate\n");
        }else if(status == 404){
            dout.writeBytes("user not found\n");
        }
        else{
            dout.writeBytes("error\n");

        }
    }

    static String getUserInfoJson(String username) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            List<String> addresses = new ArrayList<>();
            while ((line = br.readLine()) != null) {
                String[] info = line.split("-");
                if (info.length >= 8 && info[1].equals(username)) {
                    if (info.length > 8) {
                        addresses = Arrays.asList(info[8].split(","));
                    }
                    Gson gson = new Gson();
                    stest.User user = new stest.User(info[1], info[2], info[3], info[4], info[5], info[6], info[7], addresses);
                    return gson.toJson(user);
                }
            }
        }
        return "not found";
    }

}