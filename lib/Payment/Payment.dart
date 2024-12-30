import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  final int total;

  const Payment({required this.total, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController cartNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8EBE4),
        title: const Text(
          'پرداخت',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFD8EBE4),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'اطلاعات پرداخت',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: cartNumberController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'شماره کارت (16 رقم)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                labelText: 'رمز دوم (اینترنتی)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'مبلغ کل:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${total.toStringAsFixed(0)} تومان',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Validation Logic
                String cartNumber = cartNumberController.text.trim();
                String password = passwordController.text.trim();

                if (cartNumber.isEmpty || password.isEmpty) {
                  // Show error if fields are empty
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('خطا'),
                      content: const Text('لطفاً همه اطلاعات را وارد کنید.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('باشه'),
                        ),
                      ],
                    ),
                  );
                } else if (cartNumber.length != 16 || !RegExp(r'^\d{16}$').hasMatch(cartNumber)) {
                  // Show error if cart number is not valid
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('خطا'),
                      content: const Text('شماره کارت باید دقیقاً 16 رقم باشد.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('باشه'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Simulate payment confirmation
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('پرداخت موفق'),
                      content: const Text(
                          'پرداخت با موفقیت انجام شد. سفارش شما در حال پردازش است.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Return to previous page
                          },
                          child: const Text('باشه'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text(
                'پرداخت',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
