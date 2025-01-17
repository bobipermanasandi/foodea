import 'package:foodea/data/model/category.dart';
import 'package:foodea/data/model/customer_review.dart';
import 'package:foodea/data/model/menu.dart';

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menu menu;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menu,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    return RestaurantDetail(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      city: json["city"],
      address: json["address"],
      pictureId: json["pictureId"],
      categories: json["categories"] != null
          ? List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x)))
          : <Category>[],
      menu: Menu.fromJson(json['menus']),
      rating: json["rating"].toDouble(),
      customerReviews: json["customerReviews"] != null
          ? List<CustomerReview>.from(
              json["customerReviews"]!.map((x) => CustomerReview.fromJson(x)))
          : <CustomerReview>[],
    );
  }
}
