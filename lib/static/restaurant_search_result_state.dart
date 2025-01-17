import 'package:foodea/data/model/restaurant.dart';

sealed class RestaurantSearchResultState {}

class RestaurantSearchNoneState extends RestaurantSearchResultState {}

class RestaurantSearchLoadingState extends RestaurantSearchResultState {}

class RestaurantSearchErrorState extends RestaurantSearchResultState {
  final String error;

  RestaurantSearchErrorState(this.error);
}

class RestaurantSearchEmptyState extends RestaurantSearchResultState {
  final String message;

  RestaurantSearchEmptyState(this.message);
}

class RestaurantSearchLoadedState extends RestaurantSearchResultState {
  final List<Restaurant> data;

  RestaurantSearchLoadedState(this.data);
}
