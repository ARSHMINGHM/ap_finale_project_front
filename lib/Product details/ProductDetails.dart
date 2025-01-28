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
import '../Category/CategoryListProduct.dart';

class ProductDetails extends StatefulWidget {
  final MainProduct.Product Product;
  const ProductDetails({
    required this.Product,
  });

  @override
  State<ProductDetails> createState() => _ProductdetailsState(Product: Product);
}

class _ProductdetailsState extends State<ProductDetails> {
  final MainProduct.Product Product;
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> userReviews = [];
  bool _isLiked = false;

  _ProductdetailsState({required this.Product});

  @override
  void dispose() {
    searchController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  void navigateToSearch(BuildContext context) {
    if (searchController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Categorylistproduct(
            category: '',
            initialSearchQuery: searchController.text,
          ),
        ),
      );
    }
  }

  void _showRatingDialog() {
    int selectedRating = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('امتیاز به محصول'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < selectedRating ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _reviewController,
                    decoration: const InputDecoration(
                      hintText: 'نظر خود را بنویسید...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('انصراف'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedRating > 0 && _reviewController.text.isNotEmpty) {
                      setState(() {
                        userReviews.add({
                          'rating': selectedRating,
                          'review': _reviewController.text,
                        });
                        _reviewController.clear();
                      });
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('لطفاً امتیاز و نظر خود را وارد کنید'),
                        ),
                      );
                    }
                  },
                  child: const Text('ثبت'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8EBE4),
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildProductImage(),
                    _buildProductTitle(),
                    _buildSellerInfo(),
                    _buildProductFeatures(),
                    _buildUserReviews(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomSection(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
                    icon: const Icon(Icons.search, color: Colors.black),
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
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart(product: fakeProducts)),
            ),
            child: const Icon(
              Icons.shopping_cart,
              color: Color(0xFF000000),
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Product.img,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isLiked = !_isLiked;
                  if (_isLiked) {
                    a.FavoriteProducts.add(Product);
                  }
                });
              },
              child: Icon(
                Icons.favorite,
                size: 40,
                color: _isLiked ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTitle() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Text(
        Product.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSellerInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "اطلاعات فروشنده و محصول",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          buildInfoRow("فروشنده:", "دیجی کالا"),
          buildInfoRow("موجودی محصول:", "${Product.stock}"),
          buildInfoRow("تعداد فروش:", "${Product.soldCount}"),
          buildInfoRow("امتیاز محصول:", "${Product.productScore} از ۵", showStars: true),
        ],
      ),
    );
  }

  Widget _buildProductFeatures() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "ویژگی محصول",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          ...Product.specs.features.map((feature) => buildFeatureRow(feature, "")),
          buildFeatureRow("نوع تلفن", Product.specs.phoneType),
          buildFeatureRow("مدل", Product.specs.model),
          buildFeatureRow("تاریخ انتشار", Product.specs.releaseDate),
          buildFeatureRow("ابعاد", Product.specs.dimensions),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TechnicalSpecs(product: Product),
                  ),
                );
              },
              child: const Text(
                "مشاهده همه ویژگی ها",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserReviews() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "دیدگاه کاربران",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: _showRatingDialog,
                child: const Text(
                  '+ افزودن نظر',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const Divider(),
          if (userReviews.isEmpty)
            const Center(
              child: Text("هنوز دیدگاهی ثبت نشده است"),
            )
          else
            Column(
              children: userReviews.map((reviewItem) {
                return ListTile(
                  title: Text(reviewItem['review']),
                  subtitle: Row(
                    children: List.generate(
                      5,
                          (index) => Icon(
                        index < reviewItem['rating']
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Column(
        children: [
          PriceCard(Product: Product),
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
          ),
        ],
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
            value.isEmpty ? label : value,
            style: const TextStyle(fontSize: 14),
          ),
          if (value.isNotEmpty)
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
  final MainProduct.Product Product;

  const PriceCard({Key? key, required this.Product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              a.shoppingCart.add(Product);
              print("added");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text(
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "${Product.discount}%",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(height: 5),
              // Original price
              Text(
                "${Product.fullPrice} تومان",
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              // Discounted price
              Text(
                "${Product.price} تومان",
                style: const TextStyle(
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