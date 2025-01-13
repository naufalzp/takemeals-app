import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/providers/product_provider.dart';
import 'package:takemeals/screens/details/details_screen.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/widgets/skeleton/big_card_skeleton.dart';
import 'package:takemeals/widgets/cards/big/restaurant_info_big_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final List<Product> filteredProducts = productProvider.products
        .where((product) =>
            product.name!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search on takemeals...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Expanded(
                child: filteredProducts.isEmpty
                    ? Center(
                        child: Text(
                          _searchQuery.isEmpty
                              ? 'No products available.'
                              : 'No products match your search.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _isLoading ? 5 : filteredProducts.length,
                        itemBuilder: (context, index) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: defaultPadding),
                          child: _isLoading
                              ? const BigCardSkeleton()
                              : RestaurantInfoBigCard(
                                  // Images are List<String>
                                  image: filteredProducts[index].image!,
                                  name: filteredProducts[index].name!,
                                  rating: 4.3,
                                  location:
                                      filteredProducts[index].partner!.address!,
                                  expiredHour:
                                      filteredProducts[index].expired ?? 25,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          product: filteredProducts[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchQuery = '';
  }
}
