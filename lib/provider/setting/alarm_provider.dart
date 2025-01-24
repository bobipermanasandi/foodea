import 'package:flutter/material.dart';
import 'package:foodea/data/local/shared_preference_service.dart';
import 'package:foodea/service/workmanager_service.dart';

class AlarmProvider extends ChangeNotifier {
  final SharedPreferenceService sharedPreferenceService;
  final WorkmanagerService workmanagerService;

  bool _isAlarmOn = false;

  bool get isAlarmOn => _isAlarmOn;

  AlarmProvider(this.sharedPreferenceService, this.workmanagerService) {
    _loadAlarm();
  }

  Future<void> _loadAlarm() async {
    _isAlarmOn = await sharedPreferenceService.getAlarmPreference();

    if (_isAlarmOn) {
      await workmanagerService.runPeriodicTask();
    }
    notifyListeners();
  }

  Future<void> toggleAlarm() async {
    _isAlarmOn = !_isAlarmOn;

    if (_isAlarmOn) {
      await workmanagerService.runPeriodicTask();
      debugPrint("Alarm ON: Notification scheduled for 11 AM daily.");
    } else {
      await workmanagerService.cancelAllTask();
      debugPrint("Alarm OFF: All tasks and notifications canceled.");
    }

    await sharedPreferenceService.setAlarmPreference(_isAlarmOn);
    notifyListeners();
  }
}
