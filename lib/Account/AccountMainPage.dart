import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:ap_finale_project_front/Account/EditInfo.dart';
import 'package:ap_finale_project_front/Home/Home.dart';
import 'package:ap_finale_project_front/main.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF2EB), // رنگ پس‌زمینه
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF2EB), // هم‌رنگ با پس‌زمینه
        elevation: 0, // حذف سایه
        leading: const Icon(Icons.arrow_back, color: Colors.black), // آیکون لوگو
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black), // آیکون تنظیمات
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[400],
              backgroundImage: const AssetImage('assets/images (8).jpg'),
            ),
            const SizedBox(height: 10),
            // نام و شماره تلفن کاربر
            Text(
              '${a.fname} ${a.lname}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              '${a.phoneNumber}',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: ClipOval(
                    child: SizedBox(
                      width: 30,  // عرض دایره
                      height: 30, // ارتفاع دایره
                      child: Image.asset(
                        'assets/images (18).png',
                        fit: BoxFit.cover,  // تصویر به صورت تمام صفحه در دایره نمایش داده می‌شود
                      ),
                    ),
                  ),
                  label: const Text('فعال سازی کیف پول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[200],
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Account()),
                    );
                  },
                  icon: ClipOval(
                    child: SizedBox(
                      width: 30,  // عرض دایره
                      height: 30, // ارتفاع دایره
                      child: Image.asset(
                        'assets/images (9).jpg',
                        fit: BoxFit.cover,  // تصویر به صورت تمام صفحه در دایره نمایش داده می‌شود
                      ),
                    ),
                  ),
                  label: const Text('ویرایش اطلاعات کاربری', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // فرم اطلاعات کاربری
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('اطلاعات کاربری', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Divider(color: Colors.grey),
                  buildInfoRow('نام و نام خانوادگی', '${a.fname} ${a.lname}'),
                  buildInfoRow('تلفن همراه', '${a.phoneNumber}'),
                  buildInfoRow('کد ملی', '${a.nationalID}'),
                  buildInfoRow('ایمیل', '${a.email}'),
                  buildInfoRow('رمز عبور', '*' * (a.password?.length ?? 0)),
                  buildInfoRow('اشتراک', '${a.sub}'),
                ],

              ),



            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.redAccent),  // آیکون لیست علاقه مندی ها
                      SizedBox(width: 5),  // فاصله بین آیکون و متن
                      Text(
                        'لیست علاقه مندی ها',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC30E59)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20, // ارتفاع خط
                  width: 1, // عرض خط

                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Account()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart_outlined, color: Colors.blue[700]),  // آیکون سبد خرید
                      const SizedBox(width: 5),  // فاصله بین آیکون و متن
                      Text(
                        'سبد خرید',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700]),
                      ),
                    ],
                  ),
                ),
              ],
            ),


            const SizedBox(height: 20),

            // اضافه کردن لیست علاقه‌مندی‌ها


          ],
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
          TabItem(icon: Icons.category_outlined, title: 'Category',),
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
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
