import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resto_app/data/model/restaurant_detail_response.dart';
import 'package:resto_app/data/model/restaurant_response.dart';
import 'package:resto_app/data/model/search_restaurant_response.dart';
import 'package:resto_app/utils/exception.dart';

class ApiService {
  final http.Client client;
  static const String baseUrl = "https://restaurant-api.dicoding.dev";

  ApiService({required this.client});

  Future<RestaurantResponse> getListRestaurant() async {
    final response = await client.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200 && response.body.contains('restaurants')) {
      return RestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<RestaurantDetailResponse> getDetailRestaurant(String id) async {
    final response = await client.get(Uri.parse("$baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse("$baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
