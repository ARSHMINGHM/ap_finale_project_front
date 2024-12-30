import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/main.dart';
final products = [
Product(
  name: 'گوشی موبایل اپل مدل ZAA Pro 13 iPhone',
  currentPrice: 16000,
  originalPrice: 20000,
  image: 'assets/iphone.jpg',
  stars: 3,
  discount: 20,)
  ,Product(
  name: 'گوشی موبایل اپل مدل ZAA Pro 13 iPhone',
  currentPrice: 16000,
  originalPrice: 20000,
  image: 'assets/iphone.jpg',
  stars: 4,
  discount: 2,
  )
  ,Product(
  name: 'گوشی موبایل اپل مدل ZAA Pro 13 iPhone',
  currentPrice: 16000,
  originalPrice: 20000,
  image: 'assets/iphone.jpg',
  stars: 3,
  discount: 20,
  )
  ,Product(
  name: 'گوشی موبایل اپل مدل ZAA Pro 13 iPhone',
  currentPrice: 16000,
  originalPrice: 20000,
  image: 'assets/iphone.jpg',
  stars: 3,
  discount: 20,
  )
  ,Product(
  name: 'گوشی موبایل اپل مدل ZAA Pro 13 iPhone',
  currentPrice: 16000,
  originalPrice: 20000,
  image: 'assets/iphone.jpg',
  stars: 3,
  discount: 20,
  )
  ,Product(
  name: 'گوشی موبایل اپل مدل ZAA Pro 13 iPhone',
  currentPrice: 16000,
  originalPrice: 20000,
  image: 'assets/iphone.jpg',
  stars: 3,
  discount: 20,
  )
];
class Offer extends StatelessWidget{
  const Offer({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8EBE4),
        appBar: AppBar(
          automaticallyImplyLeading: false, // Removes default back button
          backgroundColor: const Color(0xFFD8EBE4),
          title: Row(
            children: [
              // Search Bar
              Expanded(
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC1D2CC),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'جستجو محصول ...',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            print('Search: $value');
                          },
                        ),
                      ),
                      const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 18),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart(product: b,)),
                  );
                },
                child: Container(
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xFF000000),
                    size: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        body:Column(
            children: [
        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.filter_alt),
          const Icon(Icons.sort),
        ],
      ),
    ),
    Expanded(
    child: ListView.builder(
    itemCount: products.length, // Your products list
    itemBuilder: (context, index) {
    return ProductCard(product: products[index]);
    },
    ),
    ),
    ]
    ),
        bottomNavigationBar: ConvexAppBar(
          color: const Color(0XFF757C84),
          top: -12.0,
          activeColor: const Color(0XFF000000),
          backgroundColor: const Color(0XFFDFF2EB),
          style: TabStyle.textIn,
          initialActiveIndex: 1,
          items: const [
            TabItem(icon: Icons.category_outlined, title: 'Category'),
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          onTap: (int i) {
            if (i == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Category()),
              );
            } else if (i == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            } else if (i == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            }
          },
        )
    );
  }
}
class Product {
  final String name;
  final double currentPrice;
  final double originalPrice;
  final String image;
  final int stars;
  final double discount;

  Product({
    required this.name,
    required this.currentPrice,
    required this.originalPrice,
    required this.image,
    required this.stars,
    required this.discount,
  });
}
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFE4E6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Image container with discount
                        Stack(
                          children: [
                            Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Image.asset(
                                  product.image,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            ),
                            if (product.discount > 0)
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    '${product.discount.toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(width: 8), // Space between the image and the text

                        // Text column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' ${product.currentPrice.toStringAsFixed(0)} تومان ',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ' ${product.originalPrice.toStringAsFixed(0)} تومان ',
                                        style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: List.generate(
                        5,
                            (index) => Icon(
                          index < product.stars ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(width: 8),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}