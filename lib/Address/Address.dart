import 'package:ap_finale_project_front/Payment/Payment.dart';
import 'package:flutter/material.dart';

class Address extends StatefulWidget {
  final int total;
  final int deliveryFee;

  const Address({
    required this.total,
    this.deliveryFee = 112500,
    Key? key,
  }) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List<String> addresses = ['تهران .......', 'تهران .......'];
  int? selectedAddressIndex;
  final TextEditingController newAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    for (int i = 0; i < addresses.length; i++)
                      _buildAddressItem(addresses[i], i),
                    _buildNewAddressInput(),
                  ],
                ),
              ),
              _buildPriceSummary(),
            ],
          ),
        ],
      ),
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
            onPressed: () {
              if (newAddressController.text.isNotEmpty) {
                setState(() {
                  addresses.add(newAddressController.text);
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

  Widget _buildPriceSummary() {
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
          _buildPriceRow('قیمت کل کالا', widget.total),
          const SizedBox(height: 8),
          _buildPriceRow('هزینه ارسال', widget.deliveryFee),
          const SizedBox(height: 8),
          _buildPriceRow('قابل پرداخت', widget.total + widget.deliveryFee, isBold: true),
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
                      content: Text('آدرس تایید شد: ${addresses[selectedAddressIndex!]}'),
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Payment(total: widget.total)),);
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

  Widget _buildPriceRow(String title, int amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          '${amount.toStringAsFixed(0)} تومان',
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
