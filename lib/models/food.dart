class Food {
  final String foodId;
  final Mothers mother;
  final String name;
  final int price;
  final String image;
  final List<dynamic> ingredient;

  Food(this.foodId, this.mother, this.name, this.price, this.image,
      this.ingredient);

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      json['_id'] as String,
      Mothers.fromJson(json["mother"]),
      json['name'] as String,
      json['price'] as int,
      json['image'] as String,
      json['ingredient'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': foodId,
      'mother': mother,
      'name': name,
      'price': price,
      'image': image,
      'ingredient': ingredient,
    };
  }
}

class Mothers {
  final String name;
  final String motherId;
  Mothers(
    this.motherId,
    this.name,
  );
  factory Mothers.fromJson(Map<String, dynamic> json) =>
      Mothers(json["_id"], json["name"]);

  Map<String, dynamic> toJson() => {
        "_id": motherId,
        "name": name,
      };
}

List<Food> demoFoods = [
  Food("wbjqw2-21s22d", Mothers("26881", "Mina"), 'Mina', 30,
      'assets/images/shiro1.jpg', ['mosh', "loga"]),
  Food("wbjqw2-21s22d", Mothers("26881", "Mina"), 'Maed', 30,
      'assets/images/egg2.jpg', ['mosh', "loga"]),
  Food("wbjqw2-21s22d", Mothers("26881", "Mina"), 'Minab', 30,
      'assets/images/meat1.jpg', ['mosh', "loga"]),
  Food("wbjqw2-21s22d", Mothers("26881", "Mina"), 'Saron', 30,
      'assets/images/beyaynet2.jpg', ['mosh', "loga"]),
  Food("wbjqw2-21s22d", Mothers("26881", "Mina"), 'Nahom', 30,
      'assets/images/pasta1.jpg', ['mosh', "loga"]),
];
