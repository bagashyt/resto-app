import 'package:flutter/material.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant_model.dart';
import 'package:resto_app/utils/result_state.dart';
import 'package:resto_app/injector.dart' as injector;

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService = injector.locator<ApiService>();

  List<Restaurant> _listResto = <Restaurant>[];
  List<Restaurant> get listResto => _listResto;

  ResultState _state = ResultState.noData;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    _state = ResultState.loading;
    notifyListeners();
    try {
      final result = await apiService.searchRestaurant(query);
      if(result.restaurants.isEmpty) {
        _state = ResultState.noData;
        _message = 'Empty_Data';
        notifyListeners();
      } else {
        _listResto = result.restaurants;
        _state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = '$e';
      notifyListeners();
    }
  }
}
