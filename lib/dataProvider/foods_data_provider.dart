import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:mother_bet/.env.dart';
import 'package:mother_bet/models/food.dart';
import 'package:mother_bet/models/mother.dart';

import 'package:mother_bet/outExeption.dart';
import 'package:mother_bet/shared_preferences.dart';

class FoodsDataProvider {
// Get all Foods
  Future<List<Food>> fetchTopFoods() async {
    final user = await UserSimplePreferences.getUser();

    final response = await http.get(Uri.parse("$url/foods"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user!.token}',
    });
    if (response.statusCode == 200) {
      final foods = jsonDecode(response.body) as List;
      return foods.map((food) => Food.fromJson(food)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["msg"]);
    }
  }

// Get Food by Id
  Future<Food> getFood(String id) async {
    try {
      final user = await UserSimplePreferences.getUser();

      final response = await http.get(Uri.parse("$url/foods/$id"), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${user!.token}',
      });
      if (response.statusCode == 200) {
        return Food.fromJson(jsonDecode(response.body));
      } else {
        final err = jsonDecode(response.body);
        throw AppExc(err["message"]);
      }
    } catch (_) {
      throw AppExc("Not Logged In");
    }
  }

  Future<List<Mother>> fetchMothers() async {
    final user = await UserSimplePreferences.getUser();

    final response = await http.get(Uri.parse("$url/mothers"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user!.token}',
    });
    if (response.statusCode == 200) {
      final mothers = jsonDecode(response.body) as List;
      return mothers.map((mother) => Mother.fromJson(mother)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["msg"]);
    }
  }

  Future<List<Mother>> searchFoods(String name) async {
    final user = await UserSimplePreferences.getUser();

    final response = await http.get(Uri.parse("$url/foods/$name"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user!.token}',
    });
    if (response.statusCode == 200) {
      final mothers = jsonDecode(response.body) as List;
      return mothers.map((mother) => Mother.fromJson(mother)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["msg"]);
    }
  }

// // Add a Reviews
//   Future<Review> addReview(Review review) async {
//     final http.Response response =
//         await http.post(Uri.parse("$url/features/reviews"),
//             headers: <String, String>{"Content-Type": "application/json"},
//             body: jsonEncode({
//               "UserId": review.userId,
//               "TourId": review.tourId,
//               "Comment": review.comment,
//               "Rate": review.rate,
//               "Date": review.date
//             }));
//     if (response.statusCode == 201) {
//       print(response.body);
//       return Review.fromJson(jsonDecode(response.body));
//     } else {
//       print("Error");
//       throw Exception("Failed to add your Review");
//     }
//   }

//   // // Book a Tour
//   Future<User> book(int uId, int tourId) async {
//     final http.Response response =
//         await http.post(Uri.parse("$url/users/$uId/book"),
//             headers: <String, String>{"Content-Type": "application/json"},
//             body: jsonEncode({
//               "TourId": tourId,
//             }));
//     if (response.statusCode == 200) {
//       return User.fromJson(jsonDecode(response.body));
//     } else {
//       final err = jsonDecode(response.body);
//       print(err);
//       throw AppExc(err["message"]);
//     }
//   }
}
