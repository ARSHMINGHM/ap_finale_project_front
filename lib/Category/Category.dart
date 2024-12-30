import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Profile.dart';
import 'package:untitled/home.dart';


class category extends StatelessWidget {
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
             MaterialPageRoute(builder: (context) => category()),
            );
          } else if (i == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home()),
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
              _buildProductCard("لوازم جانبی", 'assets/mobile-accessories.jpg',12),
              _buildProductCard("تبلت", 'assets/a950a328b44888bacbf40e3ab4a1fb49e8dc4a22_1669727482.jpg',12),
              _buildProductCard("لپ‌تاپ", 'assets/Laptops.jpg',12),
            ],
          ),
          _buildNestedSection(
            title: "مد و پوشاک",
            items: [
              _buildProductCard("پوشاک مردانه", 'assets/thumb_16457792563144_index.jpg',60),
              _buildProductCard("پوشاک زنانه", 'assets/images (4).jpg',12),
              _buildProductCard("بچکانه", 'assets/1425382_772.jpg',12),
              //_buildProductCard("ورزشی", 'assets/1545655016_I0oO9.jpg'),
            ],
          ),
          _buildNestedSection(
            title: "لوازم آرایشی و بهداشتی",
            items: [
              _buildProductCard("لوازم آرایشی", 'assets/cosmetic2.jpg',12),
              _buildProductCard("مراقبت پوست", 'assets/images (6).jpg',12),
              _buildProductCard("عطر و ادکلن", 'assets/images (5).jpg',12),
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
              //borderRadius: BorderRadius.circular(16),
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
                  margin: EdgeInsets.symmetric(horizontal: 6),
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

  Widget _buildProductCard(String title, String imagePath,double circular) {
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
