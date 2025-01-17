import 'package:flutter/material.dart';
import 'package:foodea/provider/detail/restaurant_detail_provider.dart';
import 'package:foodea/screen/detail/body_of_detail_screen.dart';
import 'package:foodea/static/restaurant_detail_result_state.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final String restaurantId;
  const DetailScreen({
    super.key,
    required this.restaurantId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context
            .read<RestaurantDetailProvider>()
            .fetchRestaurantDetail(widget.restaurantId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Detail"),
      ),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            RestaurantDetailLoadedState(data: var restaurant) =>
              BodyOfDetailScreenWidget(restaurant: restaurant),
            RestaurantDetailErrorState(error: var message) => Column(
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
                          .read<RestaurantDetailProvider>()
                          .fetchRestaurantDetail(widget.restaurantId);
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
    );
  }
}
