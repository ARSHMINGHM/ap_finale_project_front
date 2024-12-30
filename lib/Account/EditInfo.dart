import 'package:flutter/material.dart';
import 'EmailEdit.dart';
import 'NameEdit.dart';
import 'NumberEdit.dart';
import 'PassEdit.dart';
import 'SubscriptionEdit.dart';
<<<<<<< HEAD
import 'users.dart';


=======
import 'package:ap_finale_project_front/Account/AccountMainPage.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/main.dart';
>>>>>>> 24cb7951985f79ec36f114f2f4da2187a91b7243


class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF2EB),
      appBar: AppBar(
        title: const Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile()),
            );
          },
        ),
        backgroundColor: const Color(0xFFDFF2EB),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 700,
          alignment: Alignment.center, // Center the inner child
          decoration: BoxDecoration(
            color: const Color(0xFFD9D9D9), // Move color here
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'ویرایش اطلاعات',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
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
                    const SizedBox(height: 15,),
                    const SizedBox(
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

                    const SizedBox(height: 13),
                    SizedBox(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight, // متن به سمت راست قرار می‌گیرد
                            child: Text(
                              "${a.fname} ${a.lname}",
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
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
                                  MaterialPageRoute(builder: (context) => const ChangeName()),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_back, // آیکون فلش
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7,),
                    const SizedBox(
                      width: 250,
                      child :Divider(  // خط افقی
                        color: Color(0xFF787474),  // رنگ خط
                        thickness: 1,  // ضخامت خط
                      ),
                    ),
                    ////////////////////////////////////////phone
                    const SizedBox(height: 15,),
                    const SizedBox(
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


                    const SizedBox(height: 13),
                    SizedBox(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${a.phoneNumber}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
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
                                  MaterialPageRoute(builder: (context) => const changePhone()),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_back, // آیکون فلش
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),



                    const SizedBox(height: 7,),
                    const SizedBox(
                      width: 250,
                      child :Divider(
                        color: Color(0xFF787474),
                        thickness: 1,
                      ),
                    ),

                    ///////////////////////////////////////// national id
                    const SizedBox(height: 15,),
                    const SizedBox(
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

                    const SizedBox(height: 13),
                    SizedBox(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${a.nationalID}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                              textAlign: TextAlign.right,
                            ),
                          ),

                        ],
                      ),
                    ),
                    const SizedBox(height: 7,),
                    const SizedBox(
                      width: 250,
                      child :Divider(
                        color: Color(0xFF787474),
                        thickness: 1,
                      ),
                    ),
                    //////////////////////////////////email
                    const SizedBox(height: 15,),
                    const SizedBox(
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

                    const SizedBox(height: 13),
                    SizedBox(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${a.email}',
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
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
                                  MaterialPageRoute(builder: (context) => const changeEmail()),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_back, // آیکون فلش
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7,),
                    const SizedBox(
                      width: 250,
                      child :Divider(  // خط افقی
                        color: Color(0xFF787474),  // رنگ خط
                        thickness: 1,  // ضخامت خط
                      ),
                    ),
                    /////////////////////////////////////////////////pass
                    const SizedBox(height: 13,),
                    const SizedBox(
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

                    const SizedBox(height: 0),
                    SizedBox(
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
                                      MaterialPageRoute(builder: (context) => const changePassword()),
                                    );
                                  },

                                  child: const Icon(
                                    Icons.arrow_back, // آیکون فلش
                                    color: Colors.black,
                                    size: 16,

                                  ),
                                ),
                                // فیلد پسورد
                                const SizedBox(height: 10,),
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    obscureText: true,
                                    controller: TextEditingController(text: a.password),
                                    textAlign: TextAlign.right,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none, // حذف حاشیه
                                      hintText: '**************',
                                      contentPadding: EdgeInsets.only(top: 10),
                                    ),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    //SizedBox(height: 7,),
                    const SizedBox(
                      width: 250,
                      child :Divider(  // خط افقی
                        color: Color(0xFF787474),  // رنگ خط
                        thickness: 1,
                        height: 10,// ضخامت خط
                      ),
                    ),
                    //////////////////////////////////////////
                    const SizedBox(height: 15,),
                    const SizedBox(
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

                    const SizedBox(height: 13),
                    SizedBox(
                      width: 250,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${a.sub}',

                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
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
                                  MaterialPageRoute(builder: (context) => const changeSubscription()),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7,),
                    const SizedBox(
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
          color: const Color(0XFF757C84),
          top: -12.0,
          activeColor: const Color(0XFF000000),
          backgroundColor: const Color(0XFFDFF2EB),
          initialActiveIndex: 2,
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
                MaterialPageRoute(builder: (context) => const Account()),
              );
            }
          },
        )
    );
  }
}

