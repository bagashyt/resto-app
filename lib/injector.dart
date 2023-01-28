import 'package:get_it/get_it.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/db/database_helper.dart';
import 'package:resto_app/data/db/shared_pref_helper.dart';
import 'package:resto_app/provider/list_restaurant_provider.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/provider/restaurant_favorite_provider.dart';
import 'package:resto_app/provider/restaurant_search_provider.dart';
import 'package:resto_app/provider/schedule_provider.dart';
import 'package:resto_app/utils/background_service_utils.dart';
import 'package:resto_app/utils/navigation_utils.dart';
import 'package:resto_app/utils/notification_utils.dart';
import 'package:resto_app/utils/schedule_utils.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(() => ApiService(client: locator()));
  locator.registerLazySingleton(() => DatabaseHelper());
  locator.registerLazySingleton(() => SharedPrefHelper());
  locator.registerLazySingleton(() => BackgroundServiceUtils());
  locator.registerLazySingleton(() => ScheduleUtils());

  locator.registerFactory(() => NotificationUtils());
  locator.registerFactory(() => RestaurantDetailProvider(ApiService(client: locator())));
  locator.registerFactory(() => ListRestaurantProvider(ApiService(client: locator())));
  locator.registerFactory(() => RestaurantSearchProvider());
  locator.registerFactory(() => RestaurantFavoriteProvider(DatabaseHelper()));
  locator.registerFactory(() => ScheduleProvider());
  locator.registerFactory(() => NavigationUtils());

  locator.registerLazySingleton(() => http.Client());
}
