import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/restaurant_search_provider.dart';
import 'package:resto_app/ui/widget/card_item.dart';
import 'package:resto_app/utils/result_state.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search_resto';
  const RestaurantSearchPage({super.key});

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            onSubmitted: (value) {
              if (value.isEmpty) {
                value = ' ';
                Provider.of<RestaurantSearchProvider>(context, listen: false)
                    .fetchSearchRestaurant(value);
              } else {
                Provider.of<RestaurantSearchProvider>(context, listen: false)
                    .fetchSearchRestaurant(value);
              }
            },
            decoration: const InputDecoration(
              hintText: 'Search Restaurant',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(height: 8),
          Consumer<RestaurantSearchProvider>(
              builder: (context, provider, child) {
            if (provider.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (provider.state == ResultState.hasData) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final data = provider.listResto[index];
                    return CardItem(restaurant: data);
                  },
                  itemCount: provider.listResto.length,
                ),
              );
            } else if (provider.state == ResultState.error) {
              return const Center(
                child: Text('Please Check Your Connection and Try Again later'),
              );
            } else if (provider.message == 'Empty_Data') {
              return const Center(
                child: Text('We Cannot Find Your Search, Try Something else'),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}
