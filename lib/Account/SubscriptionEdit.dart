import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/main.dart';

class changeSubscription extends StatefulWidget {
  @override
  _ChangeSubscriptionState createState() => _ChangeSubscriptionState();
}

class _ChangeSubscriptionState extends State<changeSubscription> {
  String? selectedOption = a.sub;

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
        bottomNavigationBar: ConvexAppBar(
          color: Color(0XFF757C84),
          top: -12.0,
          activeColor: Color(0XFF000000),
          backgroundColor: Color(0XFFDFF2EB),
          style: TabStyle.textIn,
          items: [
            TabItem(icon: Icons.category_outlined, title: 'Category'),
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.people, title: 'Profile'),
          ],
          onTap: (int i) {
            if (i == 0) {
              /*Navigator.push(
             // context,
            //  MaterialPageRoute(builder: (context) => CategoryPage()),
            );*/
            } else if (i == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            } else if (i == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            }
          },
        ),

    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'نوع اشتراک خود را مشخص کنید',
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
                  _buildRadioOption('اشتراک پایه', 'پایه'),
                  SizedBox(height: 15),
                  _buildRadioOption('اشتراک استاندارد', 'استاندارد'),
                  SizedBox(height: 15),
                  _buildRadioOption('اشتراک پریمیوم', 'پریمیوم'),
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

                print('اشتراک انتخاب شده: ${a.sub}');
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


  Widget _buildRadioOption(String text, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Radio<String>(
          value: value,
          groupValue: selectedOption,
          onChanged: (String? newValue) {
            setState(() {
              selectedOption = newValue!;
              a.sub = selectedOption;
            });
          },
          activeColor: Colors.blue,
        ),
      ],
    );
  }
}
