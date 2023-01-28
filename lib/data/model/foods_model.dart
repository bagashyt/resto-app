import 'package:equatable/equatable.dart';

class Foods extends Equatable {
  String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json['name'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    return data;
  }

  @override
  List<Object?> get props => [name];
}
