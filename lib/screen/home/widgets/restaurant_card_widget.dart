import 'package:flutter/material.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/data/model/restaurant.dart';
import 'package:foodea/static/navigation_route.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';

class RestaurantCardWidget extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCardWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          NavigationRoute.detailRoute.name,
          arguments: restaurant.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Hero(
                tag: restaurant.pictureId,
                child: Container(
                  width: double.infinity,
                  height: 135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${ApiServices.baseUrlImage}/${restaurant.pictureId}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      restaurant.name,
                      style: RestaurantTextStyle.titleLarge,
                    ),
                  ),
                  Text(
                    restaurant.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: RestaurantTextStyle.labelLarge.copyWith(
                      color: RestaurantColors.shades.color,
                    ),
                  ),
                  SizedBox.square(
                    dimension: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.star_outline_rounded,
                                size: 18,
                                color: RestaurantColors.orange.color,
                              ),
                            ),
                            Text(
                              '${restaurant.rating}',
                              style: RestaurantTextStyle.bodyLargeBold,
                            )
                          ],
                        ),
                      ),
                      SizedBox.square(dimension: 26),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.location_on_outlined,
                                size: 18,
                                color: RestaurantColors.orange.color,
                              ),
                            ),
                            Text(
                              restaurant.city,
                              style: RestaurantTextStyle.bodyLargeBold,
                            )
                          ],
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
