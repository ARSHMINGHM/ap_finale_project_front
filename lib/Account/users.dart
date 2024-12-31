import 'package:ap_finale_project_front/Product.dart';
class User {
  String?userName;
  String? fname;
  String? lname;
  String? email;
  String? phoneNumber;
  String? password;
  String? sub = "معمولی";
  List<Product> p = [];



  User({this.userName,this.fname,this.lname, this.email, this.phoneNumber,this.password});
}

List<User> users = [
  User(userName: "al", fname: "Ali", lname: "Ahmadi", email: "ali@gmail.com", phoneNumber: "09123456789", password: "12345"),
  User(userName: "sa",fname: "Sara", lname: "Hosseini", email: "sara@yahoo.com", phoneNumber: "09187654321", password: "112345"),
  User(userName: "alisa",fname: "علی",lname:"صائمی",email: "alisaemi0005@gmail.com",phoneNumber: "0932565255",password: "1234")
];


