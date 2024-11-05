import 'package:flutter/material.dart';
import 'package:takemeals/screens/details/details_screen.dart';
import 'package:takemeals/screens/home/widgets/product_card_list.dart';
import 'package:takemeals/screens/home/widgets/promotion_banner.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/widgets/section_title.dart';
import 'package:takemeals/widgets/cards/big/restaurant_info_big_card.dart';
import 'package:takemeals/widgets/cards/big/big_card_image_slide.dart';
import 'package:takemeals/demo_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.pin_drop_rounded),
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(primaryColor),
          ),
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery to".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: primaryColor),
            ),
            const Text(
              "Gunungpati, Semarang",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: BigCardImageSlide(images: demoBigImages),
              ),
              
              const SizedBox(height: defaultPadding),
              SectionTitle(title: "Recommendation", press: () {}),
              const ProductCardList(),
              const SizedBox(height: 20),
              // Banner
              const PromotionBanner(),
              const SizedBox(height: 16),
              SectionTitle(title: "Nearest", press: () {}),
              const ProductCardList(),
              const SizedBox(height: 20),
              SectionTitle(title: "All Partners", press: () {}),
              const SizedBox(height: 16),

              // Demo list of Big Cards
              // ...List.generate(
              //   // For demo we use 4 items
              //   3,
              //   (index) => Padding(
              //     padding: const EdgeInsets.fromLTRB(
              //         defaultPadding, 0, defaultPadding, defaultPadding),
              //     child: RestaurantInfoBigCard(
              //       // Images are List<String>
              //       images: demoBigImages..shuffle(),
              //       name: "McDonald's",
              //       rating: 4.3,
              //       numOfRating: 200,
              //       deliveryTime: 25,
              //       foodType: const ["Chinese", "American", "Deshi food"],
              //       press: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const DetailsScreen(),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
