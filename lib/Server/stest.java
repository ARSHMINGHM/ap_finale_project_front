import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;

public class stest {
    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(8080)) {
            System.out.println("Server starting...");
            Socket s = serverSocket.accept();
            System.out.println("Client connected!");

            BufferedReader din = new BufferedReader(new InputStreamReader(s.getInputStream()));
            DataOutputStream dout = new DataOutputStream(s.getOutputStream());

            String str1 = "";
            while (true) {
                str1 = din.readLine(); // خواندن پیام تا پایان خط (\n)
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


                    if (DataBaseManager.login(username,password) != -1) {
                        dout.writeBytes("Login successful\n");
                    } else {
                        dout.writeBytes("Invalid credentials\n");
                    }
                }
                else if (str1.startsWith("signUp")) {
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
                    if(DataBaseManager.signUp(username,fname,lname,email,password) == 200){
                        dout.writeBytes("sign up successful\n");
                    }
                    else if(DataBaseManager.signUp(username,fname,lname,email,password) == 400){
                        dout.writeBytes("this member was exist\n");
                    }
                    else{
                        dout.writeBytes("Invalid credentials\n");
                    }


                }
            }

            s.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}