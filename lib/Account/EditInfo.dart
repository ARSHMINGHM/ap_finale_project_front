import 'package:flutter/material.dart';
import 'EmailEdit.dart';
import 'NameEdit.dart';
import 'NumberEdit.dart';
import 'PassEdit.dart';
import 'SubscriptionEdit.dart';
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/main.dart';
import 'package:ap_finale_project_front/Category/Category.dart';
import 'package:ap_finale_project_front/clientSocket.dart';


class Account extends StatelessWidget {
  const Account({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFF2EB),
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 700,
          alignment: Alignment.center, // Center the inner child
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9), // Move color here
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'ویرایش اطلاعات',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child : Column(
                  children: [
                    /////////////////////////////////////////name
                    SizedBox(height: 15,),
                    Container(
                      width: 250,
                      child : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'نام و نام خانوادگی',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Color(0xFF787474)),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    SizedBox(height: 13),
                    Container(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "${clientSocket.instance.fname} ${clientSocket.instance.lname}",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ChangeName()),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7,),
                    Container(
                      width: 250,
                      child :Divider(
                        color: Color(0xFF787474),
                        thickness: 1,
                      ),
                    ),
                    ////////////////////////////////////////phone
                    SizedBox(height: 15,),
                    Container(
                      width: 250,
                      child : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تلفن همراه',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Color(0xFF787474)),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),


                    SizedBox(height: 13),
                    Container(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              (clientSocket.instance.phoneNumber?.isEmpty ?? true) ? '09**********' : clientSocket.instance.phoneNumber!,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => changePhone()),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),



                    SizedBox(height: 7,),
                    Container(
                      width: 250,
                      child :Divider(
                        color: Color(0xFF787474),
                        thickness: 1,
                      ),
                    ),

                    ///////////////////////////////////////// national id
              /*      SizedBox(height: 15,),
                    Container(
                      width: 250,
                      child : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'کد ملی',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Color(0xFF787474)),
                          textAlign: TextAlign.right,
                        ),
                      ),

                    ),

                    SizedBox(height: 13),
                    Container(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${a.nationalID ?? 'کد ملی وارد نشده'}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,

                            child: GestureDetector(
                              onTap: () {

                                // هدایت به صفحه جدید
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => changeID()),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back, // آیکون فلش
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 7,),
                    Container(
                      width: 250,
                      child :Divider(
                        color: Color(0xFF787474),
                        thickness: 1,
                      ),
                    ),*/
                    //////////////////////////////////email
                    SizedBox(height: 15,),
                    Container(
                      width: 250,
                      child : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'ایمیل',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Color(0xFF787474)),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    SizedBox(height: 13),
                    Container(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${clientSocket.instance.email}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => changeEmail()),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back, // آیکون فلش
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7,),
                    Container(
                      width: 250,
                      child :Divider(  // خط افقی
                        color: Color(0xFF787474),  // رنگ خط
                        thickness: 1,  // ضخامت خط
                      ),
                    ),
                    /////////////////////////////////////////////////pass
                    SizedBox(height: 13,),
                    Container(
                      width: 250,
                      child : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'رمز عبور',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Color(0xFF787474)),
                          textAlign: TextAlign.right,
                        ),
                      ),

                    ),
                    SizedBox(height: 13),
                    Container(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              clientSocket.instance.password != null
                                  ? '*' * clientSocket.instance.password!.length
                                  : '',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => changePassword()),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back, // آیکون فلش
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /*SizedBox(height: 0),
                    Container(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                GestureDetector(
                                  onTap: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => changePassword()),
                                    );
                                  },

                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: 16,

                                  ),
                                ),
                                // فیلد پسورد
                                SizedBox(height: 10,),
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    obscureText: true,
                                    controller: TextEditingController(text: clientSocket.instance.password),
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // حذف حاشیه
                                      hintText: '**************',
                                      contentPadding: EdgeInsets.only(top: 10),
                                    ),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
*/

                    //SizedBox(height: 7,),
                    Container(
                      width: 250,
                      child :Divider(  // خط افقی
                        color: Color(0xFF787474),  // رنگ خط
                        thickness: 1,
                        height: 10,// ضخامت خط
                      ),
                    ),
                    //////////////////////////////////////////
                    SizedBox(height: 15,),
                    Container(
                      width: 250,
                      child : Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'اشتراک',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ,color: Color(0xFF787474)),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    SizedBox(height: 13),
                    Container(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${clientSocket.instance.sub}',

                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => changeSubscription()),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7,),
                    Container(
                      width: 250,
                      child :Divider(
                        color: Color(0xFF787474),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: ConvexAppBar(
          color: Color(0XFF757C84),
          initialActiveIndex: 2,
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
              Navigator.push(
             context,
            MaterialPageRoute(builder: (context) => Category()),
            );
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
        )
    );
  }
}
