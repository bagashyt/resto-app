import 'package:equatable/equatable.dart';

class Drinks extends Equatable {
  String name;

  Drinks({required this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(name: json['name']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    return data;
  }

  @override
  List<Object?> get props => [name];
}
