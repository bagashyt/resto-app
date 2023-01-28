import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resto_app/data/model/favorite_table.dart';
import 'package:resto_app/data/model/restaurant_model.dart';
import 'package:resto_app/ui/restaurant_detail_page.dart';

class CardItem extends StatelessWidget {
  final Restaurant? restaurant;
  final FavoriteTable? favorite;
  const CardItem({Key? key, required this.restaurant, this.favorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium';
    String? picture =
        restaurant != null ? restaurant!.pictureId : favorite!.pictureId;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailPage.ROUTE_NAME,
          arguments: restaurant != null ? restaurant!.id : favorite!.id,
        );
      },
      child: Card(
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: '$imageUrl/$picture',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_city,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      restaurant != null
                          ? restaurant!.name
                          : favorite!.name ?? '-',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(restaurant != null
                        ? restaurant!.city
                        : favorite!.city ?? '-')
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.yellow,
                    ),
                    const SizedBox(width: 6),
                    Text(restaurant != null
                        ? restaurant!.rating.toString()
                        : favorite!.rating.toString())
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
