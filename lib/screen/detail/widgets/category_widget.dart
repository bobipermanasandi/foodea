import 'package:flutter/widgets.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';

class CategoryWidget extends StatelessWidget {
  final String name;
  const CategoryWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Color(0xffE9E9E9),
        ),
      ),
      child: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: RestaurantTextStyle.bodyLargeRegular,
      ),
    );
  }
}
