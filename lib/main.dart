import 'package:flutter/material.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/data/local/local_database_service.dart';
import 'package:foodea/data/local/shared_preference_service.dart';
import 'package:foodea/provider/detail/restaurant_detail_provider.dart';
import 'package:foodea/provider/detail/restaurant_review_provider.dart';
import 'package:foodea/provider/favorite/local_database_provider.dart';
import 'package:foodea/provider/home/restaurant_list_provider.dart';
import 'package:foodea/provider/setting/alarm_provider.dart';
import 'package:foodea/provider/setting/local_notification_provider.dart';
import 'package:foodea/provider/setting/payload_provider.dart';
import 'package:foodea/provider/setting/theme_provider.dart';
import 'package:foodea/provider/main/index_nav_provider.dart';
import 'package:foodea/provider/search/restaurant_search_provider.dart';
import 'package:foodea/screen/detail/detail_screen.dart';
import 'package:foodea/screen/detail/notification_screen.dart';
import 'package:foodea/screen/main/main_screen.dart';
import 'package:foodea/screen/search/search_screen.dart';
import 'package:foodea/service/http_service.dart';
import 'package:foodea/service/local_notification_service.dart';
import 'package:foodea/service/workmanager_service.dart';
import 'package:foodea/static/navigation_route.dart';
import 'package:foodea/style/theme/restaurant_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  String route = NavigationRoute.mainRoute.name;
  String? payload;

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final notificationResponse =
        notificationAppLaunchDetails!.notificationResponse;
    route = NavigationRoute.notificationRoute.name;
    payload = notificationResponse?.payload;
  }

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => HttpService(),
        ),
        Provider(
          create: (context) => ApiServices(),
        ),
        Provider(
          create: (context) => SharedPreferenceService(),
        ),
        Provider(
          create: (context) => LocalDatabaseService(),
        ),
        Provider(
          create: (context) => LocalNotificationService(
            context.read<HttpService>(),
          )
            ..init()
            ..configureLocalTimeZone(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalNotificationProvider(
            context.read<LocalNotificationService>(),
          )..requestPermissions(),
        ),
        Provider(
          create: (context) => WorkmanagerService(
            localNotificationProvider:
                context.read<LocalNotificationProvider>(),
          )..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => AlarmProvider(
            context.read<SharedPreferenceService>(),
            context.read<WorkmanagerService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PayloadProvider(
            payload: payload,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            context.read<SharedPreferenceService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => IndexNavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalDatabaseProvider(
            context.read<LocalDatabaseService>(),
          ),
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
      child: MyApp(
        initialRoute: route,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Foodea',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: theme.currentTheme,
      initialRoute: initialRoute,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        NavigationRoute.searchRoute.name: (context) => const SearchScreen(),
        NavigationRoute.notificationRoute.name: (context) =>
            const NotificationScreen(),
      },
    );
  }
}
