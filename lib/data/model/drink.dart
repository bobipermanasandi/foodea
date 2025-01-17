class Drink {
  final String name;

  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json["name"],
    );
  }
}
