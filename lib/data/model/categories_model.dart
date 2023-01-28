import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    return data;
  }

  @override
  List<Object?> get props => [
    name
  ];
}
