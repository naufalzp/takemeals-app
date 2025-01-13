import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/widgets/cards/big/big_card_image.dart';
import 'package:takemeals/widgets/cards/big/big_card_image_slide.dart';
import 'package:takemeals/widgets/price_range_and_food_type.dart';
import 'package:takemeals/widgets/rating_with_counter.dart';
import 'package:takemeals/widgets/small_dot.dart';

class RestaurantInfoBigCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final double rating;
  final int expiredHour;
  final VoidCallback press;

  const RestaurantInfoBigCard({
    super.key,
    required this.name,
    required this.rating,
    required this.location,
    required this.expiredHour,
    required this.image,
    required this.press,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigCardImage(image: image),         
          const SizedBox(height: defaultPadding / 2),
          Text(name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: defaultPadding / 4),
          // PriceRangeAndFoodtype(foodType: foodType),
          const SizedBox(height: defaultPadding / 4),
          Row(
            children: [
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
                 "Expired in: $expiredHour hour",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
