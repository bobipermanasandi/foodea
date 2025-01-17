import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/static/restaurant_list_result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantListProvider(
    this._apiServices,
  );

  RestaurantListResultState _resultState = RestaurantListNoneState();

  RestaurantListResultState get resultState => _resultState;

  Future<void> fetchRestaurantList() async {
    try {
      _resultState = RestaurantListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantList();

      if (result.error) {
        _resultState = RestaurantListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestaurantListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on TimeoutException catch (_) {
      _resultState =
          RestaurantListErrorState('Request Timeout. Please try again later');
      notifyListeners();
    } on SocketException catch (_) {
      _resultState =
          RestaurantListErrorState('No Internet Connection. Please try again');
      notifyListeners();
    } on FormatException catch (_) {
      _resultState = RestaurantListErrorState('Failed to load response data.');
      notifyListeners();
    } on Exception catch (e) {
      _resultState = RestaurantListErrorState(e.toString());
      notifyListeners();
    }
  }
}
