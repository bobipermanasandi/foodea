import 'package:flutter/material.dart';

enum RestaurantColors {
  orange("Orange", Color(0xffFC6E2A)),
  grey("Grey", Color(0xff676767)),
  shades('Shades', Color(0xffA0A5BA));

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
