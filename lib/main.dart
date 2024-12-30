import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/Offer and Supreme/Supreme.dart' as myAppSupreme;
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
      home: Home(),
    );
  }
}