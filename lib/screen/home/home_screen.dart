import 'package:flutter/material.dart';
import 'package:foodea/provider/home/restaurant_list_provider.dart';
import 'package:foodea/screen/home/widgets/home_header_widget.dart';
import 'package:foodea/screen/home/widgets/restaurant_card_widget.dart';
import 'package:foodea/static/restaurant_list_result_state.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantListProvider>().fetchRestaurantList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            HomeHeaderWidget(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Text(
                    'Hey Kyunzi, ',
                    style: RestaurantTextStyle.bodyLargeMedium,
                  ),
                  Text(
                    'Good Afternoon!',
                    style: RestaurantTextStyle.bodyLargeMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<RestaurantListProvider>(
                builder: (context, value, child) {
                  return switch (value.resultState) {
                    RestaurantListLoadingState() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    RestaurantListLoadedState(data: var restaurantList) =>
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: restaurantList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox.square(dimension: 15),
                        itemBuilder: (context, index) {
                          final restaurant = restaurantList[index];
                          return RestaurantCardWidget(restaurant: restaurant);
                        },
                      ),
                    RestaurantListErrorState(error: var message) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(message),
                          ),
                          SizedBox.square(
                            dimension: 8,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<RestaurantListProvider>()
                                  .fetchRestaurantList();
                            },
                            child: Text(
                              'Refresh',
                            ),
                          )
                        ],
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
