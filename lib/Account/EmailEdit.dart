import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:flutter/material.dart';
import 'package:ap_finale_project_front/clientSocket.dart';
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
                MaterialPageRoute(builder: (context) =>  Home()),
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
                    decoration: InputDecoration(hintTextDirection:TextDirection.ltr,
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
              onPressed: () async {
                if(emailcontroller.text.isNotEmpty){
                  String email = emailcontroller.text;
                  if (!isValidEmail(email)) {
                    errorMessage = '(gmail , yahoo) . ایمیل معتبر نیست';
                  } else {
                    try{
                      int state = await clientSocket.instance.sendEditEmailCommand(clientSocket.instance.userName ?? '', email);
                      setState(() {
                        if (state == 200) {
                          showNotification("تغییرات ایمیل اعمال شد", Color(0xFF25E884), Icons.check_circle_outline);
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.pushReplacementNamed(context, '/profile');
                          });
                        }
                        else if (state == 404) {
                          showNotification("کاربر با این اطلاعات وجود دارد", Color(0xFFE82561), Icons.error_outline);
                        }else if(state == 400) {
                          showNotification("خطای ناشناخته، لطفاً دوباره امتحان کنید.", Color(0xFFE82561), Icons.error_outline);

                        }
                        else if(state == 500){
                          showNotification("connection loss.", Color(0xFFE82561), Icons.error_outline);

                        }


                      });
                    }catch(e){
                      print(e);
                    }

                  }
                }

                /*setState(() {
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
                });*/
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
  void showNotification(String message, Color backgroundColor, IconData icon) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay?.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}