import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class changeEmail extends StatefulWidget {
  const changeEmail({super.key});

  @override
  ChangeEmail  createState() => ChangeEmail ();
}
class ChangeEmail extends State<changeEmail> {
  TextEditingController emailcontroller = TextEditingController();
  String errorMessage = '';

  bool isValidEmail(String email) {

    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$',
    );
    return emailRegExp.hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFFDFF2EB),
      ),

      backgroundColor: const Color(0xFFDFF2EB),
        bottomNavigationBar: ConvexAppBar(
          color: const Color(0XFF757C84),

          initialActiveIndex: 2,
          top: -12.0,
          activeColor: const Color(0XFF000000),
          backgroundColor: const Color(0XFFDFF2EB),
          style: TabStyle.textIn,
          items: const [
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
                MaterialPageRoute(builder: (context) => const Home()),
              );
            } else if (i == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            }
          },
        ),

    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ایمیل خود را وارد نمایید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),

            SizedBox(
              width: 350,
              child: Column(
                children: [
                  const SizedBox(height: 50,),
                  TextField(
                    controller: emailcontroller,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '******************@gmail.com',
                      labelStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  const SizedBox(height: 30),

                ],
              ),
            ),

            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  if(emailcontroller.text.isNotEmpty){
                    String email = emailcontroller.text;
                    if (!isValidEmail(email)) {
                      errorMessage = '(gmail , yahoo) . ایمیل معتبر نیست';
                    } else {
                      errorMessage = '';
                      a.email = email;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Account()),
                      );
                    }
                  }
                });
              },
              child: const Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}