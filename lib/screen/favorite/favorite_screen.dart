import 'package:flutter/material.dart';
import 'package:foodea/provider/favorite/favorite_list_provider.dart';
import 'package:foodea/screen/home/widgets/restaurant_card_widget.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite List"),
      ),
      body: Consumer<FavoriteListProvider>(
        builder: (context, value, child) {
          final favoriteList = value.favoriteList;
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
