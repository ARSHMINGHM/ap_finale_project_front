import java.io.*;
import java.net.*;

public class testServerTestProduct {
    public static void main(String[] args) {
        try {
            Socket socket = new Socket("localhost", 12345);
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));

            // Test adding a product
            String newProduct = "ADD_PRODUCT 20~Test Product~100.00~80.00~4.5~#FFFFFF~White~#000000~test.jpg~20~true~false~100~0~4.5~false~Test~1~10";
            out.println(newProduct);
            String response = in.readLine();
            System.out.println("Add Product Response: " + response);

            // Test getting all products
            out.println("GET_PRODUCTS");
            String product;
            System.out.println("Products:");
            while (!(product = in.readLine()).equals("END_OF_PRODUCTS")) {
                System.out.println(product);
            }

            // Test deleting the added product
            out.println("DELETE_PRODUCT 26");
            response = in.readLine();
            System.out.println("Delete Product Response: " + response);

            // Verify deletion by getting all products again
            out.println("GET_PRODUCTS");
            System.out.println("Products after deletion:");
            while (!(product = in.readLine()).equals("END_OF_PRODUCTS")) {
                System.out.println(product);
            }

            // Test deleting a non-existent product
            out.println("DELETE_PRODUCT 999");
            response = in.readLine();
            System.out.println("Delete Non-existent Product Response: " + response);

            // Exit the connection
            out.println("EXIT");

            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}