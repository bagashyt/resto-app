import 'package:equatable/equatable.dart';
import 'package:resto_app/data/model/restaurant_detail_model.dart';

class FavoriteTable extends Equatable {
  final String id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final String? rating;

  const FavoriteTable({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory FavoriteTable.fromEntity(RestaurantDetail resto) => FavoriteTable(
        id: resto.id,
        name: resto.name,
        description: resto.description,
        pictureId: resto.pictureId,
        city: resto.city,
        rating: resto.rating.toString(),
      );

  factory FavoriteTable.fromMap(Map<String, dynamic> map) => FavoriteTable(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        pictureId: map["pictureId"],
        city: map['city'],
        rating: map['rating'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
      ];
}
