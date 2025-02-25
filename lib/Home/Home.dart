import 'package:ap_finale_project_front/Offer%20and%20Supreme/Offer.dart';
import 'package:ap_finale_project_front/Offer%20and%20Supreme/Supreme.dart';
import 'package:ap_finale_project_front/Product%20details/ProductDetails.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Product.dart' as MainProduct;
import 'package:ap_finale_project_front/FakeData.dart';
import 'package:ap_finale_project_front/Category/CategoryListProduct.dart';
List<MainProduct.Product> products = fakeProducts;
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void navigateToSearch(BuildContext context) {
    if (searchController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Categorylistproduct(
            category: '', // Empty category to show all products
            initialSearchQuery: searchController.text, // Pass the search query
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8EBE4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFD8EBE4),
        title: Row(
          children: [
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
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'جستجو محصول ...',
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => navigateToSearch(context),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () => navigateToSearch(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
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
                  MaterialPageRoute(
                    builder: (context) => Cart(product: products),
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_cart,
                color: Color(0xFF000000),
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Amazing Offers Section
            _buildProductSection(
              OfferOrSupreme: 0,
              parentContext: context,
              Left_img: 'assets/icon.jpg',
              Right_img: 'assets/Offer.jpg',
              title: "تخفیفات شگفت انگیز",
              backgroundColor: const Color.fromRGBO(213, 49, 49, 0.6),
              color: const Color(0xFFA80404),
              products: products
                  .where((product) => product.isAmazingOffer)
                  .map((product) => ProductCard(
                product: product,
                title: product.title,
                price: product.price,
                fullPrice: product.fullPrice,
                rating: product.rating,
                backgroundColor: product.backgroundColor,
                img: product.img,

              ))
                  .toList(),
            ),
            // Top Products Section
            _buildProductSection(
              OfferOrSupreme: 1,
              parentContext: context,
              Left_img: 'assets/Stars.jpg',
              Right_img: 'assets/Star.jpg',
              color: const Color(0xFFC07F00),
              title: "محصولات برتر",
              backgroundColor: const Color.fromRGBO(255, 176, 0, 0.5),
              products: products
                  .where((product) => product.isTopProduct)
                  .map((product) => ProductCard(
                product: product,
                title: product.title,
                price: product.price,
                fullPrice: product.fullPrice,
                rating: product.rating,
                backgroundColor: product.backgroundColor,
                img: product.img,
              ))
                  .toList(),
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
              MaterialPageRoute(builder: (context) => Home()),
            );
          } else if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }
        },
      ),
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
              const SizedBox(width: 100),
              TextButton(
                onPressed: () {
                  if (OfferOrSupreme < 1) {
                    Navigator.push(
                      parentContext,
                      MaterialPageRoute(builder: (context) => const Offer()),
                    );
                  } else {
                    Navigator.push(
                      parentContext,
                      MaterialPageRoute(builder: (context) => const Supreme()),
                    );
                  }
                },
                child: Text(
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
  final MainProduct.Product product;
  final String title;
  final String fullPrice;
  final String price;
  final String rating;
  final Color backgroundColor;
  final String img;

  const ProductCard({super.key,
    required this.product,
    required this.title,
    required this.fullPrice,
    required this.price,
    required this.rating,
    required this.backgroundColor,
    required this.img
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
              MaterialPageRoute(builder: (context) => ProductDetails(Product: product)),
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
                      img,
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
              MaterialPageRoute(builder: (context) => ProductDetails(Product: product)),
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
                  fullPrice,
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