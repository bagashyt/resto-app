import 'package:resto_app/data/db/shared_pref_helper.dart';

class ScheduleUtils {
  final _key = 'schedule_alarm';

  Future<bool> getSchedule() {
    final shared = SharedPrefHelper();
    return shared.read(_key);
  }

  Future<bool> setSchedule(bool isActive) {
    final shared = SharedPrefHelper();
    return shared.store(_key, isActive);
  }
}
