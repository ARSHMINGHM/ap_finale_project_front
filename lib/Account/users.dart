import 'package:ap_finale_project_front/Cart/Cart.dart';
import 'package:ap_finale_project_front/Product.dart';
class User {
  String?userName;
  String? fname;
  String? lname;
  String? email;
  String? phoneNumber;
  String? password;
  String? sub = "معمولی";
  List<Product> FavoriteProducts = [];
  List<Product> shoppingCart = [];
  List<String> addresses = [""];


  User({this.userName,this.fname,this.lname, this.email, this.phoneNumber,this.password,required this.addresses,required this.shoppingCart});
}

List<User> users = [
  User(userName: "al", fname: "Ali", lname: "Ahmadi", email: "ali@gmail.com", phoneNumber: "09123456789", password: "12345",addresses: ["tehran ....."],shoppingCart: []),
  User(userName: "sa",fname: "Sara", lname: "Hosseini", email: "sara@yahoo.com", phoneNumber: "09187654321", password: "112345",addresses: [],shoppingCart: []),
  User(userName: "alisa",fname: "علی",lname:"صائمی",email: "alisaemi0005@gmail.com",phoneNumber: "0932565255",password: "1234", addresses: ["paris","rome"],shoppingCart: [])
];


