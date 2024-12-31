import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Product details/ProductDetails.dart';

class TechnicalSpecs extends StatelessWidget {
  final Product product;
  final ProductSpecs specs;

  const TechnicalSpecs({
    super.key,
    required this.product,
    required this.specs,
  });

  @override
  Widget build(BuildContext context) {
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
                        ElevatedButton(onPressed: () {
                          Navigator.pop(context);
                        }, child:
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.black54,
                        ),),
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
                    buildSpecRow('نوع گوشی موبایل', specs.phoneType),
                    const Divider(color: Colors.black12),
                    buildSpecRow('دسته بندی', specs.category),
                    const Divider(color: Colors.black12),
                    buildSpecRow('مدل', specs.model),
                    const Divider(color: Colors.black12),
                    buildSpecRow('زمان معرفی', specs.releaseDate),
                    const Divider(color: Colors.black12),
                    buildSpecRow('ابعاد', specs.dimensions),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:ConvexAppBar(
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
          // Handle navigation
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
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
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