import 'package:untitled/Category/Category.dart';
import 'package:untitled/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Account/users.dart';
import 'package:untitled/Address/Address.dart' as MyAppAddress;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class clientSocket {
  static final clientSocket _instance = clientSocket._internal();
  static clientSocket get instance => _instance;

  final String host = '192.168.81.61';
  final int port = 8080;
  Socket? _socket;
  final StreamController<String> _streamController = StreamController<String>.broadcast();
  //final StreamController<String> _streamController = StreamController<String>();


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
    if (!isConnected) {
      try {
        await connect();
        if (!isConnected) return 500;
      } catch (e) {
        return 500;
      }
    }

    String loginRequest = "login $username $password\n";
    _socket?.write(loginRequest);

    try {
      String response = await _streamController.stream.first;
      if (response == "Login successful") {
        return 200; // Login successful
      } else {
        return 401;
      }
    } catch (e) {
      print(e);
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
      if (response == "sign up successful") {
        return 200; // Sign up successful
      } else if (response == "404") {
        return 404; // Username not valid
      } /*else if (response == "405") {
        return 405; // Password not valid
      }*/ else if (response == "406") {
        return 406; // Email not valid
      } else {
        return 400; // General failure
      }
    } catch (e) {
      return 500; // Error occurred
    }
  }

  void closeConnection() {
    _socket?.close();
    _socket = null;
    print("Connection closed.");
  }

/*  void _showNotification(BuildContext context, String message, Color color, IconData icon) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }*/
}
