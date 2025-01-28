import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import com.google.gson.*;

public class stest {

    static String filePath = "C:\\ap_finale_project_front\\lib\\Server\\users.txt";

    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(8080)) {
            System.out.println("Server starting...");
            Socket s = serverSocket.accept();
            System.out.println("Client connected!");

            BufferedReader din = new BufferedReader(new InputStreamReader(s.getInputStream()));
            DataOutputStream dout = new DataOutputStream(s.getOutputStream());

            String str1 = "";
            while (true) {
                str1 = din.readLine();
                if (str1 == null || str1.equals("exit")) {
                    break;
                }

                System.out.println("Received request: " + str1);

                if (str1.startsWith("login")) {
                    String[] parts = str1.split(" ");
                    String username = parts[1];
                    String password = parts[2];

                    System.out.println("Username: " + username);
                    System.out.println("Password: " + password);

                    int userId = DataBaseManager.login(username, password);
                    if (userId != -1) {
                        String userInfoJson = getUserInfoAsJson(username);
                        dout.writeBytes(userInfoJson + "\n");
                    } else {
                        /*JsonObject errorResponse = new JsonObject();
                        errorResponse.addProperty("status", "error");
                        errorResponse.addProperty("message", "Invalid credentials");*/
                        dout.writeBytes("not found\n");
                    }
                } else if (str1.startsWith("signUp")) {
                    String[] parts = str1.split(" ");
                    String username = parts[1];
                    String fname = parts[2];
                    String lname = parts[3];
                    String email = parts[4];
                    String password = parts[5];

                    System.out.println("Username: " + username);
                    System.out.println("Fname: " + fname);
                    System.out.println("Lname: " + lname);
                    System.out.println("Email: " + email);
                    System.out.println("Password: " + password);


                    int status = DataBaseManager.signUp(username, fname, lname, email, password);
                    if (status == 200) {
                        /*Gson gson = new Gson();
                        User user = new User(username, fname, lname, email, "09********", password);*/
                        String userInfoJson = getUserInfoAsJson(username);
                       // return gson.toJson(user);
                        dout.writeBytes(userInfoJson+"\n");
                    } else if (status == 400) {
                        dout.writeBytes("This member already exists\n");
                    } else {
                        dout.writeBytes("Invalid credentials\n");
                    }
                } else if (str1.startsWith("editName")) {
                    String[] parts = str1.split(" ");
                    String username = parts[1];
                    String fname = parts[2];
                    String lname = parts[3];
                    if (DataBaseManager.editName(username, fname, lname) == 200) {
                        dout.writeBytes("Edit name successful\n");
                    } else {
                        dout.writeBytes("Edit name failed or user not found\n");
                    }
                }
                else if (str1.startsWith("editPhone")) {
                    String[] parts = str1.split(" ");
                    String username = parts[1];
                    String phone = parts[2];

                    int state = DataBaseManager.editPhone(username, phone);
                    if (state == 200) {
                        dout.writeBytes("Edit phone successful\n");
                    } else if(state == 404){
                        dout.writeBytes("user not found\n");
                    }
                    else{
                        dout.writeBytes("400\n");

                    }
                }
                else if (str1.startsWith("editEmail")) {
                    String[] parts = str1.split(" ");
                    String username = parts[1];
                    String email = parts[2];

                    int state = DataBaseManager.editEmail(username, email);
                    if (state == 200) {
                        dout.writeBytes("Edit email successful\n");
                    } else if(state == 404){
                        dout.writeBytes("user not found\n");
                    }
                    else{
                        dout.writeBytes("400\n");

                    }
                }

                else if (str1.startsWith("editPassword")) {
                    String[] parts = str1.split(" ");
                    String username = parts[1];
                    String pass = parts[2];

                    int state = DataBaseManager.editPassword(username, pass);
                    if (state == 200) {
                        dout.writeBytes("Edit password successful\n");
                    } else if(state == 400){
                        dout.writeBytes("password was found\n");
                    }
                    else if(state == 404){
                        dout.writeBytes("user not found\n");
                    }
                    else{
                        dout.writeBytes("400\n");

                    }
                }
                else if (str1.startsWith("editSubscription")) {
                    String[] parts = str1.split(" ");
                    String username = parts[1];
                    String sub = parts[2];

                    int state = DataBaseManager.editSubscription(username, sub);
                    if (state == 200) {
                        dout.writeBytes("Edit Subscription successful\n");
                    }
                    else if(state == 404){
                        dout.writeBytes("not valid\n");
                    }
                    else{
                        dout.writeBytes("error\n");

                    }
                }

            }

            s.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    static String getUserInfoAsJson(String username) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info.length == 8 && info[1].equals(username)) {

                    Gson gson = new Gson();
                    User user = new User(info[1], info[2], info[3], info[4], info[5], info[6],info[7]);
                    return gson.toJson(user);
                }
                line = br.readLine();
            }
        }

        return "not found";
    }

    static class User {
        //String id;
        String username;
        String firstName;
        String lastName;
        String email;
        String phone;
        String pass;
        String sub;

        User(String username, String firstName, String lastName, String email, String phone,String pass,String sub) {
            //this.id = id;
            this.username = username;
            this.firstName = firstName;
            this.lastName = lastName;
            this.email = email;
            this.phone = phone;
            this.pass = pass;
            this.sub = sub;
        }
    }
}
