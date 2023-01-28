import 'package:resto_app/data/db/database_helper.dart';
import 'package:resto_app/data/model/favorite_table.dart';
import 'package:resto_app/utils/exception.dart';

abstract class FavoriteLocalDataSource {
  Future<String> insertFavorite(FavoriteTable favorite);
  Future<String> removeFavorite(String id);
  Future<FavoriteTable?> getFavoriteById(String id);
  Future<List<FavoriteTable>> getFavoriteList();
}

class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  final DatabaseHelper databaseHelper;

  FavoriteLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<FavoriteTable?> getFavoriteById(String id) async {
    final result = await databaseHelper.getFavoriteById(id);
    if (result != null) {
      return FavoriteTable.fromMap(result);
    }
    return null;
  }

  @override
  Future<List<FavoriteTable>> getFavoriteList() async {
    final result = await databaseHelper.getFavorite();
    return result.map((data) => FavoriteTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertFavorite(FavoriteTable favorite) async {
    try {
      await databaseHelper.insertFavorite(favorite);
      return 'Added to Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      return 'Removed from Favorite';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
