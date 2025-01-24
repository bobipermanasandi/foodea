import 'package:flutter/material.dart';
import 'package:foodea/data/model/customer_review.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:readmore/readmore.dart';

class ReviewCardWidget extends StatelessWidget {
  final CustomerReview review;
  const ReviewCardWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffF6F6F6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              review.name,
              style: RestaurantTextStyle.titleMedium.copyWith(
                color: RestaurantColors.orange.color,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ReadMoreText(
              '"${review.review}"',
              style: RestaurantTextStyle.labelMedium.copyWith(
                color: RestaurantColors.grey.color,
                fontStyle: FontStyle.italic,
              ),
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'Show more',
              trimExpandedText: ' Show less',
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              review.date,
              style: RestaurantTextStyle.labelSmall.copyWith(
                fontSize: 10,
                color: Colors.blueGrey.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
