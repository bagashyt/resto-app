import 'package:equatable/equatable.dart';
import 'package:resto_app/data/model/restaurant_model.dart';

class SearchRestaurantResponse extends Equatable {
  bool? error;
  int? founded;
  List<Restaurant> restaurants;

  SearchRestaurantResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: (json["restaurants"] as List)
            .map((e) => Restaurant.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["error"] = error;
    data["founded"] = founded;
    data["restaurants"] = restaurants.map((e) => e.toJson()).toList();
    return data;
  }

  @override
  List<Object?> get props => [
        error,
        founded,
        restaurants,
      ];
}
