import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'EmailEdit.dart';
import 'IdEdit.dart';
import 'NameEdit.dart';
import 'NumberEdit.dart';
import 'PassEdit.dart';
import 'SubscriptionEdit.dart';

class changePhone extends StatefulWidget {
  @override
  ChangePhone  createState() => ChangePhone ();
}
class ChangePhone extends State<changePhone> {
  TextEditingController phoneController = TextEditingController();
  String errorMessage = '';
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
                MaterialPageRoute(builder: (context) => home()),
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
                'شماره تلفن خود را وارد نمایید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            Container(
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  TextField(
                    controller: phoneController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '${a.phoneNumber}',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  SizedBox(height: 30),
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
                setState(() {
                  String phoneNumber = phoneController.text;
                  if (phoneNumber.length != 11 || !phoneNumber.startsWith('09')) {

                    errorMessage = 'لطفاً شماره تلفن را صحیح وارد کنید .';
                  } else {

                    errorMessage = '';
                    a.phoneNumber = phoneNumber;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  }
                });
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
}
