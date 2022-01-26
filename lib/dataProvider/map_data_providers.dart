import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:mother_bet/.env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mother_bet/models/directions.dart';
import 'package:mother_bet/models/mother.dart';
import 'package:mother_bet/outExeption.dart';

class MapDataProvider {
  // Get Directions
  late Dio _dio;
  Future<Directions> getDirections(LatLng origin, LatLng destination) async {
    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'key': googleAPIKey,
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    final err = jsonDecode(response.data);
    throw AppExc(err["message"]);
  }

  Future<List<Mother>> fetchAllMothers() async {
    // final user = await UserSimplePreferences.getUser();

    final response = await http.get(Uri.parse("$url/mothers"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer ${user.token}',
    });
    if (response.statusCode == 200) {
      final mothers = jsonDecode(response.body) as List;
      return mothers.map((mother) => Mother.fromJson(mother)).toList();
    } else {
      final err = jsonDecode(response.body);
      throw AppExc(err["msg"]);
    }
  }
}
