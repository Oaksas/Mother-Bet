import 'package:mother_bet/models/cordinate.dart';
import 'package:mother_bet/models/food.dart';

class Mother {
  final String motherId;
  final Cord location;
  final String name;
  final String phone;
  final String motto;
  final List<dynamic>  foods;

  Mother(this.motherId, this.location, this.name, this.phone, this.motto,
      this.foods);

  factory Mother.fromJson(Map<String, dynamic> json) {
    return Mother(
      json['_id'] as String,
      Cord.fromJson(json["location"]),
      json['name'] as String,
      json['phone'] as String,
      json['motto'] as String,
      json['foods'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': motherId,
      'location': location,
      'name': name,
      'phone': phone,
      'motto': motto,
      'foods': foods
    };
  }
}

// class Cord {
//   final String type;
//   final coordinate;

//   Cord(this.coordinate, this.type);

//   factory Cord.fromJson(Map<String, dynamic> json) {
//     return Cord(json['type'], json["coordinates"]);
//   }

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "coordinates": coordinate,
//       };
// }
