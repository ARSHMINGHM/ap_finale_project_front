import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Category/Category.dart' as myAppCategory;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Account/EditInfo.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? SizedBox.shrink(),
        );
      },
      debugShowCheckedModeBanner: false,
      home: myAppCategory.Category(),
    );
  }
}