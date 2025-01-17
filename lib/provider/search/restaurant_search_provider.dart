import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/static/restaurant_search_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(
    this._apiServices,
  );

  RestaurantSearchResultState _resultState = RestaurantSearchNoneState();

  RestaurantSearchResultState get resultState => _resultState;

  String _message = '';
  String get message => _message;

  void reset() {
    _resultState = RestaurantSearchNoneState();
    _message = '';
    notifyListeners();
  }

  Future<void> fetchRestaurantSearch(String q) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestaurantSearch(q);

      if (result.error) {
        _message = 'Failed to load restaurant search';
        _resultState = RestaurantSearchErrorState(_message);
        notifyListeners();
      } else if (result.founded == 0) {
        _message = 'Data Not Found';
        _resultState = RestaurantSearchEmptyState(_message);
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on TimeoutException catch (_) {
      _message = 'Request Timeout. Please try again later';
      _resultState = RestaurantSearchErrorState(_message);
      notifyListeners();
    } on SocketException catch (_) {
      _message = 'No Internet Connection. Please try again';
      _resultState = RestaurantSearchErrorState(_message);
      notifyListeners();
    } on FormatException catch (_) {
      _message = 'Failed to load response data';
      _resultState = RestaurantSearchErrorState(_message);
      notifyListeners();
    } on Exception catch (e) {
      _message = e.toString();
      _resultState = RestaurantSearchErrorState(_message);
      notifyListeners();
    }
  }
}
