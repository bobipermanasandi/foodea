import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodea/service/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService localNotificationService;

  LocalNotificationProvider(this.localNotificationService);

  bool? _permission = false;
  bool? get permission => _permission;

  List<PendingNotificationRequest> pendingNotificationRequests = [];

  int _notificationId = 0;

  Future<void> requestPermissions() async {
    _permission = await localNotificationService.requestPermissions();
    notifyListeners();
  }

  void showNotification() {
    _notificationId += 1;
    localNotificationService.showNotification(
      id: _notificationId,
      title: "New Notification",
      body: "This is a new notification with id $_notificationId",
      payload: "This is a payload from notification with id $_notificationId",
    );
  }

  Future<void> scheduleDailyElevenAMNotification() async {
    await localNotificationService.scheduleDailyElevenAMNotification(
      id: 1,
      channelId: "3",
      channelName: "Schedule Notification",
    );
    debugPrint("Notification scheduled for 11 AM daily.");
  }

  Future<void> checkPendingNotificationRequests(BuildContext context) async {
    pendingNotificationRequests =
        await localNotificationService.pendingNotificationRequests();
    notifyListeners();
  }

  Future<void> cancelNotification() async {
    await localNotificationService.cancelNotification();
  }
}
