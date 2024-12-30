class User {
  String?userName;
  String? fname;
  String? lname;
  String? email;
  String? phoneNumber;
  String? password;
  String? sub = "معمولی";

  User({this.userName,this.fname,this.lname, this.email, this.phoneNumber,this.password});
}

List<User> users = [];