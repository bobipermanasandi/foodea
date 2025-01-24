import 'package:flutter/material.dart';
import 'package:foodea/data/model/received_notification.dart';
import 'package:foodea/provider/setting/alarm_provider.dart';
import 'package:foodea/provider/setting/local_notification_provider.dart';
import 'package:foodea/provider/setting/payload_provider.dart';
import 'package:foodea/provider/setting/theme_provider.dart';
import 'package:foodea/service/local_notification_service.dart';
import 'package:foodea/static/navigation_route.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) {
      if (mounted) {
        context.read<PayloadProvider>().payload = payload;
        Navigator.pushNamed(context, NavigationRoute.notificationRoute.name,
            arguments: payload);
      }
    });
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) {
      final payload = receivedNotification.payload;
      if (mounted) {
        context.read<PayloadProvider>().payload = payload;
        Navigator.pushNamed(context, NavigationRoute.notificationRoute.name,
            arguments: receivedNotification.payload);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
    _configureDidReceiveLocalNotificationSubject();
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    didReceiveLocalNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

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
              theme.isDarkTheme ? "Dark Mode" : "Light Mode",
              style: RestaurantTextStyle.bodyLargeRegular,
            ),
            trailing: Consumer<ThemeProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () {
                    value.toggleTheme();
                  },
                  child: Icon(
                    theme.isDarkTheme
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_rounded,
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Consumer<AlarmProvider>(
            builder: (context, alarmProvider, child) {
              return ListTile(
                leading: Icon(
                  alarmProvider.isAlarmOn ? Icons.alarm : Icons.alarm_off,
                ),
                title: Text(alarmProvider.isAlarmOn ? "Alarm On" : "Alarm Off"),
                trailing: Switch(
                  value: alarmProvider.isAlarmOn,
                  onChanged: (value) async {
                    await _requestPermission();
                    await alarmProvider.toggleAlarm();
                  },
                ),
              );
            },
          ),
          const Divider(),
          ElevatedButton(
            onPressed: () async {
              await _checkPendingNotificationRequests();
            },
            child: const Text(
              "Check pending notifications",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestPermission() async {
    context.read<LocalNotificationProvider>().requestPermissions();
  }

  Future<void> _checkPendingNotificationRequests() async {
    final localNotificationProvider = context.read<LocalNotificationProvider>();
    await localNotificationProvider.checkPendingNotificationRequests(context);

    if (!mounted) {
      return;
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final pendingData = context.select(
            (LocalNotificationProvider provider) =>
                provider.pendingNotificationRequests);
        return AlertDialog(
          title: Text(
            '${pendingData.length} pending notification requests',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: pendingData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = pendingData[index];
                return ListTile(
                  title: Text(
                    item.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item.body ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: IconButton(
                    onPressed: () {
                      localNotificationProvider
                        ..cancelNotification()
                        ..checkPendingNotificationRequests(context);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
