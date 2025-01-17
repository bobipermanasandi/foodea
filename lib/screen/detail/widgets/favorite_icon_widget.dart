import 'package:flutter/material.dart';
import 'package:foodea/data/model/restaurant.dart';
import 'package:foodea/provider/favorite/favorite_icon_provider.dart';
import 'package:foodea/provider/favorite/favorite_list_provider.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteIconWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  @override
  void initState() {
    final favoriteListProvider = context.read<FavoriteListProvider>();
    final favoriteIconProvider = context.read<FavoriteIconProvider>();

    Future.microtask(() {
      final restaurantInList =
          favoriteListProvider.checkItemFavorite(widget.restaurant);
      favoriteIconProvider.isFavorite = restaurantInList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final favoriteListProvider = context.read<FavoriteListProvider>();
        final favoriteIconProvider = context.read<FavoriteIconProvider>();
        final isFavorite = favoriteIconProvider.isFavorite;

        if (isFavorite) {
          favoriteListProvider.removeFavorite(widget.restaurant);
        } else {
          favoriteListProvider.addFavorite(widget.restaurant);
        }
        context.read<FavoriteIconProvider>().isFavorite = !isFavorite;
      },
      child: Icon(
        context.watch<FavoriteIconProvider>().isFavorite
            ? Icons.favorite
            : Icons.favorite_border_rounded,
        color: Colors.white,
      ),
    );
  }
}
