import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/static/restaurant_detail_result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailProvider(
    this._apiServices,
  );

  RestaurantDetailResultState _resultState = RestaurantDetailNoneState();

  RestaurantDetailResultState get resultState => _resultState;

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    try {
      _resultState = RestaurantDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetail(restaurantId);

      if (result.error) {
        _resultState = RestaurantDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } on TimeoutException catch (_) {
      _resultState =
          RestaurantDetailErrorState('Request Timeout. Please try again later');
      notifyListeners();
    } on SocketException catch (_) {
      _resultState = RestaurantDetailErrorState(
          'No Internet Connection. Please try again');
      notifyListeners();
    } on FormatException catch (_) {
      _resultState =
          RestaurantDetailErrorState('Failed to load response data.');
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantDetailErrorState(e.toString());
      notifyListeners();
    }
  }
}
