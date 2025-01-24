import 'package:flutter/material.dart';
import 'package:foodea/provider/setting/payload_provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final data = context.read<PayloadProvider>().payload;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Screen"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Payload: $data",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Go back!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
