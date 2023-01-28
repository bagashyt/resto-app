import 'package:flutter/foundation.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/db/database_helper.dart';
import 'package:resto_app/data/db/favorite_data_source.dart';
import 'package:resto_app/data/model/favorite_table.dart';
import 'package:resto_app/data/model/restaurant_detail_model.dart';
import 'package:resto_app/utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final FavoriteLocalDataSourceImpl datasource =
      FavoriteLocalDataSourceImpl(databaseHelper: DatabaseHelper());

  late RestaurantDetail _detail;

  RestaurantDetailProvider(this.apiService);

  RestaurantDetail get detail => _detail;

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  String _message = '';
  String get message => _message;

  Future<void> fetchDetailRestaurant(String id) async {
    _state = ResultState.loading;
    notifyListeners();
    try {
      final detailResult = await apiService.getDetailRestaurant(id);
      _detail = detailResult.restaurant;
      _state = ResultState.hasData;
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = '$e';
    }
  }

  Future<void> addFavorite(RestaurantDetail resto) async {
    try {
      final result =
          await datasource.insertFavorite(FavoriteTable.fromEntity(resto));
      result;
      _isFavorite = true;
      _message = 'Added to Favorite';
      notifyListeners();
    } catch (e) {
      _message = 'Add to Favorite Error';
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      final result = await datasource.removeFavorite(id);
      result;
      _isFavorite = false;
      _message = 'Removed from Favorite';
      notifyListeners();
    } catch (e) {
      _message = 'Remove from Favorite Error';
    }
  }

  Future<void> statusFavorite(String id) async {
    try {
      final result = await datasource.getFavoriteById(id);
      if (result != null) {
        _isFavorite = true;
        notifyListeners();
      } else {
        _isFavorite = false;
        notifyListeners();
      }
    } catch (e) {
      _message = 'Status Favorite Error';
    }
  }
}
