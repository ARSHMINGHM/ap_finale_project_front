import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Login_and_SIgn up/SignUp.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Account/users.dart';

class login extends StatefulWidget {
  @override
  Login createState() => Login();
}

class Login extends State<login> with SingleTickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String errorMessage="";

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


  @override
  void initState() {
    super.initState();

    // تنظیمات انیمیشن
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut, // منحنی انیمیشن
    ));

    // شروع انیمیشن
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFF2EB),
      appBar: AppBar(
        backgroundColor: Color(0xFFDFF2EB),
        elevation: 0,
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey.withOpacity(0.5),
                backgroundImage: AssetImage('assets/images (8).jpg'),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/login.jpg',
                height: 40,
                width: 120,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 350,
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        TextField(
                          controller: usernameController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'نام کاربری',
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                          ),
                        ),
                        SizedBox(height: 40),
                        TextField(
                          controller: passController,
                          obscureText: true,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'رمز عبور',

                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                          ),

                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Account()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 100),
                      child: Text(
                        'رمز عبور خود را فراموش کرده اید؟',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        String usename = usernameController.text;
                        String password = passController.text;
                        if (usename.isEmpty && password.isEmpty) {
                          errorMessage = "نام کاربری و رمزعبور خود را وارد کنید";
                          showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
                        } else if (usename.isEmpty) {
                          errorMessage = "نام کاربری  خود را وارد کنید";
                          showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
                        } else if (password.isEmpty) {
                          errorMessage = "رمزعبور خود را وارد کنید";
                          showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
                        } else if (usename != a.userName || password != a.password) {
                          errorMessage = "نام کاربری یا رمزعبور اشتباه است.";
                          showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
                        } else {
                          errorMessage = "";
                          showNotification("ورود موفقیت‌آمیز بود!",Color(0xFF3E7B27), Icons.check_circle_outline);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => home()),
                          );
                        }
                      });
                    },
                    label: Text('LOGIN', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[200],
                      padding: EdgeInsets.symmetric(vertical: 10),
                      minimumSize: Size(250, 50),
                    ),
                  ),


                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => signUp()),
                      );
                    },
                    label: Text('SIGN UP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
                      padding: EdgeInsets.symmetric(vertical: 10),
                      minimumSize: Size(250, 50),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(15),
              ),
            ],
          ),
        ),
      ),


    );
  }
}
