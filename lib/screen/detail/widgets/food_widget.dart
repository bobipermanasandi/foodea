import 'package:flutter/material.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';

class FoodWidget extends StatelessWidget {
  final String name;
  const FoodWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: RestaurantColors.orange.color,
      ),
      child: Text(
        name,
        style: RestaurantTextStyle.labelSmall.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
