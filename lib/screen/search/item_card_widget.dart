import 'package:flutter/material.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/data/model/restaurant.dart';
import 'package:foodea/static/navigation_route.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';

class ItemCardWidget extends StatelessWidget {
  final Restaurant restaurant;
  const ItemCardWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(
          context,
          NavigationRoute.detailRoute.name,
          arguments: restaurant.id,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 80,
                minHeight: 80,
                maxWidth: 120,
                minWidth: 120,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  '${ApiServices.baseUrlImage}/${restaurant.pictureId}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox.square(dimension: 6),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.star_outline_rounded,
                          size: 18,
                          color: RestaurantColors.orange.color,
                        ),
                      ),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(
                          '${restaurant.rating}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 6),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: RestaurantColors.orange.color,
                        ),
                      ),
                      const SizedBox.square(dimension: 4),
                      Expanded(
                        child: Text(
                          restaurant.city,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
