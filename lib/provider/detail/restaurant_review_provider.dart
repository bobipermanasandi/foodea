import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/static/restaurant_review_result_state.dart';

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantReviewProvider(
    this._apiServices,
  );

  RestaurantReviewResultState _resultState = RestaurantReviewNoneState();

  RestaurantReviewResultState get resultState => _resultState;

  String _message = '';
  String get message => _message;

  void reset() {
    _resultState = RestaurantReviewNoneState();
    _message = '';
    notifyListeners();
  }

  Future<void> addRestaurantReview({
    required String restaurantId,
    required String name,
    required String review,
  }) async {
    try {
      _resultState = RestaurantReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.addRestaurantReview(
        id: restaurantId,
        name: name,
        review: review,
      );

      if (result.error) {
        _resultState = RestaurantReviewErrorState(result.message);
        notifyListeners();
      } else {
        _message = 'Success Add review';
        _resultState = RestaurantReviewSuccessState(_message);
        notifyListeners();
      }
    } on TimeoutException catch (_) {
      _message = 'Request Timeout. Please try again later';
      _resultState = RestaurantReviewErrorState(_message);

      notifyListeners();
    } on SocketException catch (_) {
      _message = 'No Internet Connection. Please try again';
      _resultState = RestaurantReviewErrorState(_message);
      notifyListeners();
    } on FormatException catch (_) {
      _message = 'Failed to load response data';
      _resultState = RestaurantReviewErrorState(_message);
      notifyListeners();
    } on Exception catch (e) {
      _message = e.toString();
      _resultState = RestaurantReviewErrorState(_message);
      notifyListeners();
    }
  }
}
