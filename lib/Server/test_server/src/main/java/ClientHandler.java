import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Map;


public class ClientHandler  extends Thread {
    int id = 0;
    Socket socket;
    private boolean running = true;
    DataOutputStream dout;
    DataInputStream din;
    public ClientHandler(Socket socket) throws IOException {
        this.socket = socket;
        dout = new DataOutputStream(socket.getOutputStream());
        din = new DataInputStream(socket.getInputStream());
        System.out.println("Client " + id + " connected");
    }
    public void sendJson(String json) throws IOException {
        dout.write(json.getBytes());
        dout.flush();
    }
    public Map<String ,String> readJson() throws IOException {
        StringBuilder sb = new StringBuilder();

        int index = din.read();
        while(index != 0) {
            sb.append((char)index);
            index = din.read();
        }
        Map<String ,String> out = new HashMap<>();
        String jsonString = sb.toString();
        jsonString = jsonString.replace("{","").replace("}","").trim();
        String[] jsonArray = jsonString.split(",");
        for(String json : jsonArray) {
            String[] keyValue = json.split(":");
            out.put(keyValue[0],keyValue[1]);
        }
        return out;

    }
    @Override
    public void run() {
        try {
            System.out.println("Server starting...");

                System.out.println("Client connected!");
                /*DataInputStream din = new DataInputStream(s.getInputStream());
                DataOutputStream dout = new DataOutputStream(s.getOutputStream());*/
                String str1 = "";
                String command;
                String username;
                String fname;
                String lname;
                String email;
                String password;
                while (true) {
                    str1 = din.readUTF();
                    System.out.println(str1);
                    if (str1.equals("stop")) {
                        System.out.println("Client disconnected.");
                        break;
                    }
                    String[] sep = str1.split(" ");
                    if (sep.length < 3) {
                        dout.writeUTF("Invalid command format. Use: <command> <username> <password>");
                        continue;
                    }
                    command = sep[0];
                    if (command.equals("login")) {
                        username = sep[1];
                        password = sep[2];
                        int state = DataBaseManager.login(username, password);
                        if (state != -1) {
                            dout.writeUTF("Login successful");
                        } else {
                            dout.writeUTF("Login failed");
                        }
                    } else if (command.equals("signUp")) {
                        username = sep[1];
                        fname = sep[2];
                        lname = sep[3];
                        email = sep[4];
                        password = sep[5];
                        int state = DataBaseManager.signUp(username,fname,lname,email, password);
                        if (state == 200) {
                            dout.writeUTF("Sign-up successful");
                        } else if (state == 400) {
                            dout.writeUTF("Sign-up failed: User already exists");
                        } else {
                            dout.writeUTF("Sign-up failed: Internal error");
                        }
                    }
                    else {
                        dout.writeUTF("Unknown command");
                    }
                }

        } catch (Exception e) {
            e.printStackTrace();
        }
        finally {
            close();
        }

    }
    public void close() {
        try {
            if (din != null) {
                din.close();
            }
            if (dout != null) {
                dout.close();
            }
            if (socket != null && !socket.isClosed()) {
                socket.close();
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        }




}
