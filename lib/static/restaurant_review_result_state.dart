sealed class RestaurantReviewResultState {}

class RestaurantReviewNoneState extends RestaurantReviewResultState {}

class RestaurantReviewLoadingState extends RestaurantReviewResultState {}

class RestaurantReviewErrorState extends RestaurantReviewResultState {
  final String error;

  RestaurantReviewErrorState(this.error);
}

class RestaurantReviewSuccessState extends RestaurantReviewResultState {
  final String message;

  RestaurantReviewSuccessState(this.message);
}
