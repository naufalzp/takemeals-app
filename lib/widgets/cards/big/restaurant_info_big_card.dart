import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/widgets/cards/big/big_card_image_slide.dart';
import 'package:takemeals/widgets/price_range_and_food_type.dart';
import 'package:takemeals/widgets/rating_with_counter.dart';
import 'package:takemeals/widgets/small_dot.dart';

class RestaurantInfoBigCard extends StatelessWidget {
  final List<String> images, foodType;
  final String name;
  final double rating;
  final int numOfRating, deliveryTime;
  final bool isFreeDelivery;
  final VoidCallback press;

  const RestaurantInfoBigCard({
    super.key,
    required this.name,
    required this.rating,
    required this.numOfRating,
    required this.deliveryTime,
    this.isFreeDelivery = true,
    required this.images,
    required this.foodType,
    required this.press,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // pass list of images here
          BigCardImageSlide(images: images),
          const SizedBox(height: defaultPadding / 2),
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: defaultPadding / 4),
          PriceRangeAndFoodtype(foodType: foodType),
          const SizedBox(height: defaultPadding / 4),
          Row(
            children: [
              RatingWithCounter(rating: rating, numOfRating: numOfRating),
              const SizedBox(width: defaultPadding / 2),
              SvgPicture.asset(
                "assets/icons/clock.svg",
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "$deliveryTime Min",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: SmallDot(),
              ),
              SvgPicture.asset(
                "assets/icons/delivery.svg",
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(
                  Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(isFreeDelivery ? "Free" : "Paid",
                  style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
