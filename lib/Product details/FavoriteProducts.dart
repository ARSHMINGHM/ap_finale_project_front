import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Product details/TechnicalSpecs.dart';
import 'package:ap_finale_project_front/Product.dart' as MainProduct;
import 'package:ap_finale_project_front/FakeData.dart';

import 'package:flutter/material.dart';



class FavoriteProducts extends StatelessWidget {
  final User user;

  FavoriteProducts({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8EBE4),
      appBar: AppBar(title: Text("لیست علاقه مندی ها"),
        backgroundColor: const Color(0xFFFF8A8A),),
      bottomNavigationBar: ConvexAppBar(
        color: Color(0XFF757C84),
        initialActiveIndex: 2,
        top: -12.0,
        activeColor: Color(0XFF000000),
        backgroundColor: Color(0XFFDFF2EB),
        style: TabStyle.textIn,
        items: [
          TabItem(icon: Icons.category_outlined, title: 'Category',),
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        onTap: (int i) {
          if (i == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Category()),
            );
          } else if (i == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          }
        },
      ),
      body: ListView.builder(
        itemCount: user.FavoriteProducts.length,
        itemBuilder: (context, index) {
          final product = user.FavoriteProducts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Image.asset(
                  product.img,
                  width:80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "قیمت: ${product.price} تومان",
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}