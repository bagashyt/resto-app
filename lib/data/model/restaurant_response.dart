import 'package:equatable/equatable.dart';
import 'package:resto_app/data/model/restaurant_model.dart';

class RestaurantResponse extends Equatable {
  final List<Restaurant> restaurants;

  RestaurantResponse({
    required this.restaurants,
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResponse(
        restaurants: (json["restaurants"] as List)
            .map((e) => Restaurant.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["restaurants"] = restaurants.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [
    restaurants,
  ];
}
