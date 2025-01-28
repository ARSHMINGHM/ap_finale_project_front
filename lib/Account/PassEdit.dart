import 'package:untitled/Account/EditInfo.dart';
import 'package:flutter/material.dart';
import 'package:untitled/clientSocket.dart';
import 'package:untitled/main.dart';
import 'package:untitled/Home/Home.dart';
import 'package:untitled/Account/AccountMainPage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:untitled/Account/AccountMainPage.dart';

class changePassword extends StatefulWidget {
  const changePassword({super.key});

  @override
  ChangePassword createState() => ChangePassword();
}

class ChangePassword extends State<changePassword> {
  TextEditingController PreviousPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController repeatNewPassword = TextEditingController();
  String errorMessage = '';

  bool isValidPassword(String PreviousPassword, String newPassword, String repeatNewPassword) {
    if (clientSocket.instance.password != PreviousPassword) {
      showNotification("رمز فعلی اشتباه وارد شده", Color(0xFFE82561), Icons.error_outline);
      return false;
    } else if (newPassword != repeatNewPassword) {

      showNotification("رمز تکرار شده اشتباه است", Color(0xFFE82561), Icons.error_outline);
      return false;
    }else if(PreviousPassword == newPassword){
      showNotification("رمز یکبار استفاده شده است", Color(0xFFE82561), Icons.error_outline);
      return false;

    }
    return true;
  }
  bool isValidPass(String password, String username) {

    if (password.length < 5) {
      showNotification("رمز عبور باید شامل حداقل 6 کاراکتر باشد", Color(0xFFE82561), Icons.error_outline);

      return false;
    }
    RegExp uppercase = RegExp(r'[A-Z]');
    RegExp lowercase = RegExp(r'[a-z]');
    RegExp digit = RegExp(r'[0-9]');

    if (!uppercase.hasMatch(password) ||
        !lowercase.hasMatch(password) ||
        !digit.hasMatch(password)) {
      showNotification("رمز عبور باید شامل حروف بزرگ و کوچک و اعداد باشد", Color(0xFFE82561), Icons.error_outline);
      return false;
    }
    if (password.contains(username)) {
      showNotification("رمز عبور نباید شامل نام کاربری باشد", Color(0xFFE82561), Icons.error_outline);
      return false;
    }
    return true;
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
          top: -12.0,
          activeColor: const Color(0XFF000000),
          backgroundColor: const Color(0XFFDFF2EB),
          style: TabStyle.textIn,
          initialActiveIndex: 2,
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
                'تغییر رمز عبور',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              width: 350,
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  TextField(
                    controller: PreviousPassword,
                    textAlign: TextAlign.right,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'رمز عبور فعلی',
                      labelStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextField(
                    controller: newPassword,
                    textAlign: TextAlign.right,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'رمز عبور جدید',
                      labelStyle: const TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFD9D9D9),
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextField(
                    controller: repeatNewPassword,
                    textAlign: TextAlign.right,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'تکرار رمز عبور',
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
              onPressed: () async{
                String prePass = PreviousPassword.text;
                String newPass = newPassword.text;
                String repNewPass = repeatNewPassword.text;
                bool valid = isValidPassword(prePass, newPass, repNewPass);
                if (valid) {
                  if(isValidPass(newPass, clientSocket.instance.userName??'')){
                    try{
                      int state = await clientSocket.instance.sendEditPasswordCommand(clientSocket.instance.userName ?? '', newPass);
                      setState(() {
                        if (state == 200) {
                          showNotification("تغییرات رمز عبور اعمال شد", Color(0xFF25E884), Icons.check_circle_outline);
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.pushReplacementNamed(context, '/profile');
                          });
                        }
                        else if (state == 404) {
                          showNotification("رمز عبور نامعتبر است", Color(0xFFE82561), Icons.error_outline);
                        }else if(state == 400) {
                          showNotification("رمزعبور یکبار استفاده شده است", Color(0xFFE82561), Icons.error_outline);

                        }
                        else if(state == 501) {
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