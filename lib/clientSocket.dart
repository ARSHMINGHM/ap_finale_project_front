import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/Address/Address.dart' as MyAppAddress;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:ap_finale_project_front/Product.dart';

class clientSocket {
  String? userName;
  String? fname;
  String? lname;
  String? email;
  String? phoneNumber;
  String? password;
  String? sub = "معمولی";
  List<Product> FavoriteProducts = [];
  List<Product>? shoppingCart = [];
  List<String> addresses = [];
  static final clientSocket _instance = clientSocket._internal();
  static clientSocket get instance => _instance;

  final String host = '192.168.27.5';
  final int port = 8080;
  Socket? _socket;
  final StreamController<String> _streamController = StreamController<String>.broadcast();

  bool get isConnected => _socket != null;

  clientSocket._internal();

  Future<void> connect() async {
    if (isConnected) return;
    try {
      _socket = await Socket.connect(host, port);
      print("Connected to server: ${_socket!.remoteAddress.address}:${_socket!.remotePort}");

      _socket!.listen(
            (List<int> event) {
          String response = utf8.decode(event).trim();
          print("Server Response: $response");
          _streamController.add(response);
        },
        onError: (error) {
          print("Connection Error: $error");
          closeConnection();
        },
        onDone: () {
          print("Server closed the connection.");
          closeConnection();
        },
      );
    } catch (e) {
      print("Failed to connect to server: $e");
    }
  }

  Future<int> sendLoginCommand(String username, String password) async {
    // Ensure the connection is established
    if (!isConnected) {
      try {
        await connect();
        if (!isConnected) return 500;
      } catch (e) {
        print("Error while connecting: $e");
        return 500; // Connection error
      }
    }

    // Send the login request
    final String loginRequest = "login $username $password\n";
    _socket?.write(loginRequest);

    try {
      // Wait for the response from the server
      final String response = await _streamController.stream.first;

      if (response.startsWith("{") && response.endsWith("}")) {
        // Parse JSON if applicable
        final Map<String, dynamic> jsonData = json.decode(response);
        _updateFieldsFromJson(jsonData);
        return 200; // Login successful
      } else if (response == "not found") {
        return 404; // User not found
      } else {
        return 501; // Unexpected response
      }
    } catch (e) {
      // Handle errors while reading response
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
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500; // Server not reachable
    }

    String signUpRequest = "signUp $username $firstName $lastName $email $password\n";
    _socket?.write(signUpRequest);

    try {
      String response = await _streamController.stream.first;
      print("response : ${response}");


      if (response.startsWith("{") && response.endsWith("}")) {
        Map<String, dynamic> jsonData = json.decode(response);
        _updateFieldsFromJson(jsonData);
        return 200; // Sign up successful
      } else if (response.contains("This user name already exists")) {
        return 400; // Username already exists
      }else if (response.contains("This email already exists")) {
        return 401; // Username already exists
      }
      else {
        return 501; // General failure
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }

  Future<int> sendEditNameCommand(String username, String firstName, String lastName) async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500; // Server not reachable
    }

    String editNameRequest = "editName $username $firstName $lastName\n";
    _socket?.write(editNameRequest);

    try {
      String response = await _streamController.stream.first;

      // بررسی پاسخ JSON
      if (response == "Edit name successful") {
        this.fname = firstName;
        this.lname = lastName;

        return 200; // Edit successful
      } else if (response.contains("Edit name failed or user not found")) {
        return 404; // Username not found
      } else {
        return 400; // General failure
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }
  Future<int> sendEditEmailCommand(String username, String email) async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500; // Server not reachable
    }

    String editEmailRequest = "editEmail $username $email\n";
    _socket?.write(editEmailRequest);

    try {
      String response = await _streamController.stream.first;


      if (response == "Edit email successful") {
        this.email = email;

        return 200; // Edit successful
      } else if (response == "user not found") {
        return 404; // Username not found
      } else {
        return 400; // General failure
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }
  Future<int> sendEditPhoneCommand(String username, String phone) async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500; // Server not reachable
    }

    String editPhoneRequest = "editPhone $username $phone\n";
    _socket?.write(editPhoneRequest);

    try {
      String response = await _streamController.stream.first;


      if (response == "Edit phone successful") {
        this.phoneNumber = phone;

        return 200; // Edit successful
      } else if (response == '400') {
        return 400; // phone for another account
      } else if(response == "user not found"){
        return 404; // General failure
      }
      else{
        return 501;
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }
  Future<int> sendEditPasswordCommand(String username, String pass) async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500; // Server not reachable
    }

    String editPasswordRequest = "editPassword $username $pass\n";
    _socket?.write(editPasswordRequest);

    try {
      String response = await _streamController.stream.first;


      if (response == "Edit password successful") {
        this.password = pass;

        return 200; // Edit successful
      } else if (response == 'password was found') {
        return 400;
      } else if(response == "user not found"){
        return 404;
      }
      else{
        return 501;
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }
  Future<int> sendEditSubscriptionCommand(String username, String sub) async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500; // Server not reachable
    }

    String editSubRequest = "editSubscription $username $sub\n";
    _socket?.write(editSubRequest);

    try {
      String response = await _streamController.stream.first;


      if (response == "Edit Subscription successful") {
        this.sub = sub;
        return 200; // Edit successful
      }  else if(response == "not valid"){
        return 404;
      }
      else{
        return 501;
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }

  Future<int> sendAddAddressCommand(String username, String address) async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500; // Server not reachable
    }

    String addAddressRequest = "AddAddress $username $address\n";
    _socket?.write(addAddressRequest);

    try {
      String response = await _streamController.stream.first;


      if (response == "Add Address successful") {
        addresses.add(address);
        return 200; // Edit successful
      }  else if(response == "The address is duplicate"){
        return 400;
      } else if(response == "user not found"){
        return 404;
      } else{
        return 501;
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }
  Future<int> sendDeleteAddressCommand(String username, String address) async {
    if (!isConnected) {
      await connect();
      if (!isConnected) return 500;
    }

    String addAddressRequest = "DeleteAddress $username $address\n";
    _socket?.write(addAddressRequest);

    try {
      String response = await _streamController.stream.first;


      if (response == "Delete Address successful") {
        addresses.remove(address);
        return 200; // Edit successful
      }  else if(response == "this address not found"){
        return 404;
      }
      else{
        return 501;
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }
  void _updateFieldsFromJson(Map<String, dynamic> jsonData) {
    userName = jsonData['username'];
    fname = jsonData['firstName'];
    lname = jsonData['lastName'];
    email = jsonData['email'];
    password =jsonData['pass'];
    phoneNumber = jsonData['phone'];
    sub = jsonData['sub'];
    if (jsonData['addresses'] is List) {
      addresses = List<String>.from(jsonData['addresses']);
    } else {
      addresses = [];
    }
    print("Fields updated from JSON: $jsonData");
  }

  void closeConnection() {
    _socket?.close();
    _socket = null;
    print("Connection closed.");
  }
}



