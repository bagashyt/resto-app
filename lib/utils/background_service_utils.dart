import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/main.dart';
import 'package:resto_app/utils/notification_utils.dart';
import 'package:http/http.dart' as http;

final ReceivePort port = ReceivePort();

class BackgroundServiceUtils {
  static BackgroundServiceUtils? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundServiceUtils._internal() {
    _instance = this;
  }

  factory BackgroundServiceUtils() =>
      _instance ?? BackgroundServiceUtils._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm Fired');
    }
    final notificationUtils = NotificationUtils();
    final restaurantServices = ApiService(client: http.Client());
    final rawData = await restaurantServices.getListRestaurant();
    final restaurant = rawData.restaurants;
    Random random = Random();
    final randomRestaurant = restaurant[random.nextInt(restaurant.length)];

    notificationUtils.showNotification(
      flutterLocalNotificationsPlugin,
      'Restaurant ${randomRestaurant.name}',
      "Let's visit our Restaurant",
      randomRestaurant.id,
    );
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

}
