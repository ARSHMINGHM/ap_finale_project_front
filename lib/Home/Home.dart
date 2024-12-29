import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget{
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFFDFF2EB),

    appBar: AppBar(
    automaticallyImplyLeading: false, // Removes default back button
    backgroundColor: Color(0xFFD8EBE4),

    title: Row(
      children: [

        // Search Bar
        Expanded(
          child: Container(
            height: 35,
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
                      hintText: 'جستجو محصول ...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) {
                      print('Search: $value');
                    },
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 18),
        GestureDetector(
          onTap: () {
          },
          child: Container(
            child: Icon(
              Icons.shopping_cart,
              color: Color(0xFF000000),
              size: 24.0,
            ),
          ),
        ),
      ],
    ),
  ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          _buildProductSection(
            title: "تخفیفات شگفت انگیز",
            backgroundColor: Color(0xFFFFE4E4),
            products: List.generate(
              3,
                  (index) => ProductCard(
                title: "گوشی موبایل بلک ویو",
                subtitle: "Shark 9 مدل",
                price: "1,250,000",
                rating: "4.5",
                backgroundColor: Color(0xFFFFE4E4),
              ),
            ),
          ),
          _buildProductSection(
            title: "محصولات برتر",
            backgroundColor: Color(0xFFFFF3D8),
            products: List.generate(
              3,
                  (index) => ProductCard(
                title: "گوشی موبایل بلک ویو",
                subtitle: "Shark 9 مدل",
                price: "1,250,000",
                rating: "4.5",
                backgroundColor: Color(0xFFFFF3D8),
              ),
            ),
          ),
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
    onTap: (int i) => print('click index=$i'),
    )
  );
  }
  Widget _buildProductSection({
    required String title,
    required Color backgroundColor,
    required List<Widget> products,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "مشاهده همه",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: products.map((product) {
                return Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: product,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String rating;
  final Color backgroundColor;

  const ProductCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rating,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/phone_image.png', // Replace with your image
                      height: 100,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            rating,
                            style: TextStyle(fontSize: 12),
                          ),
                          Icon(Icons.star, size: 12, color: Colors.amber),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          // Product Details
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                "تومان",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 4),
              Text(
                price,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}