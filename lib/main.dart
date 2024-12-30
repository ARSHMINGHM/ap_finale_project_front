import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/Offer and Supreme/Supreme.dart' as myAppSupreme;
import 'package:ap_finale_project_front/Cart/Cart.dart';
CartProduct b = CartProduct(
  name: 'گوشی موبایل تایتانیک مدل 2 Phone با سیم کارت ظرفیت 512 گیگابایت و رم 12 گیگابایت',
  price: 11250000,
  image: 'assets/phone.png',
  capacity: '512 گیگابایت',
  color: 'مشکی',
);
User a = User(fname: "علی",lname:"صائمی",email: "alisaemi0005@gmail.com",phoneNumber: "0932565255",nationalID: "0025379151",password: "1234",sub: "معمولی");
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
      home: Cart(product: b),
    );
  }
}