import 'package:ap_finale_project_front/Payment/Payment.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Payment/Payment.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/clientSocket.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/clientSocket.dart';

class Address extends StatefulWidget {
  final int total;
  final int deliveryFee;

  const Address({
    required this.total,
    this.deliveryFee = 112500, // Default delivery fee
    Key? key,
  }) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  int? selectedAddressIndex;
  final TextEditingController newAddressController = TextEditingController();

  // Method to check if user has premium subscription
  bool _hasPremiumSubscription() {
    return a.sub == 'پریمیوم';
  }

  // Method to check if cart contains a premium subscription
  bool _hasPremiumSubscriptionInCart() {
    return a.shoppingCart.any((product) =>
    product.category == 'Subscription' &&
        product.title == 'اشتراک پریمیوم');
  }

  // Calculate delivery fee based on subscription status
  int _calculateDeliveryFee() {
    if (_hasPremiumSubscription() || _hasPremiumSubscriptionInCart()) {
      return 0; // Free shipping for premium subscribers
    }
    return widget.deliveryFee; // Default delivery fee
  }

  @override
  Widget build(BuildContext context) {
    final int deliveryFee = _calculateDeliveryFee();
    final int totalAmount = widget.total + deliveryFee;

    return Scaffold(
      backgroundColor: const Color(0xFFD8EBE4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD8EBE4),
        title: const Row(
          children: [
            Icon(Icons.location_on_outlined),
            SizedBox(width: 8),
            Text('آدرس', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    for (int i = 0; i < clientSocket.instance.addresses!.length; i++)
                      _buildAddressItem(clientSocket.instance.addresses![i], i),
                    _buildNewAddressInput(),
                  ],
                ),
              ),

              // Modified price summary
              _buildPriceSummary(widget.total, deliveryFee, totalAmount),
            ],
          ),
        ],
      ),
    );
  }

  // Modified price summary widget to show free shipping if applicable
  Widget _buildPriceSummary(int total, int deliveryFee, int totalAmount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildPriceRow('قیمت کل کالا', total),
          const SizedBox(height: 8),
          _buildPriceRow(
              'هزینه ارسال',
              deliveryFee,
              additionalWidget: deliveryFee == 0
                  ? Text(
                'ارسال رایگان',
                style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold),
              )
                  : null
          ),
          const SizedBox(height: 8),
          _buildPriceRow('قابل پرداخت', totalAmount, isBold: true),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF4646),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (selectedAddressIndex == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لطفاً یک آدرس را انتخاب کنید')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('آدرس تایید شد: ${clientSocket.instance.addresses?[selectedAddressIndex!]}'),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(total: totalAmount),
                    ),
                  );
                }
              },
              child: const Text(
                'تایید آدرس',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Modified price row to support additional widget
  Widget _buildPriceRow(String title, int amount, {bool isBold = false, Widget? additionalWidget}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Row(
          children: [
            Text(
              '${amount.toStringAsFixed(0)} تومان',
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (additionalWidget != null) ...[
              const SizedBox(width: 8),
              additionalWidget,
            ],
          ],
        ),
      ],
    );
  }
  Widget _buildAddressItem(String address, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Radio<int>(
          value: index,
          groupValue: selectedAddressIndex,
          onChanged: (int? value) {
            setState(() {
              selectedAddressIndex = value;
            });
          },
        ),
        title: Text(
          'ارسال به آدرس انتخاب شده',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        subtitle: Text(address),
        trailing: const Icon(Icons.directions_car_outlined),
      ),
    );
  }

  Widget _buildNewAddressInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: newAddressController,
            decoration: const InputDecoration(
              labelText: 'ایجاد آدرس جدید',
              hintText: 'آدرس خود را وارد کنید',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async{
              if (newAddressController.text.isNotEmpty) {
                String address = newAddressController.text;
                int status = await clientSocket.instance.sendAddAddressCommand(clientSocket.instance.userName??'', address);
                setState(() {
                  if(status == 200){
                    print("address added successful");
                  }else if(status == 400){
                    print("address duplicate");
                  }
                  else if(status == 404){
                    print("address not found");
                  }
                  else{
                    print("error");
                  }
                  //a.addresses?.add(newAddressController.text);
                  newAddressController.clear();
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
            ),
            child: const Text(
              'اضافه کردن آدرس',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
