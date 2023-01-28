import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/restaurant_detail_provider.dart';
import 'package:resto_app/utils/result_state.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_resto';
  final String id;
  const RestaurantDetailPage({super.key, required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RestaurantDetailProvider>(context, listen: false)
          .fetchDetailRestaurant(widget.id);
      Provider.of<RestaurantDetailProvider>(context, listen: false)
          .statusFavorite(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imageUrl = 'https://restaurant-api.dicoding.dev/images/medium';
    return Scaffold(
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ResultState.hasData) {
            final detail = provider.detail;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: '$imageUrl/${detail.pictureId}',
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SafeArea(child: IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_circle_left_outlined, size: 34, color: Colors.red,))
                      )
                      ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${detail.name}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (provider.isFavorite) {
                                  provider.removeFavorite(detail.id);
                                } else {
                                  provider.addFavorite(detail);
                                }
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: provider.isFavorite == true
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${detail.rating}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${detail.city}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Divider(),
                        const SizedBox(height: 6),
                        Text('${detail.description}'),
                        const SizedBox(height: 8),
                        const Divider(),
                        const Text(
                          'Menu',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        detail.menus.foods != null &&
                                detail.menus.foods!.isNotEmpty
                            ? _menuItems(
                                title: 'Foods',
                                iconPath: Icons.dinner_dining,
                                items: detail.menus.foods!
                                        .map((e) => e.name)
                                        .toList(),
                              )
                            : Container(),
                        const SizedBox(height: 14),
                        detail.menus.foods != null &&
                                detail.menus.foods!.isNotEmpty
                            ? _menuItems(
                                title: 'Drinks',
                                iconPath: Icons.local_drink,
                                items: detail.menus.drinks!
                                        .map((e) => e.name)
                                        .toList(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (provider.state == ResultState.error)  {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const Text('Check Your Internet Connection and Try Again Later'),
                ElevatedButton(onPressed: (){
                  provider.fetchDetailRestaurant(widget.id);
                }, child: const Text('Try Again'))
              ],),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget _menuItems({
  required String title,
  required IconData iconPath,
  required List<String> items,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          children: [
            Icon(iconPath),
            const SizedBox(
              width: 10,
            ),
            Text(title, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
      const SizedBox(
        height: 6,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items
              .asMap()
              .map(
                (index, value) => MapEntry(
                  index,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Chip(
                      label: Text(value),
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ),
      )
    ],
  );
}
