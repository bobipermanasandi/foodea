import 'package:flutter_test/flutter_test.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/data/model/response/restaurant_list_response.dart';
import 'package:foodea/data/model/restaurant.dart';
import 'package:foodea/provider/home/restaurant_list_provider.dart';
import 'package:foodea/static/restaurant_list_result_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiServices])
void main() {
  late MockApiServices mockApiService;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    mockApiService = MockApiServices();
    restaurantListProvider = RestaurantListProvider(mockApiService);
  });

  group("RestaurantListProvider Test", () {
    test("test initial status provide has been determined", () {
      expect(
          restaurantListProvider.resultState, isA<RestaurantListNoneState>());
    });

    test('test load data and return empty', () async {
      final emptyResponse = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 0,
        restaurants: [],
      );

      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => emptyResponse);

      await restaurantListProvider.fetchRestaurantList();

      expect(
          restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
      final state =
          restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(state.data.isEmpty, true);
    });

    test("test load data and return data", () async {
      final response = RestaurantListResponse(
        error: false,
        message: 'success',
        count: 2,
        restaurants: [
          Restaurant(
            id: 'uewq1zg2zlskfw1e867',
            name: 'Kafein',
            description:
                'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue.',
            pictureId: '15',
            city: 'Aceh',
            rating: 4.6,
          ),
          Restaurant(
            id: 'dwg2wt3is19kfw1e867',
            name: 'Drinky Squash',
            description:
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor',
            pictureId: '18',
            city: 'Surabaya',
            rating: 3.9,
          ),
        ],
      );

      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => response);

      await restaurantListProvider.fetchRestaurantList();

      expect(
          restaurantListProvider.resultState, isA<RestaurantListLoadedState>());
      final state =
          restaurantListProvider.resultState as RestaurantListLoadedState;
      expect(state.data.length, 2);
      expect(state.data[1].name, "Drinky Squash");
    });

    test("test load data and return Error", () async {
      when(mockApiService.getRestaurantList())
          .thenThrow(Exception("Failed to load data"));

      await restaurantListProvider.fetchRestaurantList();

      expect(
          restaurantListProvider.resultState, isA<RestaurantListErrorState>());
      final state =
          restaurantListProvider.resultState as RestaurantListErrorState;
      expect(state.error, "Exception: Failed to load data");
    });
  });
}
