import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mother_bet/.env.dart';
import 'package:mother_bet/models/user.dart';
import 'package:mother_bet/outExeption.dart';

class AuthDataProvider {
// Add new user sign up
  Future<User> signup(User user) async {
    final http.Response response = await http.post(Uri.parse("$url/signup"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "email": user.email,
          "username": user.username,
          "phone": user.phone,
          "password": user.password,
        }));

    if (response.statusCode == 201) {
      // return User("0","email", "username", "phone", "password", "token");
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }

  // login
  Future<User> login(User user) async {
    final http.Response response = await http.post(Uri.parse("$url/login"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "email": user.email,
          "password": user.password,
        }));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["msg"]);
    }
  }

  // edit
  Future<User> updateProfile(User user, int id) async {
    final http.Response response = await http.put(Uri.parse("$url/auth/$id"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "Email": user.email,
          "Password": user.password,
          "UserName": user.username,
          "Phone": user.phone,
        }));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["message"]);
    }
  }
}
