import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/Login_and_SIgn up/Login.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Account/users.dart';
import 'package:ap_finale_project_front/clientSocket.dart';


class signUp extends StatefulWidget {
  @override
  SignUp  createState() => SignUp ();
}

class SignUp extends State<signUp> with SingleTickerProviderStateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repeatedPassController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  String errorMessage="";
  bool isValidEmail(String email) {

    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$',
    );
    return emailRegExp.hasMatch(email);
  }

  bool isValidPassword(String password, String username) {

    if (password.length < 8) {
      return false;
    }
    RegExp uppercase = RegExp(r'[A-Z]');
    RegExp lowercase = RegExp(r'[a-z]');
    RegExp digit = RegExp(r'[0-9]');

    if (!uppercase.hasMatch(password) ||
        !lowercase.hasMatch(password) ||
        !digit.hasMatch(password)) {
      return false;
    }
    if (password.contains(username)) {
      return false;
    }
    return true;
  }

  void addUser(User u) {
    users.add(u);
  }

  bool checkSignUp(String username,String fname , String lname, String email,String pass,String repass){
    if (email.isEmpty || pass.isEmpty || fname.isEmpty|| lname.isEmpty || repass.isEmpty) {
      errorMessage = "اطلاعات زیر را به صورت کامل پر کنید.";
      showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
      return false;
    } else if (!isValidEmail(email)) {
      errorMessage = ".ایمیل معتبر نیست";
      showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
      return false;
    } else if (pass.isEmpty) {
      errorMessage = ".رمزعبور خود را وارد کنید";
      showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
      return false;
    }else if(isValidPassword(pass, username)){
      errorMessage = ".رمزعبور معتبر نیست.";
      showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
      return false;

    }
    else if (pass != repass) {
      errorMessage = "تکرار رمز عبور نادرست است.";
      showNotification(errorMessage, Color(0xFFE82561), Icons.error_outline);
      return false;
    } else {
      errorMessage = "";
      User newUser = new User(userName: username,
          fname: fname,
          lname: lname,
          email: email,
          phoneNumber: "",
          password: pass,);
      addUser(newUser);
      a = newUser;
      return true;
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
    //clientSocket.instance.connect();
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
                'assets/sign up.jpg',
                height: 40,
                width: 150,
                alignment: Alignment.center,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 350,
                    child: Column(
                      children: [
                        TextField(
                          controller: userNameController,
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
                        SizedBox(height: 20),
                        TextField(
                          controller: fnameController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'نام',
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: lnameController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'نام خانوادگی',
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                          ),

                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: emailController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: 'ایمیل',
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Color(0xFFD9D9D9),
                          ),

                        ),
                        SizedBox(height: 20),
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
                        SizedBox(height: 20),
                        TextField(
                          controller: repeatedPassController,
                          obscureText: true,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            hintText: ' تکرار رمز عبود',
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




                  SizedBox(height: 70),
                  ElevatedButton.icon(
                    onPressed: () async {
                      String userName = fnameController.text;
                      String firstName = fnameController.text;
                      String lastName = lnameController.text;
                      String Email = emailController.text;
                      String Password = passController.text;
                      String repass = repeatedPassController.text;

                      bool valid = checkSignUp(userName, firstName, lastName, Email, Password, repass);

                      if (valid) {
                        try {
                          int state = await clientSocket.instance.sendSignUpCommand(userName, firstName, lastName, Email, Password);

                          setState(() {
                            if (state == 200) {
                              showNotification("ثبت نام با موفقیت انجام شد", Color(0xFF25E884), Icons.check_circle_outline);
                              Future.delayed(const Duration(milliseconds: 300), () {
                                Navigator.pushReplacementNamed(context, '/home');
                              });
                            } else if (state == 500) {
                              showNotification("connection loss", Color(0xFFE82561), Icons.error_outline);
                            } else if (state == 401) {
                              showNotification("نام کاربری یا رمز عبور اشتباه است.", Color(0xFFE82561), Icons.error_outline);
                            } else if (state == 404) {
                              showNotification("نام کاربری تکراری است", Color(0xFFE82561), Icons.error_outline);
                            } else if (state == 406) {
                              showNotification("ایمیل تکراری است.", Color(0xFFE82561), Icons.error_outline);
                            } else if (state == 400) {
                              showNotification("کاربر با این اطلاعات وجود دارد", Color(0xFFE82561), Icons.error_outline);
                            } else {
                              showNotification("خطای ناشناخته، لطفاً دوباره امتحان کنید.", Color(0xFFE82561), Icons.error_outline);
                            }
                          });
                        } catch (e) {
                          print("Error: $e");
                          showNotification("خطا در اتصال به سرور", Color(0xFFE82561), Icons.error_outline);
                        }
                      }
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
