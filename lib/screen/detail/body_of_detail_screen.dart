import 'package:flutter/material.dart';
import 'package:foodea/data/model/restaurant.dart';
import 'package:foodea/data/model/restaurant_detail.dart';
import 'package:foodea/provider/detail/restaurant_detail_provider.dart';
import 'package:foodea/provider/detail/restaurant_review_provider.dart';
import 'package:foodea/screen/detail/widgets/category_widget.dart';
import 'package:foodea/screen/detail/widgets/custom_textformfield_widget.dart';
import 'package:foodea/screen/detail/widgets/drink_widget.dart';
import 'package:foodea/screen/detail/widgets/food_widget.dart';
import 'package:foodea/screen/detail/widgets/picture_header_widget.dart';
import 'package:foodea/screen/detail/widgets/review_card_widget.dart';
import 'package:foodea/static/restaurant_review_result_state.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class BodyOfDetailScreenWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const BodyOfDetailScreenWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<BodyOfDetailScreenWidget> createState() =>
      _BodyOfDetailScreenWidgetState();
}

class _BodyOfDetailScreenWidgetState extends State<BodyOfDetailScreenWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _reviewController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _reviewController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PictureHeaderWidget(
              restaurant: Restaurant(
                id: widget.restaurant.id,
                name: widget.restaurant.name,
                description: widget.restaurant.description,
                pictureId: widget.restaurant.pictureId,
                city: widget.restaurant.city,
                rating: widget.restaurant.rating,
              ),
            ),
            SizedBox.square(
              dimension: 20,
            ),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: List.generate(
                widget.restaurant.categories.length,
                (index) => CategoryWidget(
                  name: widget.restaurant.categories[index].name,
                ),
              ),
            ),
            SizedBox.square(
              dimension: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.restaurant.name,
                style: RestaurantTextStyle.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 24,
                      color: RestaurantColors.orange.color,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${widget.restaurant.address}, ${widget.restaurant.city}',
                      style: RestaurantTextStyle.labelSmall.copyWith(
                          color: RestaurantColors.grey.color
                              .withValues(alpha: 0.7)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox.square(
              dimension: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Description',
                style: RestaurantTextStyle.titleMedium.copyWith(
                  color: RestaurantColors.orange.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ReadMoreText(
              widget.restaurant.description,
              style: RestaurantTextStyle.labelLarge.copyWith(
                color: RestaurantColors.shades.color,
              ),
              trimMode: TrimMode.Line,
              trimLines: 5,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
            ),
            SizedBox.square(
              dimension: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Menus',
                style: RestaurantTextStyle.titleMedium.copyWith(
                  color: RestaurantColors.orange.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Food',
                style: RestaurantTextStyle.bodyLargeMedium,
              ),
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              children: List.generate(
                widget.restaurant.menu.foods.length,
                (index) =>
                    FoodWidget(name: widget.restaurant.menu.foods[index].name),
              ),
            ),
            SizedBox.square(
              dimension: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Drinks',
                style: RestaurantTextStyle.bodyLargeMedium,
              ),
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              children: List.generate(
                widget.restaurant.menu.drinks.length,
                (index) => DrinkWidget(
                  name: widget.restaurant.menu.drinks[index].name,
                ),
              ),
            ),
            SizedBox.square(
              dimension: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews (${widget.restaurant.customerReviews.length})',
                    style: RestaurantTextStyle.titleMedium.copyWith(
                      color: RestaurantColors.orange.color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showModal(context, _formKey);
                    },
                    child: Icon(
                      Icons.add_circle_outline_rounded,
                      size: 26,
                      color: RestaurantColors.orange.color,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.restaurant.customerReviews.length,
                  (index) {
                    var review = widget.restaurant.customerReviews[index];
                    return ReviewCardWidget(review: review);
                  },
                ).reversed.toList(),
              ),
            ),
            SizedBox.square(
              dimension: 30,
            ),
          ],
        ),
      ),
    );
  }

  void _showModal(BuildContext ctxScaffold, GlobalKey<FormState> formKey) {
    showModalBottomSheet(
      context: ctxScaffold,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (ctx, setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 24,
                  right: 24,
                ),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          height: 2,
                          width: 30,
                          decoration: BoxDecoration(
                            color: RestaurantColors.grey.color
                                .withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Add Review',
                          style: RestaurantTextStyle.titleMedium.copyWith(
                            color: RestaurantColors.orange.color,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: CustomTextFormField(
                          controller: _nameController,
                          hintText: 'Enter Fullname',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter fullname';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: CustomTextFormField(
                          controller: _reviewController,
                          hintText: 'Enter Review',
                          textInputAction: TextInputAction.go,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter review';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox.square(
                        dimension: 10,
                      ),
                      Consumer<RestaurantReviewProvider>(
                        builder: (context, value, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (value.resultState
                                is RestaurantReviewErrorState) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    value.message,
                                    style: RestaurantTextStyle.labelSmall,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Future.delayed(Duration.zero, () {
                                value.reset();
                              });
                            }
                            if (value.resultState
                                is RestaurantReviewSuccessState) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    value.message,
                                    style: RestaurantTextStyle.labelSmall,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Future.delayed(const Duration(seconds: 1), () {
                                if (ctxScaffold.mounted) {
                                  ctxScaffold
                                      .read<RestaurantDetailProvider>()
                                      .fetchRestaurantDetail(
                                        widget.restaurant.id,
                                      );
                                }
                              });
                              Future.delayed(Duration.zero, () {
                                value.reset();
                              });
                            }
                          });

                          return switch (value.resultState) {
                            RestaurantReviewLoadingState() => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            _ => SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        RestaurantColors.orange.color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      value.addRestaurantReview(
                                        restaurantId: widget.restaurant.id,
                                        name: _nameController.text,
                                        review: _reviewController.text,
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: RestaurantTextStyle.titleSmall
                                          .copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          };
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
