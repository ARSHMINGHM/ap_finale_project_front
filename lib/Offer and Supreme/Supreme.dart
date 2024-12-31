import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Product.dart' as MainProduct;
import 'package:ap_finale_project_front/FakeData.dart';

import '../Product details/ProductDetails.dart';
final products = fakeProducts;
class Supreme extends StatefulWidget {
  const Supreme({super.key});

  @override
  State<Supreme> createState() => _SupremeState();
}

class _SupremeState extends State<Supreme> {
  late List<MainProduct.Product> topProduct;
  String? selectedCategory;

  final List<String> categories = [
    'Accessories',
    'Tablet',
    'Laptop',
    "Kid's Clothing",
    "Women's Clothing",
    "Men's Clothing",
    'Cosmetics',
    'Skincare',
    'Perfume',
  ];

  @override
  void initState() {
    super.initState();
    topProduct = getAmazingOffers(products);
  }

  List<MainProduct.Product> getAmazingOffers(List<MainProduct.Product> allProducts) {
    var filteredList = allProducts.where((product) => product.isAmazingOffer == true).toList();

    if (selectedCategory != null) {
      filteredList = filteredList.where((product) =>
      product.category.toLowerCase() == selectedCategory!.toLowerCase()
      ).toList();
    }

    return filteredList;
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by Category'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('All Categories'),
                    leading: Radio<String?>(
                      value: null,
                      groupValue: selectedCategory,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value;
                          topProduct = getAmazingOffers(products);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  ...categories.map((category) => ListTile(
                    title: Text(category),
                    leading: Radio<String?>(
                      value: category,
                      groupValue: selectedCategory,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value;
                          topProduct = getAmazingOffers(products);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void sortProducts(String value) {
    setState(() {
      switch (value) {
        case 'Name':
          topProduct.sort((a, b) => a.title.compareTo(b.title));
          break;
        case 'Price':
          topProduct.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Ratings':
          topProduct.sort((a, b) => b.rating.compareTo(a.rating));
          break;
      }
    });
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
                  MaterialPageRoute(builder: (context) => Cart(product: products)),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: showFilterDialog,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedCategory != null ? Colors.blue.withOpacity(0.1) : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: selectedCategory != null ? Colors.blue : null,
                        ),
                        if (selectedCategory != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            selectedCategory!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: sortProducts,  // Using the new sortProducts method
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Name',
                        child: Text('Sort by Name'),
                      ),
                      const PopupMenuItem(
                        value: 'Price',
                        child: Text('Sort by Price'),
                      ),
                      const PopupMenuItem(
                        value: 'Ratings',
                        child: Text('Sort by Ratings'),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          if (topProduct.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No products found in this category',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: topProduct.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: topProduct[index]);
                },
              ),
            ),
        ],
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
}
class ProductCard extends StatelessWidget {
  final MainProduct.Product product;
  const ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5DE97),
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
                TextButton(onPressed:(){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetails(Product: product)),
              );
              },child:
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
                                  product.img,
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
                        ),),
                        const SizedBox(width: 8), // Space between the image and the text

                        // Text column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
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
                                        ' ${product.price} تومان ',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ' ${product.fullPrice} تومان ',
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
                          index < int.parse(product.rating) ? Icons.star : Icons.star_border,
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