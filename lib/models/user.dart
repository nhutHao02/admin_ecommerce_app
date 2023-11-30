class User {
  String? userId, email, password, name, pic;

  User({this.userId, this.email, this.password, this.name, this.pic = 'assets/images/profile.jpg'});

  User.fromjson(Map<String, String> jsonMap) {
    userId = jsonMap['userId'];
    email = jsonMap['email'];
    password = jsonMap['password'];
    name = jsonMap['name'];
    pic = jsonMap['pic'];
  }

  Map<String, String> toJson() {
    return {
      'userId': userId ?? '',
      'email': email ?? '',
      'password': password ?? '',
      'name': name ?? '',
      'pic': pic ?? '',
    };
  }
}
