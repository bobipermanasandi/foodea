import 'package:flutter_test/flutter_test.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/data/model/response/restaurant_search_response.dart';
import 'package:foodea/data/model/restaurant.dart';
import 'package:foodea/provider/search/restaurant_search_provider.dart';
import 'package:foodea/static/restaurant_search_result_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_search_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiService;
  late RestaurantSearchProvider restaurantSearchProvider;

  setUp(() {
    mockApiService = MockApiServices();
    restaurantSearchProvider = RestaurantSearchProvider(mockApiService);
  });

  const String dummy = 'dummy';

  group("RestaurantSearchProvider Test", () {
    test("test initial status provide has been determined", () {
      expect(restaurantSearchProvider.resultState,
          isA<RestaurantSearchNoneState>());
    });

    test('test search data and return empty', () async {
      final emptyResponse = RestaurantSearchResponse(
        error: false,
        founded: 0,
        restaurants: [],
      );

      when(mockApiService.getRestaurantSearch(dummy))
          .thenAnswer((_) async => emptyResponse);

      await restaurantSearchProvider.fetchRestaurantSearch(dummy);

      expect(restaurantSearchProvider.resultState,
          isA<RestaurantSearchEmptyState>());
      final state =
          restaurantSearchProvider.resultState as RestaurantSearchEmptyState;
      expect(state.message, 'Data Not Found');
    });

    test('test search data from search and return data', () async {
      final response = RestaurantSearchResponse(
        error: false,
        founded: 2,
        restaurants: [
          Restaurant(
            id: 'w9pga3s2tubkfw1e867',
            name: 'Bring Your Phone Cafe',
            description:
                'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.',
            pictureId: '03',
            city: 'Surabaya',
            rating: 4.2,
          ),
          Restaurant(
            id: 'w7jca3irwykfw1e867',
            name: 'Fairy Cafe',
            description:
                'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi.',
            pictureId: '24',
            city: 'Surabaya',
            rating: 5,
          ),
        ],
      );

      when(mockApiService.getRestaurantSearch('cafe'))
          .thenAnswer((_) async => response);

      await restaurantSearchProvider.fetchRestaurantSearch('cafe');

      expect(restaurantSearchProvider.resultState,
          isA<RestaurantSearchLoadedState>());
      final state =
          restaurantSearchProvider.resultState as RestaurantSearchLoadedState;
      expect(state.data.length, 2);
      expect(state.data[1].name, "Fairy Cafe");
    });

    test('test search data and return Error', () async {
      when(mockApiService.getRestaurantSearch(dummy))
          .thenThrow(Exception("Failed to search restaurant"));

      await restaurantSearchProvider.fetchRestaurantSearch(dummy);

      expect(restaurantSearchProvider.resultState,
          isA<RestaurantSearchErrorState>());
      final state =
          restaurantSearchProvider.resultState as RestaurantSearchErrorState;
      expect(state.error, "Exception: Failed to search restaurant");
    });
  });
}
