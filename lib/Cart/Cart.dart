import 'package:ap_finale_project_front/Address/Address.dart';
import 'package:ap_finale_project_front/Offer%20and%20Supreme/Offer.dart';
import 'package:ap_finale_project_front/Offer%20and%20Supreme/Supreme.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
final cartProducts = [
  CartProduct(
    name: 'گوشی موبایل تایتانیک مدل 2 Phone با سیم کارت ظرفیت 512 گیگابایت و رم 12 گیگابایت',
    price: 11250000,
    image: 'assets/Iphone.jpg',
    capacity: '512 گیگابایت',
    color: 'مشکی',
  ),
  CartProduct(
    name: 'گوشی موبایل تایتانیک مدل 2 Phone با سیم کارت ظرفیت 512 گیگابایت و رم 12 گیگابایت',
    price: 11250000,
    image: 'assets/Iphone.jpg',
    capacity: '512 گیگابایت',
    color: 'مشکی',
  ),
];
class Cart extends StatelessWidget {
final CartProduct product;
const Cart({
required this.product,
Key? key,
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFD8EBE4),
        body:CartView(
          products: cartProducts,
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
}
class CartProduct {
  final String name;
  final int price;
  final String image;
  final String capacity;
  final String color;
  int quantity;

  CartProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.capacity,
    required this.color,
    this.quantity = 1,
  });
}

class CartView extends StatefulWidget {
  final List<CartProduct> products;

  const CartView({required this.products, Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int _calculateTotal() {
    int total = 0;
    for (CartProduct product in widget.products) {
      total += product.price * product.quantity;
    }
    return total;
  }

  void _deleteProduct(int index) {
    setState(() {
      widget.products.removeAt(index);
    });
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        widget.products[index].quantity = newQuantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = _calculateTotal();

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFE8F5F0),
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          ),
          child: Row(
            children: [
              const Icon(Icons.shopping_cart, color: Colors.red),
              const SizedBox(width: 8),
              const Text(
                'سبد خرید',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Product List
        Expanded(
          child: ListView.builder(
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CartCard(
                  product: widget.products[index],
                  onDelete: () => _deleteProduct(index),
                  onQuantityChange: (quantity) => _updateQuantity(index, quantity),
                ),
              );
            },
          ),
        ),

        // Footer with Total and Confirm Button
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('جمع سبد خرید'),
                  Text(
                    '${total.toStringAsFixed(0)} تومان',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Address(total: total),
                    ),
                  );
                },
                child: const Text(
                  'تایید و تکمیل سفارش',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CartCard extends StatelessWidget {
  final CartProduct product;
  final VoidCallback onDelete;
  final ValueChanged<int> onQuantityChange;

  const CartCard({
    required this.product,
    required this.onDelete,
    required this.onQuantityChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 90,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Image.asset(
                product.image,
                width: 80,
                height: 80,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(product.color),
                  ],
                ),
                const SizedBox(height: 4),
                Text(product.capacity),
              ],
            ),
          ),

          // Actions (Delete and Quantity)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => onQuantityChange(product.quantity + 1),
                  ),
                  Text('${product.quantity}'),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () => onQuantityChange(product.quantity - 1),
                  ),
                ],
              ),
              Text(
                '${(product.price * product.quantity).toStringAsFixed(0)} تومان',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
