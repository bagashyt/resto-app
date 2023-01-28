import 'package:equatable/equatable.dart';
import 'package:resto_app/data/model/categories_model.dart';
import 'package:resto_app/data/model/customer_reviews_model.dart';
import 'package:resto_app/data/model/menus_model.dart';

class RestaurantDetail extends Equatable {
  String id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Categories>? categories;
  Menus menus;
  num? rating;
  List<CustomerReviews>? customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: json["categories"] == null
            ? null
            : (json["categories"] as List)
                .map((e) => Categories.fromJson(e))
                .toList(),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"],
        customerReviews: json["customerReviews"] == null
            ? null
            : (json["customerReviews"] as List)
                .map((e) => CustomerReviews.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["city"] = city;
    data["address"] = address;
    data["pictureId"] = pictureId;
    if (categories != null) {
      data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    data["menus"] = menus.toJson();
    data["rating"] = rating;
    if (customerReviews != null) {
      data["customerReviews"] =
          customerReviews?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        city,
        address,
        pictureId,
        categories,
        menus,
        rating,
        customerReviews,
      ];
}
