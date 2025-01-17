import 'package:flutter/material.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/provider/detail/restaurant_detail_provider.dart';
import 'package:foodea/provider/detail/restaurant_review_provider.dart';
import 'package:foodea/provider/favorite/favorite_list_provider.dart';
import 'package:foodea/provider/home/restaurant_list_provider.dart';
import 'package:foodea/provider/home/theme_provider.dart';
import 'package:foodea/provider/main/index_nav_provider.dart';
import 'package:foodea/provider/search/restaurant_search_provider.dart';
import 'package:foodea/screen/detail/detail_screen.dart';
import 'package:foodea/screen/main/main_screen.dart';
import 'package:foodea/screen/search/search_screen.dart';
import 'package:foodea/static/navigation_route.dart';
import 'package:foodea/style/theme/restaurant_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiServices(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            context.read<ApiServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantReviewProvider(
            context.read<ApiServices>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Foodea',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        NavigationRoute.searchRoute.name: (context) => const SearchScreen(),
      },
    );
  }
}
