import 'package:flutter/material.dart';
import 'package:foodea/provider/home/theme_provider.dart';
import 'package:foodea/static/navigation_route.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 54, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/photo.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(
                        'DELIVERY TO',
                        style: RestaurantTextStyle.labelMedium.copyWith(
                          color: RestaurantColors.orange.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Santiago Bernabéu Stadium',
                      style: RestaurantTextStyle.labelLarge.copyWith(
                        color: RestaurantColors.grey.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Hero(
            tag: 'search-restaurant',
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.searchRoute.name,
                    );
                  },
                  child: Icon(
                    Icons.search_rounded,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              themeProvider.toggleTheme(!themeProvider.isDarkMode);
            },
            child: Icon(
              (themeProvider.isDarkMode)
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
    );
  }
}
