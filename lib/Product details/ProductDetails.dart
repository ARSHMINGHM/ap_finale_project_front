import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Product details/TechnicalSpecs.dart';
import 'package:ap_finale_project_front/Product.dart' as MainProduct;
import 'package:ap_finale_project_front/FakeData.dart';
Product myProduct = Product(
  title: "گوشی موبایل اپل مدل iPhone 13 Pro ZAA",
  description: "دو سیم کارت ظرفیت ۱۲۸ گیگابایت و رم ۶ گیگابایت",
  price: 1200.00,
  stock: 26,
  seller: "دیجی کالا",
  rating: 4.5,
  features: [
    "نسخه سیستم عامل: iOS 15",
    "اندازه: ۶.۱ اینچ",
    "رزولوشن دوربین اصلی: ۱۲ مگاپیکسل",
    "فناوری صفحه نمایش: Super Retina XDR OLED",
  ],
  imagePath: 'assets/Iphone.jpg',
);
final specs = ProductSpecs(
  phoneType: 'iOS سیستم عامل',
  category: 'پرچمدار',
  model: 'iPhone 13 Pro ZAA',
  releaseDate: '۱۴ سپتامبر ۲۰۲۱',
  dimensions: '۱۴۶.۷×۷۱.5×۷.۷ میلی‌متر',
);
class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductdetailsState();
}

class _ProductdetailsState extends State<ProductDetails> {
  final TextEditingController _reviewController = TextEditingController();
  final List<String> _reviews = [];
  bool _isLiked = false;
  void _addReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        _reviews.add(_reviewController.text);
        _reviewController.clear();
      });
    }
  }

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
                  MaterialPageRoute(
                      builder: (context) => Cart(
                        product: fakeProducts,
                      )),
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Image
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                child: Stack(
                  children: [
                    // Product Image
                    Positioned.fill(
                      child: Image.asset(
                        myProduct.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Like Button
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isLiked = !_isLiked; // Toggle the like state
                });
              },
              child: Icon(
                Icons.favorite,
                size: 40,
                color: _isLiked ? Colors.red : Colors.grey, // Change color based on state
              ),
            ),),
                  ],
                ),
              ),
              // Product Title and Description
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // RTL start is right
                  children: [
                    Text(
                      myProduct.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      myProduct.description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Seller Information
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // RTL start is right
                  children: [
                    const Row(
                      children: [
                        Text(
                          "اطلاعات فروشنده و محصول",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    buildInfoRow("فروشنده:", "دیجی کالا"),
                    buildInfoRow("موجودی محصول:", "۲۶"),
                    buildInfoRow("تعداد فروش:", "۲۶"),
                    buildInfoRow("امتیاز محصول:", "۳ از ۵", showStars: true),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Product Features
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // RTL start is right
                  children: [
                    const Row(
                      children: [
                        Text(
                          "ویژگی محصول",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    buildFeatureRow("نسخه سیستم عامل", "iOS 15"),
                    buildFeatureRow("اندازه", "۶.۱"),
                    buildFeatureRow("فناوری صفحه نمایش", "Super Retina XDR OLED"),
                    buildFeatureRow("رزولوشن دوربین اصلی", "۱۲ مگاپیکسل"),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TechnicalSpecs(product:myProduct, specs: specs,)),);
                        },
                        child: const Text(
                          "مشاهده همه ویژگی ها",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // User Reviews
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // RTL start is right
                  children: [
                    const Text(
                      "دیدگاه کاربران",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    TextField(
                      controller: _reviewController,
                      decoration: InputDecoration(
                        hintText: "دیدگاه خود را وارد کنید...",
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: _addReview,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_reviews.isEmpty)
                      const Center(
                        child: Text("هنوز دیدگاهی ثبت نشده است"),
                      )
                    else
                      Column(
                        children: _reviews
                            .map((review) => ListTile(
                          title: Text(review),
                          leading: const Icon(Icons.person),
                        ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.15, // Adjust percentage as needed
        child: Column(
          children: [
            PriceCard(),
            Expanded(
              child: ConvexAppBar(
                color: const Color(0XFF757C84),
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
                      MaterialPageRoute(builder: (context) =>  Home()),
                    );
                  } else if (i == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value, {bool showStars = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
          if (showStars) const SizedBox(width: 8),
          if (showStars)
            Row(
              children: List.generate(
                5,
                    (index) => Icon(
                  index < 3 ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildFeatureRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle Add to Cart
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical:15),
            ),
            child: Text(
              "افزودن به سبد خرید",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Discount and Prices
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Discount badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "20%", // Replace with your discount
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              SizedBox(height: 5),
              // Original price
              Text(
                "۲۰۰,۰۰۰ تومان", // Original price
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              // Discounted price
              Text(
                "۱۶۰,۰۰۰ تومان", // Discounted price
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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

class Product {
  final String title;
  final String description;
  final double price;
  final int stock;
  final String seller;
  final double rating;
  final List<String> features;
  final String imagePath;

  Product({
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.seller,
    required this.rating,
    required this.features,
    required this.imagePath,
  });
}
class ProductSpecs {
  final String phoneType;
  final String category;
  final String model;
  final String releaseDate;
  final String dimensions;

  ProductSpecs({
    required this.phoneType,
    required this.category,
    required this.model,
    required this.releaseDate,
    required this.dimensions,
  });
}