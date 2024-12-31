import 'package:ap_finale_project_front/Offer%20and%20Supreme/Offer.dart';
import 'package:ap_finale_project_front/Offer%20and%20Supreme/Supreme.dart';
import 'package:ap_finale_project_front/Product%20details/ProductDetails.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/main.dart';
class Home extends StatelessWidget{
  const Home({super.key});
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
    body: SingleChildScrollView(
      child: Column(
        children: [
          _buildProductSection(
            OfferOrSupreme: 0,
            parentContext: context,
            Left_img: 'assets/icon.jpg',
            Right_img: 'assets/Offer.jpg',
            title: "تخفیفات شگفت انگیز",
            backgroundColor: const Color.fromRGBO(213, 49, 49, 0.6),
            color: const Color(0xFFA80404),
            products: List.generate(
              3,
                  (index) => const ProductCard(
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
            OfferOrSupreme: 1,
            parentContext: context,
            Left_img: 'assets/Stars.jpg',
            Right_img: 'assets/Star.jpg',
            color: const Color(0xFFC07F00),
            title: "محصولات برتر        ",
            backgroundColor: const Color.fromRGBO(255, 176, 0, 0.5),
            products: List.generate(
              3,
                  (index) => const ProductCard(
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
      color: const Color(0XFF757C84),
    top: -12.0,
    activeColor: const Color(0XFF000000),
    backgroundColor: const Color(0XFFDFF2EB),
    initialActiveIndex: 1,
    style: TabStyle.textIn,
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
  Widget _buildProductSection({
    required BuildContext parentContext,
    required String title,
    required int OfferOrSupreme,
    required Color backgroundColor,
    required Color color,
    required List<Widget> products,
    required String Left_img,
    required String Right_img,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                  color: color,
                ),
              ),
              const SizedBox(width: 100,),
              TextButton(
                onPressed: () {
                  if (OfferOrSupreme < 1){
                    Navigator.push(
                      parentContext,
                      MaterialPageRoute(builder: (context) => const Offer()),
                    );
                  }
                  else{
                  Navigator.push(
                    parentContext,
                    MaterialPageRoute(builder: (context) => const Supreme()),
                  );}
                },
                child:
                    Text(
                      "مشاهده همه",
                      style: TextStyle(color: color),
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
                  padding: const EdgeInsets.only(right: 12),
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

  const ProductCard({super.key,
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          TextButton(onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductDetails()),
            );
          }, child:
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
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            rating,
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
          const SizedBox(height: 8),
          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductDetails()),
            );
          }, child:Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          const SizedBox(height: 8),
          // Product Details
          Directionality(textDirection: TextDirection.ltr, child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 4),
                  Image.asset(
                    'assets/Toman.png',
                    height: 16,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                FullPrice,
                style: const TextStyle(
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