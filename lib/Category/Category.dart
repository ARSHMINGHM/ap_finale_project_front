import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFF2EB),
      appBar: AppBar(
        backgroundColor: Color(0xFFD8EBE4),
        elevation: 0,
        title: Row(
          children: [
            // Search Bar
            Expanded(
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFC1D2CC),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '... جستجو محصول',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.black),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Icon(Icons.shopping_cart, color: Colors.black, size: 24),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        color: Color(0XFF757C84),
        top: -12.0,
        activeColor: Color(0XFF000000),
        backgroundColor: Color(0XFFDFF2EB),
        style: TabStyle.textIn,
        items: [
          TabItem(icon: Icons.category_outlined, title: 'Category'),
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
      body: Column(
        children: [
          _buildNestedSection(
            title: "کالای دیجیتال",
            items: [
              _buildSelectableProductCard("لوازم جانبی", 'assets/mobile-accessories.jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("لوازم جانبی انتخاب شد");
                },
              ),
              _buildSelectableProductCard("تبلت", 'assets/a950a328b44888bacbf40e3ab4a1fb49e8dc4a22_1669727482.jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("تبلت انتخاب شد");
                },
              ),
              _buildSelectableProductCard("لپ‌تاپ", 'assets/Laptops.jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("لپ‌تاپ انتخاب شد");
                },
              ),
            ],
          ),
          _buildNestedSection(
            title: "مد و پوشاک",
            items: [
              _buildSelectableProductCard("پوشاک مردانه", 'assets/thumb_16457792563144_index.jpg', 60,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("پوشاک مردانه انتخاب شد");
                },
              ),
              _buildSelectableProductCard("پوشاک زنانه", 'assets/images (4).jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("پوشاک زنانه انتخاب شد");
                },
              ),
              _buildSelectableProductCard("بچکانه", 'assets/1425382_772.jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("بچکانه انتخاب شد");
                },
              ),
            ],
          ),
          _buildNestedSection(
            title: "لوازم آرایشی و بهداشتی",
            items: [
              _buildSelectableProductCard("لوازم آرایشی", 'assets/cosmetic2.jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("لوازم آرایشی انتخاب شد");
                },
              ),
              _buildSelectableProductCard("مراقبت پوست", 'assets/images (6).jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/
                  print("مراقبت پوست انتخاب شد");
                },
              ),
              _buildSelectableProductCard("عطر و ادکلن", 'assets/images (5).jpg', 12,
                    () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ....()),  // Replace with actual page
                      );*/

                  print("عطر و ادکلن انتخاب شد");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNestedSection({required String title, required List<Widget> items}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xff777474).withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: items.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFEAE4DD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: item,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectableProductCard(String title, String imagePath, double circular, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: _buildProductCard(title, imagePath, circular),
    );
  }
  Widget _buildProductCard(String title, String imagePath, double circular) {
    return Container(
      width: 110,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(circular),
            child: Container(
              height: 110,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
