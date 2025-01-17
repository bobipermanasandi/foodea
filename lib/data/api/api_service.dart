import 'dart:convert';

import 'package:foodea/data/model/response/restaurant_detail_response.dart';
import 'package:foodea/data/model/response/restaurant_list_response.dart';
import 'package:foodea/data/model/response/restaurant_review_response.dart';
import 'package:foodea/data/model/response/restaurant_search_response.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";
  static const String baseUrlImage =
      "https://restaurant-api.dicoding.dev/images/medium";

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(
      String restaurantId) async {
    final response =
        await http.get(Uri.parse("$_baseUrl/detail/$restaurantId"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearchResponse> getRestaurantSearch(String q) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$q"));

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant search');
    }
  }

  Future<RestaurantReviewResponse> addRestaurantReview({
    required String id,
    required String name,
    required String review,
  }) async {
    Map<String, String> body = {
      "id": id,
      "name": name,
      "review": review,
    };

    final response = await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return RestaurantReviewResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
