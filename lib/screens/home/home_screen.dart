import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takemeals/providers/user_provider.dart';
import 'package:takemeals/screens/home/widgets/product_card_list.dart';
import 'package:takemeals/screens/home/widgets/promotion_banner.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/widgets/section_title.dart';
import 'package:takemeals/widgets/cards/big/big_card_image_slide.dart';
import 'package:takemeals/demo_data.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greeting = '';

  // Get current time and set greeting message
  void getGreeting() {
    final DateTime now = DateTime.now();
    final int hour = now.hour;
    if (hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (hour < 17) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getGreeting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: primaryColor),
            ),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.isFetching) {
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 2.0,
                    ),
                  );
                }
                return Text(
                  userProvider.user != null
                      ? userProvider.user!.name ?? '-'
                      : '-',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
