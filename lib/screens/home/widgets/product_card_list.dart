import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/providers/product_provider.dart';
import 'package:takemeals/screens/details/details_screen.dart';
import 'package:takemeals/widgets/cards/medium/info_medium_card.dart';
import 'package:takemeals/widgets/skeleton/medium_card_skeleton.dart';
import 'package:takemeals/utils/constants.dart';

class ProductCardList extends StatelessWidget {
  const ProductCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        final List<Product> products = productProvider.products;

        return SizedBox(
          width: double.infinity,
          height: 254,
          child: products.isEmpty
              ? buildProductLoadingIndicator()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: (products.length - 1) == index ? defaultPadding : 0,
                    ),
                    child: InfoMediumCard(
                      image: products[index].image!,
                      name: products[index].name!,
                      location: products[index].partner!.address!,
                      expiredHour: products[index].expired ?? 25,
                      rating: 4.6,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: products[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        );
      },
    );
  }

  SingleChildScrollView buildProductLoadingIndicator() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          2,
          (index) => const Padding(
            padding: EdgeInsets.only(left: defaultPadding),
            child: MediumCardSkeleton(),
          ),
        ),
      ),
    );
  }
}
