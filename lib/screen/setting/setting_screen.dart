import 'package:flutter/material.dart';
import 'package:foodea/provider/setting/theme_provider.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Appearance',
              style: RestaurantTextStyle.titleMedium,
            ),
            subtitle: Text(
              'Set Theme Mode',
              style: RestaurantTextStyle.bodyLargeRegular,
            ),
            trailing: Consumer<ThemeProvider>(
              builder: (context, value, child) {
                final isDarkMode = value.themeMode == ThemeMode.dark;
                return GestureDetector(
                  onTap: () {
                    value.setTheme();
                  },
                  child: Icon(
                    (isDarkMode) ? Icons.dark_mode : Icons.light_mode_rounded,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
