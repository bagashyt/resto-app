import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/restaurant_favorite_provider.dart';
import 'package:resto_app/ui/widget/card_item.dart';
import 'package:resto_app/utils/result_state.dart';

class RestaurantFavoritePage extends StatefulWidget {
  static const ROUTE_NAME = '/favorite_resto';
  const RestaurantFavoritePage({super.key});

  @override
  State<RestaurantFavoritePage> createState() => _RestaurantFavoritePageState();
}

class _RestaurantFavoritePageState extends State<RestaurantFavoritePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RestaurantFavoriteProvider>(context, listen: false)
          .fetchFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Restaurant'),
      ),
      body: Consumer<RestaurantFavoriteProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final data = provider.listResto[index];
                return CardItem(
                  restaurant: null,
                  favorite: data,
                );
              },
              itemCount: provider.listResto.length,
            );
          } else {
            return Center(
              child: Text(provider.message),
            );
          }
        },
      ),
    );
  }
}
