import 'package:flutter/widgets.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';

class DrinkWidget extends StatelessWidget {
  final String name;
  const DrinkWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: RestaurantColors.orange.color,
        ),
      ),
      child: Text(
        name,
        style: RestaurantTextStyle.labelSmall.copyWith(
          color: RestaurantColors.orange.color,
        ),
      ),
    );
  }
}
