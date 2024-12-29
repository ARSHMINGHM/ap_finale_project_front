import 'package:flutter/material.dart';
import 'EmailEdit.dart';
import 'IdEdit.dart';
import 'NameEdit.dart';
import 'NumberEdit.dart';
import 'PassEdit.dart';
import 'SubscriptionEdit.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFF2EB),
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        backgroundColor: Color(0xFFDFF2EB),
      ),
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
                            alignment: Alignment.centerRight, // متن به سمت راست قرار می‌گیرد
                            child: Text(
                              'ali saemi',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0, // قرار دادن آیکون در سمت راست
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                // هدایت به صفحه جدید
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => changeName()),
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
                            alignment: Alignment.centerRight, // متن به سمت راست قرار می‌گیرد
                            child: Text(
                              '09362526540',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0, // قرار دادن آیکون در سمت راست
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                // هدایت به صفحه جدید
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => changePhone()),
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

                    ///////////////////////////////////////// national id
                    SizedBox(height: 15,),
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
                              '0025379****',
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
                      child :Divider(  // خط افقی
                        color: Color(0xFF787474),  // رنگ خط
                        thickness: 1,  // ضخامت خط
                      ),
                    ),
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
                            alignment: Alignment.centerRight, // متن به سمت راست قرار می‌گیرد
                            child: Text(
                              'alisaemi0005@gmail.com',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0, // قرار دادن آیکون در سمت راست
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                // هدایت به صفحه جدید
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
                    SizedBox(height: 15,),
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
                            alignment: Alignment.centerRight, // متن به سمت راست قرار می‌گیرد
                            child: Text(
                              '**************',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Positioned(
                            left: 0, // قرار دادن آیکون در سمت راست
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                // هدایت به صفحه جدید
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
                    SizedBox(height: 7,),
                    Container(
                      width: 250,
                      child :Divider(  // خط افقی
                        color: Color(0xFF787474),  // رنگ خط
                        thickness: 1,  // ضخامت خط
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
                            alignment: Alignment.centerRight, // متن به سمت راست قرار می‌گیرد
                            child: Text(
                              'معمولی',
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
    );
  }
}