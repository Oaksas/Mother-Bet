class User {
  final String userId;
  final String email;
  final String username;
  final String phone;
  final String password;
  final String token;

  User(this.userId, this.email, this.username, this.phone, this.password,
      this.token);

  factory User.fromJson(Map<String, dynamic> json) {
    // var a  = json['token'] == null ?  : "";
    return User(
        json['_id'] as String,
        json['email'] as String,
        json['username'] as String,
        json['phone'] as String,
        "password",
        json['token'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'email': email,
      'username': username,
      'phone': phone,
      'token': token
    };
  }
}
