import 'package:foodea/data/model/drink.dart';
import 'package:foodea/data/model/food.dart';

class Menu {
  final List<Food> foods;
  final List<Drink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      foods: json["foods"] != null
          ? List<Food>.from(json["foods"]!.map((x) => Food.fromJson(x)))
          : <Food>[],
      drinks: json["drinks"] != null
          ? List<Drink>.from(json["drinks"]!.map((x) => Drink.fromJson(x)))
          : <Drink>[],
    );
  }
}
