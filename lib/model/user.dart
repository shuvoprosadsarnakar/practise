class User {
  String name;
  String phone;
  String email;

  User.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}
