import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Account(),
    );
  }
}

class changeName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),

      backgroundColor: Color(0xFFDFF2EB),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'نام و نام خانوادگی خود را وارد نمایید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),

            Container(
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextField(textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'نام',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'نام خانوادگی',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                ],


              ),
            ),


            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // انتقال به صفحه HomePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changeName()),
                );
              },
              child: Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////phone
class changePhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),

      backgroundColor: Color(0xFFDFF2EB),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'شماره تلفن خود را وارد نمایید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),

            Container(
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextField(textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '09*********',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),

                ],
              ),
            ),

            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changeName()),
                );
              },
              child: Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////edit email
class changeEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),

      backgroundColor: Color(0xFFDFF2EB),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'ایمیل خود را وارد نمایید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),

            Container(
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextField(textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'a*****************@gmail.com',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),

                ],
              ),
            ),

            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changeName()),
                );
              },
              child: Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
/////////////////////////////////////////////edit national id
class changeID extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),

      backgroundColor: Color(0xFFDFF2EB),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'کد ملی خود را وارد نمایید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),

            Container(
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextField(textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: '**********',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),

                ],
              ),
            ),

            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changeName()),
                );
              },
              child: Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


/////////////////////////////////////password
class changePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),

      backgroundColor: Color(0xFFDFF2EB),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'تغییر رمز عبور',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),

            Container(
              width: 350,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextField(textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'رمز عبور فعلی',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'رمز عبور جدید',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'تکرار رمز عبور',
                      labelStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Color(0xFFD9D9D9),
                    ),
                  ),
                ],


              ),
            ),


            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => changeName()),
                );
              },
              child: Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


//    اشتراک/////////////////////////////////////



class changeSubscription extends StatefulWidget {
  @override
  _ChangeSubscriptionState createState() => _ChangeSubscriptionState();
}

class _ChangeSubscriptionState extends State<changeSubscription> {
  int? selectedOption; // ذخیره انتخاب تنها یک گزینه

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ویرایش اطلاعات'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFFDFF2EB),
      ),
      backgroundColor: Color(0xFFDFF2EB),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'نوع اشتراک خود را معلوم کنید',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 120),
            Container(
              width: 350,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFCDC1FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  _buildCheckboxOption('اشتراک پایه', 1),
                  SizedBox(height: 15,),
                  _buildCheckboxOption('اشتراک استاندارد', 2),
                  SizedBox(height: 15,),
                  _buildCheckboxOption('اشتراک پریمیوم', 3),
                ],
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeName()),
                );
              },
              child: Text(
                'تایید اطلاعات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxOption(String text, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Checkbox(
          value: selectedOption == value,
          onChanged: (bool? isSelected) {
            setState(() {
              selectedOption = isSelected! ? value : null;
            });
          },
          activeColor: Colors.blue,
          checkColor: Colors.white,
          shape: CircleBorder(),
          side: BorderSide(color: Color(0xFF787474), width: 2),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}

class ChangeName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تغییر نام'),
      ),
      body: Center(
        child: Text('صفحه تغییر نام'),
      ),
    );
  }
}


////////////////////////////////////////////edit account
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



