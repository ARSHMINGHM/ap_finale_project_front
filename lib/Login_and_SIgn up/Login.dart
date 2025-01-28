import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Login_and_SIgn up/SignUp.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/clientSocket.dart';
import 'dart:io';
import 'dart:convert';

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
  late Socket socket;
  bool _isConnect = false;


  void validateUser(String username, String password, List<User> users, BuildContext context) {

    for (User user in users) {
      if (user.userName == username && user.password == password) {
        a = user;
        break;
      }
    }

    if (a != null) {

      showNotification(
        "ورود موفقیت‌آمیز بود!",
        Color(0xFF3E7B27),
        Icons.check_circle_outline,
      );


      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    } else {

      showNotification(
        "نام کاربری یا رمزعبور اشتباه است.",
        Color(0xFFE82561),
        Icons.error_outline,
      );
    }
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


  @override
  void initState() {
    super.initState();
    if(!clientSocket.instance.isConnected){
      clientSocket.instance.connect();
    }



    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();

  }
/*  Future<void> connectToServer() async {
    while (true) {
      try {
        socket = await Socket.connect('192.168.82.61', 8080);
        _isConnect = true;
        print("Connected to the server");
        break; // اگر اتصال موفقیت‌آمیز بود، از حلقه خارج شود
      } catch (e) {
        _isConnect = false;
        showNotification("خطا در اتصال به سرور.", Colors.red, Icons.error_outline);
        print("Failed to connect. Retrying in 5 seconds...");
        await Future.delayed(Duration(seconds: 5)); // 5 ثانیه صبر قبل از تلاش مجدد
      }
    }
  }


  Future<void> getCommand(String username, String password) async {
    connectToServer();
    if (!_isConnect) {
      showNotification("در حال حاضر اتصال به سرور برقرار نیست.", Colors.red, Icons.error_outline);
      return;
    }

    String loginRequest = "login $username $password\n";
    socket?.write(loginRequest);

    // گوش دادن به پاسخ سرور
    socket?.listen((List<int> event) {
      String response = utf8.decode(event).trim();
      print("Server Response: $response");

      if (response == "Login successful") {
        showNotification("ورود موفقیت‌آمیز بود!", Colors.green, Icons.check_circle_outline);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        showNotification("نام کاربری یا رمز عبور اشتباه است.", Colors.red, Icons.error_outline);
      }
    }, onError: (error) {
      showNotification("خطا در ارتباط با سرور.", Colors.red, Icons.error_outline);
      closeConnection();
    }, onDone: () {
      closeConnection();
    });
  }

  void closeConnection() {
    if (socket != null) {
      socket?.close();
      print("Connection closed");
    }
  }*/

  @override
  void dispose() {
    _animationController.dispose();
    //closeConnection();
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
                    onPressed: () async {
                      String username = usernameController.text;
                      String password = passController.text;

                      if (username.isEmpty && password.isEmpty) {
                        errorMessage = "نام کاربری و رمزعبور خود را وارد کنید";
                        showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
                      } else if (username.isEmpty) {
                        errorMessage = "نام کاربری خود را وارد کنید";
                        showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
                      } else if (password.isEmpty) {
                        errorMessage = "رمزعبور خود را وارد کنید";
                        showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
                      } else {
                        // انجام عملیات غیرهمزمان قبل از setState
                        int state = await clientSocket.instance.sendLoginCommand(username, password);
                        print("state : ${state}");

                        setState(() {
                          if (state == 200) {
                            showNotification("ورود موفقیت‌آمیز بود", Color(0xFF25E884), Icons.check_circle_outline);
                            Future.delayed(const Duration(milliseconds: 500), () {
                              Navigator.pushReplacementNamed(context, '/home');
                            });
                          } else if (state == 500) {
                            showNotification("connection loss", Color(0xFFE82561), Icons.error_outline);
                          } else if (state == 401) {
                            showNotification("نام کاربری یا رمز عبور اشتباه است.", Color(0xFFE82561), Icons.error_outline);
                          }
                        });
                      }
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
