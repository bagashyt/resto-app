import 'package:flutter_test/flutter_test.dart';
import 'package:resto_app/data/model/categories_model.dart';
import 'package:resto_app/data/model/customer_reviews_model.dart';
import 'package:resto_app/data/model/drinks_model.dart';
import 'package:resto_app/data/model/foods_model.dart';
import 'package:resto_app/data/model/menus_model.dart';
import 'package:resto_app/data/model/restaurant_detail_model.dart';

void main(){

  final tDetailModel = RestaurantDetail(
    id: 'id',
    name: 'name',
    description: 'description',
    city: 'city',
    address: 'address',
    pictureId: 'pictureId',
    categories: [Categories(name: 'name')],
    menus: Menus(foods: [Foods(name: 'name')], drinks: [Drinks(name: 'name')],),
    rating: 1,
    customerReviews: [CustomerReviews( name: 'name', review: 'review', date: 'date')],
  );

  final Map<String, dynamic>tJson = {
    'id': 'id',
    'name': 'name',
    'description': 'description',
    'city': 'city',
    'address': 'address',
    'pictureId': 'pictureId',
    'categories': [{'name': 'name'}],
    'menus': {'foods': [{'name': 'name'}], 'drinks': [{'name': 'name'}]},
    'rating': 1,
    'customerReviews': [{'name': 'name', 'review': 'review', 'date': 'date'}]
  };

  test('should be able to parsing from Json', () async {
    final result = RestaurantDetail.fromJson(tJson);
    expect(result, tDetailModel);
  });
  test('should be able to parsing to Json', () async {
    final result = tDetailModel.toJson();
    expect(result, tJson);
  });

}