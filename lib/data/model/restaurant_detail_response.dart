import 'package:equatable/equatable.dart';
import 'package:resto_app/data/model/restaurant_detail_model.dart';

class RestaurantDetailResponse extends Equatable {
  bool? error;
  String? message;
  RestaurantDetail restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["error"] = error;
    data["message"] = message;
    data["restaurant"] = restaurant.toJson();
    return data;
  }

  @override
  List<Object?> get props => [
        error,
        message,
        restaurant,
      ];
}
