import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Product.dart' as MainProduct;
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';

class TechnicalSpecs extends StatelessWidget {
  final MainProduct.Product product;

  const TechnicalSpecs({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProduct.ProductSpecs specs = product.specs;

    return Scaffold(
      backgroundColor: const Color(0xFFD8EBE4),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Technical Specifications
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F3F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const Text(
                          'مشخصات فنی',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Basic Specs
                    buildSpecRow('نوع محصول', specs.phoneType),
                    const Divider(color: Colors.black12),
                    buildSpecRow('مدل', specs.model),
                    const Divider(color: Colors.black12),
                    buildSpecRow('تاریخ انتشار', specs.releaseDate),
                    const Divider(color: Colors.black12),
                    buildSpecRow('ابعاد', specs.dimensions),
                    const Divider(color: Colors.black12),

                    // Dynamic Features
                    const Text(
                      'ویژگی‌های محصول',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...specs.features.map((feature) => Column(
                      children: [
                        buildSpecRow(feature, ''),
                        const Divider(color: Colors.black12),
                      ],
                    )).toList(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
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
    );
  }

  Widget buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value.isNotEmpty ? value : label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              textAlign: value.isNotEmpty ? TextAlign.left : TextAlign.right,
            ),
          ),
          if (value.isNotEmpty)
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
        ],
      ),
    );
  }
}