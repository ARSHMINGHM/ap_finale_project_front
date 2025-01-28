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
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
List<Product> b = fakeProducts;
User a = User(userName: "alisa",fname: "علی",lname:"صائمی",email: "alisaemi0005@gmail.com",phoneNumber: "0932565255",password: "1234",addresses: ["tehran"],shoppingCart: [fakeProducts[0]]);
void main() async{
  //clientSocket.instance.connect();
  runApp(const MyApp());


}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //clientSocket.instance.connect();

    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      debugShowCheckedModeBanner: false,
      home: login(),
      routes: {
        '/home': (context) => Home(),
      },
    );
  }
}
