import 'package:flutter/foundation.dart';
import 'package:resto_app/data/db/database_helper.dart';
import 'package:resto_app/data/db/favorite_data_source.dart';
import 'package:resto_app/data/model/favorite_table.dart';
import 'package:resto_app/utils/result_state.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  final FavoriteLocalDataSourceImpl datasource =
      FavoriteLocalDataSourceImpl(databaseHelper: DatabaseHelper());

  List<FavoriteTable> _listResto = [];

  RestaurantFavoriteProvider(this.databaseHelper) {
    fetchFavorite();
  }
  List<FavoriteTable> get listResto => _listResto;

  String _message = '';
  String get message => _message;

  late ResultState _state;
  ResultState get state => _state;

  Future<void> fetchFavorite() async {
    _state = ResultState.loading;
    notifyListeners();
    try {
      final result = await datasource.getFavoriteList();
      if (result.isNotEmpty) {
        _listResto = result;
        _state = ResultState.hasData;
        notifyListeners();
      } else {
        _listResto = [];
        _state = ResultState.noData;
        _message = 'No data Favorite';
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
