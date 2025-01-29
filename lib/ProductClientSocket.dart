import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:ap_finale_project_front/Product.dart';
import 'package:flutter/material.dart';

class ProductClientSocket {
  // Singleton pattern
  static final ProductClientSocket _instance = ProductClientSocket._internal();
  static ProductClientSocket get instance => _instance;

  // Server configuration
  final String host = '192.168.27.5';
  final int port = 12345; // Product server port
  Socket? _socket;
  final StreamController<String> _streamController = StreamController<String>.broadcast();

  // Product lists
  List<Product> products = [];

  bool get isConnected => _socket != null;

  ProductClientSocket._internal();

  Future<void> connect() async {
    if (isConnected) return;
    try {
      _socket = await Socket.connect(host, port);
      print("Connected to product server: ${_socket!.remoteAddress.address}:${_socket!.remotePort}");

      _socket!.listen(
            (List<int> event) {
          String response = utf8.decode(event).trim();
          print("Product Server Response: $response");
          _streamController.add(response);
        },
        onError: (error) {
          print("Product Connection Error: $error");
          closeConnection();
        },
        onDone: () {
          print("Product Server closed the connection.");
          closeConnection();
        },
      );
    } catch (e) {
      print("Failed to connect to product server: $e");
    }
  }

  Future<List<Product>> getProducts() async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return [];
    }

    _socket?.write("GET_PRODUCTS\n");
    List<Product> productList = [];

    try {
      await for (String response in _streamController.stream) {
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
                backgroundColor: Color(fields[5] as int),
                strcolor: fields[6],
                color: Color(fields[7] as int),
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
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500;
    }

    String productString = "${product.id}~${product.title}~${product.fullPrice}~${product.price}~" +
        "${product.rating}~${product.backgroundColor}~${product.strcolor}~${product.color}~" +
        "${product.img}~${product.discount}~${product.isAmazingOffer}~${product.isTopProduct}~" +
        "${product.stock}~${product.soldCount}~${product.productScore}~${product.isLiked}~" +
        "${product.category}~${0000}~${product.quantity}";

    _socket?.write("ADD_PRODUCT $productString\n");

    try {
      String response = await _streamController.stream.first;
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
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500;
    }

    _socket?.write("DELETE_PRODUCT $productId\n");

    try {
      String response = await _streamController.stream.first;
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
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500;
    }

    // First delete the old product
    int deleteResult = await deleteProduct(product.id);
    if (deleteResult != 200) return deleteResult;

    // Then add the updated version
    return await addProduct(product);
  }

  void closeConnection() {
    _socket?.close();
    _socket = null;
    print("Product connection closed.");
  }
}