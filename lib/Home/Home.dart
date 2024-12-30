import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget{
  Widget build(BuildContext context) {
  return Scaffold(
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
            Left_img: 'assets/icon.jpg',
            Right_img: 'assets/Offer.jpg',
            title: "تخفیفات شگفت انگیز",
            backgroundColor: Color.fromRGBO(213, 49, 49, 0.6),
            Color: Color(0xFFA80404),
            products: List.generate(
              3,
                  (index) => ProductCard(
                title: " گوشی موبایل بلک ویو مدل Shark 9",
                price: "12,500,000",
                FullPrice: "11,529,000",
                rating: "4.5",
                backgroundColor: Color.fromRGBO(213, 49, 49, 0.6),
                Img: 'assets/product.jpg',
              ),
            ),
          ),
          _buildProductSection(
            Left_img: 'assets/Stars.jpg',
            Right_img: 'assets/Star.jpg',
            Color: Color(0xFFC07F00),
            title: "محصولات برتر        ",
            backgroundColor: Color.fromRGBO(255, 176, 0, 0.5),
            products: List.generate(
              3,
                  (index) => ProductCard(
                  title: " گوشی موبایل بلک ویو مدل Shark 9",
                  price: "12,500,000",
                  FullPrice: "11,529,000",
                  rating: "4.5",
                  backgroundColor: Color.fromRGBO(255, 176, 0, 0.5),
                  Img: 'assets/product.jpg',
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
    required Color Color,
    required List<Widget> products,
    required String Left_img,
    required String Right_img,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                Right_img,
                height: 24,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color,
                ),
              ),
              SizedBox(width: 100,),
              TextButton(
                onPressed: () {},
                child:
                    Text(
                      "مشاهده همه",
                      style: TextStyle(color: Color),
                    ),
              ),
              Image.asset(
                Left_img,
                height: 24,
              ),
            ],
          ),
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
  final String FullPrice;
  final String price;
  final String rating;
  final Color backgroundColor;
  final String Img;

  const ProductCard({
    required this.title,
    required this.FullPrice,
    required this.price,
    required this.rating,
    required this.backgroundColor,
    required this.Img
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
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      Img,
                      height: 100,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          // Product Details
          Directionality(textDirection: TextDirection.ltr, child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 4),
                  Image.asset(
                    'assets/Toman.png',
                    height: 16,
                  ),
                  SizedBox(height: 8),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                FullPrice,
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.grey,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ]
            )
          )

        ],
      ),
    );
  }
}