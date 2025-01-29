import java.io.*;
import java.util.*;

public class DataBaseManager {
    static String filePath = "E:\\AP_java\\test_server\\src\\users.txt";
    static final String AddressFilePath = "E:\\AP_java\\test_server\\src\\userAddress.txt";
    static int lastId = 1;


    static int login(String username, String password) throws IOException {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
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
                    lastId = Integer.parseInt(info[0]);
                }
                line = br.readLine();
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error: File not found - " + filePath);
        } catch (IOException e) {
            System.err.println("Error: An I/O error occurred.");
        }
        return -1;
    }

    static int signUp(String username, String firstName, String lastName, String email, String password) throws IOException {
        boolean isUsernameDuplicate = false;
        boolean isEmailDuplicate = false;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info.length >=8) {
                    if (info[1].equals(username)) {
                        isUsernameDuplicate = true;
                    }
                    if (info[4].equals(email)) {
                        isEmailDuplicate = true;
                    }
                    lastId = Integer.parseInt(info[0]);
                }
                line = br.readLine();
            }
        } catch (FileNotFoundException e) {
            System.err.println("Error: File not found - " + filePath);
        } catch (IOException e) {
            System.err.println("Error: An I/O error occurred.");
        }

        if (isUsernameDuplicate) {
            return 400;
        }
        if (isEmailDuplicate) {
            return 401;
        }

        lastId++;
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath, true))) {
            bw.write(lastId + "-" + username + "-" + firstName + "-" + lastName + "-" + email + "-" + "09********" + "-" + password + "-" + "normal" +"-"+"\n");
            bw.flush();
        } catch (IOException e) {
            System.err.println("Error: An I/O error occurred while writing to the file.");
            return 500;
        }

        return 200;
    }


    static int editName(String username, String firstName, String lastName) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info[1].equals(username)) {
                    info[2] = firstName;
                    info[3] = lastName;
                    line = String.join("-", info);
                    isUserFound = true;
                }
                fileLines.add(line);
                line = br.readLine();
            }
        }

        if (!isUserFound) {
            return 404;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String fileLine : fileLines) {
                bw.write(fileLine);
                bw.newLine();
            }
        }

        return 200;
    }
    static int editPhone(String username, String phone) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info[1].equals(username)) {
                    info[5] = phone;

                    line = String.join("-", info);
                    isUserFound = true;
                }
                fileLines.add(line);
                line = br.readLine();
            }
        }

        if (!isUserFound) {
            return 404;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String fileLine : fileLines) {
                bw.write(fileLine);
                bw.newLine();
            }
        }

        return 200;
    }
    static int editEmail(String username, String email) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info[1].equals(username)) {
                    info[4] = email;

                    line = String.join("-", info);
                    isUserFound = true;
                }
                fileLines.add(line);
                line = br.readLine();
            }
        }

        if (!isUserFound) {
            return 404;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String fileLine : fileLines) {
                bw.write(fileLine);
                bw.newLine();
            }
        }

        return 200;
    }
    static int editPassword(String username, String pass) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info[1].equals(username)) {
                    info[6] = pass;

                    line = String.join("-", info);
                    isUserFound = true;
                }
                fileLines.add(line);
                line = br.readLine();
            }
        }

        if (!isUserFound) {
            return 404;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String fileLine : fileLines) {
                bw.write(fileLine);
                bw.newLine();
            }
        }

        return 200;
    }
    static int editSubscription(String username, String sub) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");
                if (info[1].equals(username)) {
                    info[7] = sub;

                    line = String.join("-", info);
                    isUserFound = true;
                }
                fileLines.add(line);
                line = br.readLine();
            }
        }

        if (!isUserFound) {
            return 404;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String fileLine : fileLines) {
                bw.write(fileLine);
                bw.newLine();
            }
        }

        return 200;
    }
    static int addAddress(String username, String address) throws IOException {
        List<String> fileLines = new ArrayList<>();
        boolean isUserFound = false;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line = br.readLine();
            while (line != null) {
                String[] info = line.split("-");

                if (info.length > 1 && info[1].equals(username)) {
                    String newLine = line;

                    if (info.length > 8) {
                        List<String> addresses = new ArrayList<>(Arrays.asList(info[8].split(",")));

                        if (addresses.contains(address)) {
                            return 400;
                        }

                        newLine = line + "," + address;
                    } else {
                        newLine = line + address;
                    }

                    fileLines.add(newLine);
                    isUserFound = true;
                } else {
                    fileLines.add(line);
                }

                line = br.readLine();
            }
        }

        if (!isUserFound) {
            return 404;
        }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            for (String fileLine : fileLines) {
                bw.write(fileLine);
                bw.newLine();
            }
        }
        return 200;
    }

}
