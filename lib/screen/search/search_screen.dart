import 'package:flutter/material.dart';
import 'package:foodea/provider/search/restaurant_search_provider.dart';
import 'package:foodea/screen/search/item_card_widget.dart';
import 'package:foodea/static/restaurant_search_result_state.dart';
import 'package:foodea/style/colors/restaurant_colors.dart';
import 'package:foodea/style/typography/restaurant_text_style.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<RestaurantSearchProvider>().reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Restautant"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox.square(
              dimension: 10,
            ),
            Hero(
              tag: 'search-restaurant',
              child: Material(
                type: MaterialType.transparency,
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    Provider.of<RestaurantSearchProvider>(
                      context,
                      listen: false,
                    ).fetchRestaurantSearch(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xffA0A5BA),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search restaurants',
                    hintStyle: RestaurantTextStyle.labelMedium.copyWith(
                      color: RestaurantColors.shades.color,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: RestaurantColors.orange.color,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xffA0A5BA),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.square(dimension: 10),
            Expanded(
              child: Consumer<RestaurantSearchProvider>(
                builder: (context, value, child) {
                  debugPrint('STATE ${value.resultState}');
                  return switch (value.resultState) {
                    RestaurantSearchLoadingState() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    RestaurantSearchLoadedState(data: var result) =>
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: result.length,
                        separatorBuilder: (context, index) =>
                            SizedBox.square(dimension: 15),
                        itemBuilder: (context, index) {
                          final restaurant = result[index];
                          return ItemCardWidget(restaurant: restaurant);
                        },
                      ),
                    RestaurantSearchEmptyState(message: var message) => Center(
                        child: Text(message),
                      ),
                    RestaurantSearchErrorState(error: var message) => Center(
                        child: Text(message),
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
