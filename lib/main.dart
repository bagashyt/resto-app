import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/injector.dart';
import 'package:resto_app/provider/list_restaurant_provider.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/provider/restaurant_favorite_provider.dart';
import 'package:resto_app/provider/restaurant_search_provider.dart';
import 'package:resto_app/provider/schedule_provider.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';
import 'package:resto_app/ui/restaurant_favorite_page.dart';
import 'package:resto_app/ui/restaurant_search_page.dart';
import 'package:resto_app/ui/setting_page.dart';
import 'package:resto_app/ui/widget/card_item.dart';
import 'package:resto_app/utils/background_service_utils.dart';
import 'package:resto_app/utils/navigation_utils.dart';
import 'package:resto_app/utils/notification_utils.dart';
import 'package:resto_app/utils/result_state.dart';
import 'package:resto_app/injector.dart' as di;

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final notificationUtils = NotificationUtils();
  final service = locator<BackgroundServiceUtils>();
  notificationUtils.initNotifications(flutterLocalNotificationsPlugin);
  notificationUtils.requestIOSPermission(flutterLocalNotificationsPlugin);
  service.initializeIsolate();
  if (Platform.isAndroid) {
    AndroidAlarmManager.initialize();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final navigatorKey = NavigationUtils.navigatorKey;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<ListRestaurantProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantDetailProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantSearchProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RestaurantFavoriteProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ScheduleProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'resto app',
        theme: ThemeData.light(),
        home: const HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case RestaurantDetailPage.ROUTE_NAME:
              final id = settings.arguments as String;
              return MaterialPageRoute(
                  builder: (_) => RestaurantDetailPage(id: id));
            case RestaurantSearchPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const RestaurantSearchPage());
            case RestaurantFavoritePage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const RestaurantFavoritePage());
            case SettingPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const SettingPage());
            default:
              return MaterialPageRoute(
                  builder: (_) => const Scaffold(
                        body: Center(
                          child: Text("Page not Found"),
                        ),
                      ));
          }
        },
        navigatorKey: navigatorKey,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ListRestaurantProvider>(context, listen: false)
            .listRestaurant);
  }

  void _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.pushNamed(
            context,
            RestaurantSearchPage.ROUTE_NAME,
          );
          break;
        case 1:
          Navigator.pushNamed(
            context,
            RestaurantFavoritePage.ROUTE_NAME,
          );
          break;
        case 2:
          Navigator.pushNamed(
            context,
            SettingPage.ROUTE_NAME,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resto App'),
      ),
      body: Consumer<ListRestaurantProvider>(
        builder: (context, data, child) {
          var state = data.state;
          if (state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == ResultState.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final resto = data.listRestaurant[index];
                return CardItem(restaurant: resto);
              },
              itemCount: data.listRestaurant.length,
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                      'Please Check Your Connection and Try Again later'),
                  ElevatedButton(
                      onPressed: () {
                        data.fectListRestaurant();
                        if (data.listRestaurant.isNotEmpty) {
                          state = ResultState.hasData;
                        }
                      },
                      child: const Text('Try Again'))
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'setting',
          ),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        onTap: _onSelected,
      ),
    );
  }
}
