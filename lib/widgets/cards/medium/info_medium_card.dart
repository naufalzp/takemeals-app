import 'package:flutter/material.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/widgets/rating.dart';

class InfoMediumCard extends StatelessWidget {
  const InfoMediumCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
    required this.expiredHour,
    required this.press,
  });

  final String image, name, location;
  final double rating;
  final int expiredHour;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.25,
                child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/dummy_food.jpg', fit: BoxFit.cover);
                  },
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: defaultPadding / 4),
            Text(
              location,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: defaultPadding / 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Rating(rating: rating),
                Text(
                  "Expired in: $expiredHour hour",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: titleColor.withOpacity(0.74)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
