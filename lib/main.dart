import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takemeals/providers/order_provider.dart';
import 'package:takemeals/providers/product_provider.dart';
import 'package:takemeals/providers/partner_provider.dart';
import 'package:takemeals/providers/user_provider.dart';
import 'package:takemeals/screens/onboarding/onboarding_screen.dart';
import 'package:takemeals/utils/entrypoint.dart';
import 'package:takemeals/utils/shared_preferences_helper.dart';
import 'package:takemeals/utils/constants.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _getAccessToken();
  }

  Future<void> _getAccessToken() async {
    String? token = await SharedPreferencesHelper.getAccessToken();
    setState(() {
      accessToken = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => PartnerProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()), 
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TakeMeals',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: bodyTextColor),
            bodySmall: TextStyle(color: bodyTextColor),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.all(defaultPadding),
            hintStyle: TextStyle(color: bodyTextColor),
          ),
        ),
        home: accessToken == null
            ? const OnboardingScreen()
            : const EntryPoint(),
      ),
    );
  }
}
