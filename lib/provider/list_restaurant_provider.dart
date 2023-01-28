import 'package:flutter/foundation.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant_model.dart';
import 'package:resto_app/utils/result_state.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider(this.apiService) {
    fectListRestaurant();
  }

  late ResultState _state;
  ResultState get state => _state;

  var _listRestaurant = <Restaurant>[];
  List<Restaurant> get listRestaurant => _listRestaurant;

  String _message = '';
  String get message => _message;

  Future<dynamic> fectListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty_Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurant = restaurant.restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error $e';
    }
  }
}
