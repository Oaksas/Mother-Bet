class Cord {
  final String type;

  final List<dynamic> coordinates;

  Cord(this.type, this.coordinates);

  factory Cord.fromJson(Map<String, dynamic> json) {
    return Cord(
      json['type'] as String,
      json['coordinates'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
