import java.io.*;

public class DataBaseManager {
    static String filePath = "E:\\AP_java\\test_server\\src\\users.txt";
    static int lastId = 1;

    static int login(String username, String password) throws IOException {

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info.length == 7) {
                    if (info[1].equals(username) && info[6].equals(password)) {
                        return Integer.parseInt(info[0]);
                    }
                }

                line = br.readLine();
                lastId = Integer.parseInt(info[0]);
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error: File not found - " + filePath);
        } catch (IOException e) {
            System.err.println("Error: An I/O error occurred.");
        }
        return -1;
    }


    static int signUp(String username, String firstName,String lastName,String email, String password) throws IOException {
        int status = login(username, password);
        int result;
        if (status != -1) {
            result = 400;
            return result;
        }
        lastId++;
        BufferedWriter bw = new BufferedWriter(new FileWriter(filePath,true));
        bw.write( lastId +"-"  + username + "-" + firstName +"-"+ lastName+ "-" + email+ "-" + "09********" + "-"+ password + "\n");
        bw.flush();
        bw.close();
        result = 200;
        return result;
    }

}
