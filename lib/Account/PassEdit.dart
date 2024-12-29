import 'package:flutter/material.dart';
import 'NameEdit.dart';
import 'EditInfo.dart';

class changePassword extends StatelessWidget {
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
                'تغییر رمز عبور',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),

            Container(
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextField(textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'رمز عبور فعلی',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'رمز عبور جدید',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'تکرار رمز عبور',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
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
                  MaterialPageRoute(builder: (context) => changeName()),
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
}