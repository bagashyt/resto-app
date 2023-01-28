import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/injector.dart';
import 'package:resto_app/utils/background_service_utils.dart';
import 'package:resto_app/utils/date_utils.dart';
import 'package:resto_app/utils/schedule_utils.dart';

class ScheduleProvider extends ChangeNotifier {
  bool _isActive = false;
  bool get isActive => _isActive;

  final scheduleUtils = locator<ScheduleUtils>();
  final bacgroundUtils = locator<BackgroundServiceUtils>();

  static ScheduleProvider instace(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<bool> setSchedule(bool value) async {
    _isActive = value;

    if (_isActive) {
      ('alarm activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(minutes: 5),
        1,
        BackgroundServiceUtils.callback,
        startAt: DateTimeFormat.format(),
        exact: true,
        wakeup: true,
        allowWhileIdle: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void getSchedule() async {
    final schedule = await scheduleUtils.getSchedule();
    _isActive = schedule;
    notifyListeners();
  }

  void fireNotif() async {
    final result = await BackgroundServiceUtils.callback();
    result;
  }

}
