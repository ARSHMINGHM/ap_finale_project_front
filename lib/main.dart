import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/Address/Address.dart' as MyAppAddress;
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/Login_and_SIgn up/SignUp.dart';
import 'package:ap_finale_project_front/Login_and_SIgn up/Login.dart';

CartProduct b = CartProduct(
  name: 'گوشی موبایل تایتانیک مدل 2 Phone با سیم کارت ظرفیت 512 گیگابایت و رم 12 گیگابایت',
  price: 11250000,
  image: 'assets/Iphone.jpg',
  capacity: '512 گیگابایت',
  color: 'مشکی',
);
User a = User(userName: "alisa",fname: "علی",lname:"صائمی",email: "alisaemi0005@gmail.com",phoneNumber: "0932565255",password: "1234");
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}