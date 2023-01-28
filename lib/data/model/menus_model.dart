import 'package:equatable/equatable.dart';
import 'package:resto_app/data/model/drinks_model.dart';
import 'package:resto_app/data/model/foods_model.dart';

class Menus extends Equatable {
  List<Foods>? foods;
  List<Drinks>? drinks;

  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: json['foods'] == null
            ? null
            : (json["foods"] as List).map((e) => Foods.fromJson(e)).toList(),
        drinks: json['drinks'] == null
            ? null
            : (json["drinks"] as List).map((e) => Drinks.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (foods != null) {
      data["foods"] = foods?.map((e) => e.toJson()).toList();
    }
    if (drinks != null) {
      data["drinks"] = drinks?.map((e) => e.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        foods,
        drinks,
      ];
}
