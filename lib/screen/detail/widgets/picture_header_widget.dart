import 'package:flutter/material.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/data/model/restaurant.dart';
import 'package:foodea/provider/favorite/favorite_icon_provider.dart';
import 'package:foodea/screen/detail/widgets/favorite_icon_widget.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:provider/provider.dart';

class PictureHeaderWidget extends StatelessWidget {
  final Restaurant restaurant;
  const PictureHeaderWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteIconProvider(),
      child: Stack(
        children: [
          Hero(
            tag: restaurant.pictureId,
            child: Container(
              width: double.infinity,
              height: 185,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: NetworkImage(
                      '${ApiServices.baseUrlImage}/${restaurant.pictureId}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 185,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black.withValues(
                alpha: 0.3,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withValues(alpha: 0.5),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 18,
                    color: RestaurantColors.orange.color,
                  ),
                  Text(
                    '${restaurant.rating}',
                    style: RestaurantTextStyle.titleSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              child: FavoriteIconWidget(
                restaurant: restaurant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
