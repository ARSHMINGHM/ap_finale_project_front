import 'package:untitled/Category/Category.dart';
import 'package:untitled/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Account/users.dart';
import 'package:untitled/Address/Address.dart' as MyAppAddress;
import 'package:untitled/Cart/Cart.dart';
import 'package:untitled/Login_and_SIgn up/SignUp.dart';
import 'package:untitled/Login_and_SIgn up/Login.dart';
import 'package:untitled/FakeData.dart';
import 'package:untitled/Product.dart';
import 'package:untitled/clientSocket.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:untitled/Account/AccountMainPage.dart';

List<Product> b = fakeProducts;
User a = User(userName: "alisa",fname: "علی",lname:"صائمی",email: "alisaemi0005@gmail.com",phoneNumber: "0932565255",password: "1234");
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
        '/profile':(context) => Profile(),
      },
    );
  }
}


