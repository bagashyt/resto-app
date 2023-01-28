import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/schedule_provider.dart';

class SettingPage extends StatelessWidget {
  static const ROUTE_NAME = '/setting';
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: const ScheduleWidget(),
    );
  }
}

class ScheduleWidget extends StatefulWidget {
  const ScheduleWidget({super.key});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScheduleProvider.instace(context).getSchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable Schedule Push Notification (11.00 AM)'),
                const SizedBox(width: 16),
                Switch.adaptive(
                  value: provider.isActive,
                  onChanged: (value) async {
                    if (Platform.isAndroid) {
                      ScheduleProvider.instace(context).setSchedule(value);
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Get Notification of Random Restaurant'),
                ElevatedButton(
                  onPressed: () {
                    provider.fireNotif();
                  },
                  child: const Icon(Icons.notifications),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
