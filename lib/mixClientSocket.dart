import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Product.dart';

class CombinedClientSocket {
  // Singleton pattern
  static final CombinedClientSocket _instance = CombinedClientSocket._internal();
  static CombinedClientSocket get instance => _instance;

  // User details
  String? userName;
  String? fname;
  String? lname;
  String? email;
  String? phoneNumber;
  String? password;
  String? sub = "معمولی";

  // Product and user-related lists
  List<Product> products = [];
  List<Product> favoriteProducts = [];
  List<Product>? shoppingCart = [];
  List<String> addresses = [];

  // Server configuration
  final String host = '192.168.27.5';
  final int productPort = 12345;  // Product server port
  final int userPort = 8080;      // User server port

  Socket? _productSocket;
  Socket? _userSocket;

  final StreamController<String> _productStreamController = StreamController<String>.broadcast();
  final StreamController<String> _userStreamController = StreamController<String>.broadcast();

  bool get isProductConnected => _productSocket != null;
  bool get isUserConnected => _userSocket != null;

  CombinedClientSocket._internal();

  // Product Server Connection
  Future<void> connectProductServer() async {
    if (isProductConnected) return;
    try {
      _productSocket = await Socket.connect(host, productPort);
      print("Connected to product server: ${_productSocket!.remoteAddress.address}:${_productSocket!.remotePort}");

      _productSocket!.listen(
            (List<int> event) {
          String response = utf8.decode(event).trim();
          print("Product Server Response: $response");
          _productStreamController.add(response);
        },
        onError: (error) {
          print("Product Connection Error: $error");
          closeProductConnection();
        },
        onDone: () {
          print("Product Server closed the connection.");
          closeProductConnection();
        },
      );
    } catch (e) {
      print("Failed to connect to product server: $e");
    }
  }

  // User Server Connection
  Future<void> connectUserServer() async {
    if (isUserConnected) return;
    try {
      _userSocket = await Socket.connect(host, userPort);
      print("Connected to user server: ${_userSocket!.remoteAddress.address}:${_userSocket!.remotePort}");

      _userSocket!.listen(
            (List<int> event) {
          String response = utf8.decode(event).trim();
          print("User Server Response: $response");
          _userStreamController.add(response);
        },
        onError: (error) {
          print("User Connection Error: $error");
          closeUserConnection();
        },
        onDone: () {
          print("User Server closed the connection.");
          closeUserConnection();
        },
      );
    } catch (e) {
      print("Failed to connect to user server: $e");
    }
  }

  // Product-related Methods
  Future<List<Product>> getProducts() async {
    if (!isProductConnected) {
      await connectProductServer();
      if (!isProductConnected) return [];
    }

    _productSocket?.write("GET_PRODUCTS\n");
    List<Product> productList = [];

    try {
      await for (String response in _productStreamController.stream) {
        if (response == "END_OF_PRODUCTS") break;

        try {
          List<String> fields = response.split("~");
          if (fields.length >= 19) { // Make sure we have all fields
            Product product = Product(
              id: int.parse(fields[0]),
              title: fields[1],
              fullPrice: fields[2],
              price: fields[3],
              rating: fields[4],
              backgroundColor: Color(int.parse(fields[5])),
              strcolor: fields[6],
              color: Color(int.parse(fields[7])),
              img: fields[8],
              discount: int.parse(fields[9]),
              isAmazingOffer: fields[10].toLowerCase() == 'true',
              isTopProduct: fields[11].toLowerCase() == 'true',
              stock: int.parse(fields[12]),
              soldCount: int.parse(fields[13]),
              productScore: double.parse(fields[14]),
              isLiked: fields[15].toLowerCase() == 'true',
              category: fields[16],
              quantity: int.parse(fields[18]),
              specs: ProductSpecs(
                phoneType: "",
                model: "Fragrance Elite",
                releaseDate: "2024-03-01",
                dimensions: "100ml",
                features: ["Long-Lasting", "Luxury Packaging"],
              ),
            );
            productList.add(product);
          }
        } catch (e) {
          print("Error parsing product: $e");
        }
      }
    } catch (e) {
      print("Error getting products: $e");
    }

    products = productList;
    return productList;
  }

  Future<int> addProduct(Product product) async {
    if (!isProductConnected) {
      await connectProductServer();
      if (!isProductConnected) return 500;
    }

    String productString = "${product.id}~${product.title}~${product.fullPrice}~${product.price}~" +
        "${product.rating}~${product.backgroundColor.value}~${product.strcolor}~${product.color.value}~" +
        "${product.img}~${product.discount}~${product.isAmazingOffer}~${product.isTopProduct}~" +
        "${product.stock}~${product.soldCount}~${product.productScore}~${product.isLiked}~" +
        "${product.category}~${0000}~${product.quantity}";

    _productSocket?.write("ADD_PRODUCT $productString\n");

    try {
      String response = await _productStreamController.stream.first;
      if (response == "Product added successfully") {
        products.add(product);
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      return 500;
    }
  }

  Future<int> deleteProduct(int productId) async {
    if (!isProductConnected) {
      await connectProductServer();
      if (!isProductConnected) return 500;
    }

    _productSocket?.write("DELETE_PRODUCT $productId\n");

    try {
      String response = await _productStreamController.stream.first;
      if (response == "Product deleted successfully") {
        products.removeWhere((product) => product.id == productId);
        return 200;
      } else if (response == "Product not found") {
        return 404;
      } else {
        return 400;
      }
    } catch (e) {
      return 500;
    }
  }

  Future<int> updateProduct(Product product) async {
    if (!isProductConnected) {
      await connectProductServer();
      if (!isProductConnected) return 500;
    }

    // First delete the old product
    int deleteResult = await deleteProduct(product.id);
    if (deleteResult != 200) return deleteResult;

    // Then add the updated version
    return await addProduct(product);
  }

  // User-related Methods
  Future<int> sendLoginCommand(String username, String password) async {
    if (!isUserConnected) {
      await connectUserServer();
      if (!isUserConnected) return 500;
    }

    final String loginRequest = "login $username $password\n";
    _userSocket?.write(loginRequest);

    try {
      final String response = await _userStreamController.stream.first;

      if (response.startsWith("{") && response.endsWith("}")) {
        final Map<String, dynamic> jsonData = json.decode(response);
        _updateFieldsFromJson(jsonData);
        return 200; // Login successful
      } else if (response == "not found") {
        return 404; // User not found
      } else {
        return 501; // Unexpected response
      }
    } catch (e) {
      print("Error while reading response: $e");
      return 500;
    }
  }

  Future<int> sendSignUpCommand(
      String username,
      String firstName,
      String lastName,
      String email,
      String password,
      ) async {
    if (!isUserConnected) {
      await connectUserServer();
      if (!isUserConnected) return 500; // Server not reachable
    }

    String signUpRequest = "signUp $username $firstName $lastName $email $password\n";
    _userSocket?.write(signUpRequest);

    try {
      String response = await _userStreamController.stream.first;
      print("response: $response");

      if (response.startsWith("{") && response.endsWith("}")) {
        Map<String, dynamic> jsonData = json.decode(response);
        _updateFieldsFromJson(jsonData);
        return 200; // Sign up successful
      } else if (response.contains("This user name already exists")) {
        return 400; // Username already exists
      } else if (response.contains("This email already exists")) {
        return 401; // Email already exists
      } else {
        return 501; // General failure
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }

  // Other user-related methods (edit name, email, phone, password, etc.)
  Future<int> sendEditNameCommand(String username, String firstName, String lastName) async {
    if (!isUserConnected) {
      await connectUserServer();
      if (!isUserConnected) return 500;
    }

    String editNameRequest = "editName $username $firstName $lastName\n";
    _userSocket?.write(editNameRequest);

    try {
      String response = await _userStreamController.stream.first;

      if (response == "Edit name successful") {
        this.fname = firstName;
        this.lname = lastName;
        return 200;
      } else if (response.contains("Edit name failed or user not found")) {
        return 404;
      } else {
        return 400;
      }
    } catch (e) {
      return 500;
    }
  }

  // Add methods for other operations like address management, etc.

  void _updateFieldsFromJson(Map<String, dynamic> jsonData) {
    userName = jsonData['username'];
    fname = jsonData['firstName'];
    lname = jsonData['lastName'];
    email = jsonData['email'];
    password = jsonData['pass'];
    phoneNumber = jsonData['phone'];
    sub = jsonData['sub'];
    if (jsonData['addresses'] is List) {
      addresses = List<String>.from(jsonData['addresses']);
    } else {
      addresses = [];
    }
    print("Fields updated from JSON: $jsonData");
  }

  void closeProductConnection() {
    _productSocket?.close();
    _productSocket = null;
    print("Product connection closed.");
  }

  void closeUserConnection() {
    _userSocket?.close();
    _userSocket = null;
    print("User connection closed.");
  }

  void closeAllConnections() {
    closeProductConnection();
    closeUserConnection();
  }
}