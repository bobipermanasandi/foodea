import 'package:flutter/material.dart';
import 'package:foodea/provider/favorite/local_database_provider.dart';
import 'package:foodea/screen/home/widgets/restaurant_card_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        context.read<LocalDatabaseProvider>().loadAllRestaurant();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final favoriteList = value.restaurantList ?? [];
          return switch (favoriteList.isNotEmpty) {
            true => ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: favoriteList.length,
                separatorBuilder: (context, index) =>
                    SizedBox.square(dimension: 15),
                itemBuilder: (context, index) {
                  final restaurant = favoriteList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 10,
                    ),
                    child: RestaurantCardWidget(restaurant: restaurant),
                  );
                },
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Favorite Restaurant"),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
