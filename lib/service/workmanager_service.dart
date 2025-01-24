import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodea/data/api/api_service.dart';
import 'package:foodea/provider/setting/local_notification_provider.dart';
import 'package:foodea/service/http_service.dart';
import 'package:foodea/service/local_notification_service.dart';
import 'package:foodea/static/workmanager_state.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == WorkmanagerState.oneOff.taskName ||
        task == WorkmanagerState.oneOff.uniqueName ||
        task == Workmanager.iOSBackgroundTask) {
      debugPrint("One-off Task: $inputData");
    } else if (task == WorkmanagerState.periodic.taskName) {
      await backgroundTask();
    }
    return Future.value(true);
  });
}

Future<void> backgroundTask() async {
  try {
    final httpService = HttpService();
    final apiService = ApiServices();
    final localNotificationService = LocalNotificationService(httpService);
    var restaurantList = await apiService.getRestaurantList();
    String recommendRestaurant = restaurantList
        .restaurants[Random().nextInt(restaurantList.restaurants.length)].name;

    await localNotificationService.configureLocalTimeZone();
    await localNotificationService.scheduleDailyElevenAMNotification(
      id: 1,
      channelId: "3",
      channelName: "Schedule Notification",
      restaurantName: recommendRestaurant,
    );

    debugPrint('Recommendation Restaurant today : $recommendRestaurant');
  } catch (e, s) {
    debugPrint('ERROR BACKGROUND TASK $e');
    debugPrint('ERROR BACKGROUND TASK STACK $s');
  }
}

class WorkmanagerService {
  final Workmanager _workmanager;
  final LocalNotificationProvider localNotificationProvider;

  WorkmanagerService({
    Workmanager? workmanager,
    required this.localNotificationProvider,
  }) : _workmanager = workmanager ?? Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  }

  Future<void> runOneOffTask() async {
    await _workmanager.registerOneOffTask(
      WorkmanagerState.oneOff.uniqueName,
      WorkmanagerState.oneOff.taskName,
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
      initialDelay: const Duration(seconds: 5),
      inputData: {
        "data": "This is a valid payload from oneoff task workmanager",
      },
    );
  }

  Future<void> runPeriodicTask() async {
    await _workmanager.registerPeriodicTask(
      WorkmanagerState.periodic.uniqueName,
      WorkmanagerState.periodic.taskName,
      frequency: const Duration(minutes: 15),
      initialDelay: Duration.zero,
      inputData: {
        "data": "This is a valid payload from periodic task workmanager",
      },
    );
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
    await localNotificationProvider.cancelNotification();
    debugPrint("All tasks canceled");
  }
}
