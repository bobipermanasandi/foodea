import 'package:flutter/material.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      style: RestaurantTextStyle.bodyLargeMedium.copyWith(
        color: RestaurantColors.grey.color,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 24,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: RestaurantTextStyle.bodyLargeMedium.copyWith(
          color: RestaurantColors.grey.color.withValues(
            alpha: 0.5,
          ),
        ),
        filled: true,
        fillColor: Color(0xffF6F6F6),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: RestaurantColors.orange.color,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
