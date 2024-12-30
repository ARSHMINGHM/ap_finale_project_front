import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';

class changePassword extends StatefulWidget {
  @override
  ChangePassword createState() => ChangePassword();
}

class ChangePassword extends State<changePassword> {
  TextEditingController PreviousPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController repeatNewPassword = TextEditingController();
  String errorMessage = '';

  bool isValidPassword(String PreviousPassword, String newPassword, String repeatNewPassword) {
    if (a.password != PreviousPassword) {
      errorMessage = 'رمز فعلی اشتباه وارد شده';
      return false;
    } else if (newPassword != repeatNewPassword) {
      errorMessage = 'رمز تکرار شده اشتباه است';
      return false;
    }else if(PreviousPassword == newPassword){
      errorMessage = 'رمز یکبار استفاده شده است';
      return false;

    }

    return true;
  }

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
                'تغییر رمز عبور',
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
                    controller: PreviousPassword,
                    textAlign: TextAlign.right,
                    obscureText: true,
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
                    controller: newPassword,
                    textAlign: TextAlign.right,
                    obscureText: true,
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
                    controller: repeatNewPassword,
                    textAlign: TextAlign.right,
                    obscureText: true,
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
                  if (errorMessage.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red, fontSize: 14),
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
                setState(() {
                  String prePass = PreviousPassword.text;
                  String newPass = newPassword.text;
                  String repNewPass = repeatNewPassword.text;
                  bool valid = isValidPassword(prePass, newPass, repNewPass);
                  if (valid) {
                    a.password = newPass;
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