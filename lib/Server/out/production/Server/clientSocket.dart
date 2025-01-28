import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/Address/Address.dart' as MyAppAddress;
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/Login_and_SIgn up/SignUp.dart';
import 'package:ap_finale_project_front/Login_and_SIgn up/Login.dart';
import 'package:ap_finale_project_front/FakeData.dart';
import 'package:ap_finale_project_front/Product.dart';
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
  final StreamController<String> _streamController = StreamController<String>();


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
          _streamController.add(response);  // ارسال داده به استریم
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

  Future<void> sendLoginCommand(String username, String password, BuildContext context) async {
    if (!isConnected) {
      _showNotification(context, "اتصال به سرور برقرار نیست.", Colors.red, Icons.error_outline);
      await connect();
      return;
    }

    String loginRequest = "login $username $password\n";
    if(username != null && password != null){
      _socket?.write(loginRequest);

      _streamController.stream.listen((response) {
        print("Server Response: $response");

        if (response == "Login successful") {
          _showNotification(context, "ورود موفقیت‌آمیز بود!", Colors.green, Icons.check_circle_outline);
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.pushReplacementNamed(context, '/home');
          });
        } else {
          _showNotification(context, "نام کاربری یا رمز عبور اشتباه است.", Colors.red, Icons.error_outline);
        }
      });
    }
  }
  Future<void> sendSignUpCommand(String username,String firstName,String lastName,String email, String password, BuildContext context) async{
    if (!isConnected) {
      _showNotification(context, "اتصال به سرور برقرار نیست.", Colors.red, Icons.error_outline);
      await connect();
      return;
    }
    String loginRequest = "signUp $username $firstName $lastName $email $password\n";
    _socket?.write(loginRequest);
    _streamController.stream.listen((response) {
      print("Server Response: $response");

      if (response == "sign up successful") {
        _showNotification(context, "ثبت نام موفقیت‌آمیز بود!", Colors.green, Icons.check_circle_outline);
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else if(response == 404){
        _showNotification(context, "username not valid", Colors.red, Icons.error_outline);
      }else if(response == 405){
        _showNotification(context, "password not valid", Colors.red, Icons.error_outline);
      }
      else if(response == 406){
        _showNotification(context, "email not valid", Colors.red, Icons.error_outline);
      }

    });

  }

  void closeConnection() {
    _socket?.close();
    _socket = null;
    print("Connection closed.");
  }

  void _showNotification(BuildContext context, String message, Color color, IconData icon) {
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
  }
}