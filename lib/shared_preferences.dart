import 'dart:convert';

import 'package:mother_bet/models/user.dart';
import 'package:mother_bet/outExeption.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  // static Future<SharedPreferences> prefs = await SharedPreferences.getInstance();

  // static SharedPreferences preferences;

  static const _keyUser = "user";

  // static Future init() async {
  //   final SharedPreferences preferences = await _prefs;
  // }

  static Future setUser(User user) async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      await preferences.setString(_keyUser, json.encode(user));
    } catch (e) {
      print(e);
      throw AppExc("User Couldn't Be Set");
    }
  }

  static Future<User?> getUser() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      // print(User.fromJson(json.decode(preferences.getString(_keyUser)!)).token +
      //     "hgfxfghg");
      if ((preferences.getKeys()).isNotEmpty) {
        return User.fromJson(json.decode(preferences.getString(_keyUser)!));
      }
      return null;
    } catch (err) {
      throw AppExc("User Doesn't Exist");
    }
  }

  static Future<String> removeUser() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      await preferences.remove(_keyUser);

      return "Success";
    } catch (err) {
      throw AppExc("User Doesn't Exist");
    }
  }
}
