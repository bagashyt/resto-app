import 'package:flutter_test/flutter_test.dart';
import 'package:resto_app/data/model/categories_model.dart';
import 'package:resto_app/data/model/customer_reviews_model.dart';
import 'package:resto_app/data/model/drinks_model.dart';
import 'package:resto_app/data/model/foods_model.dart';
import 'package:resto_app/data/model/menus_model.dart';
import 'package:resto_app/data/model/restaurant_detail_model.dart';
import 'package:resto_app/data/model/restaurant_detail_response.dart';

void main() {

  final Map<String, dynamic> tJson = {
    'error': false,
    'message': 'message',
    'restaurant': {
      'id': 'id',
      'name': 'name',
      'description': 'description',
      'city': 'city',
      'address': 'address',
      'pictureId': 'pictureId',
      'categories': [
        {'name': 'name'}
      ],
      'menus': {
        'foods': [
          {'name': 'name'}
        ],
        'drinks': [
          {'name': 'name'}
        ]
      },
      'rating': 1,
      'customerReviews': [
        {'name': null, 'review': null, 'date': null}
      ]
    }
  };

  final tDetailResponse = RestaurantDetailResponse(
    error: false,
    message: 'message',
    restaurant: RestaurantDetail(
      id: 'id',
      name: 'name',
      description: 'description',
      city: 'city',
      address: 'address',
      pictureId: 'pictureId',
      categories: [Categories(name: 'name')],
      menus: Menus(
        foods: [Foods(name: 'name')],
        drinks: [Drinks(name: 'name')],
      ),
      rating: 1,
      customerReviews: [CustomerReviews()],
    ),
  );

  test('should be able to parsing from Json', () async {
    final result = RestaurantDetailResponse.fromJson(tJson);
    expect(result, tDetailResponse);
  });
  test('should be able to parsing to Json', () async {
    final result = tDetailResponse.toJson();
    expect(result, tJson);
  });
}
