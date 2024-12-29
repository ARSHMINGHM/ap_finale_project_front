import 'package:flutter/material.dart';
import 'EditInfo.dart';

class changeSubscription extends StatefulWidget {
  @override
  _ChangeSubscriptionState createState() => _ChangeSubscriptionState();
}
class _ChangeSubscriptionState extends State<changeSubscription> {
  int? selectedOption; // ذخیره انتخاب تنها یک گزینه

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),
      backgroundColor: Color(0xFFDFF2EB),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'نوع اشتراک خود را معلوم کنید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 120),
            Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFCDC1FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  _buildCheckboxOption('اشتراک پایه', 1),
                  SizedBox(height: 15,),
                  _buildCheckboxOption('اشتراک استاندارد', 2),
                  SizedBox(height: 15,),
                  _buildCheckboxOption('اشتراک پریمیوم', 3),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Account()),
                );
              },
              child: Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(String text, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Checkbox(
          value: selectedOption == value,
          onChanged: (bool? isSelected) {
            setState(() {
              selectedOption = isSelected! ? value : null;
            });
          },
          activeColor: Colors.blue,
          checkColor: Colors.white,
          shape: CircleBorder(),
          side: BorderSide(color: Color(0xFF787474), width: 2),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}