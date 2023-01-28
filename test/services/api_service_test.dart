import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:resto_app/data/api/api_service.dart';
import 'package:resto_app/data/model/restaurant_detail_response.dart';
import 'package:resto_app/data/model/restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:resto_app/data/model/search_restaurant_response.dart';
import 'package:resto_app/utils/exception.dart';
import 'package:mockito/annotations.dart';

import '../json_reader.dart';
import 'api_service_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {
  late MockHttpClient mockHttpClient;
  late ApiService apiService;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiService = ApiService(client: mockHttpClient);
  });

  group('get Restaurant', () {
    final tRestaurant = RestaurantResponse.fromJson(
        json.decode(readJson('dummy_data/restaurant_response.json')));

    test('should return data Restaurant when response 200', () async {
      when(mockHttpClient
              .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/restaurant_response.json'),
                200,
              ));

      final result = await apiService.getListRestaurant();

      expect(result, equals(tRestaurant));
    });

    test('should throw ServerException when response code 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = apiService.getListRestaurant();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Detail Restaurant', () {
    const id = 'rqdv5juczeskfw1e867';
    final tRestaurant = RestaurantDetailResponse.fromJson(
        json.decode(readJson('dummy_data/restaurant_detail_response.json')));

    test('should return data Restaurant when response 200', () async {
      when(mockHttpClient
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/restaurant_detail_response.json'),
                200,
              ));

      final result = await apiService.getDetailRestaurant(id);

      expect(result, equals(tRestaurant));
    });

    test('should throw ServerException when response code 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = apiService.getDetailRestaurant(id);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Restaurant', () {
    const query = 'melting';
    final tRestaurant = SearchRestaurantResponse.fromJson(
        json.decode(readJson('dummy_data/restaurant_search_response.json')));

    test('should return data Restaurant when response 200', () async {
      when(mockHttpClient.get(
              Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query')))
          .thenAnswer((_) async => http.Response(
                readJson('dummy_data/restaurant_search_response.json'),
                200,
              ));

      final result = await apiService.searchRestaurant(query);

      expect(result, equals(tRestaurant));
    });

    test('should throw ServerException when response code 404 or other',
        () async {
      when(mockHttpClient.get(
              Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = apiService.searchRestaurant(query);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
