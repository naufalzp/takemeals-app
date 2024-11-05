import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:takemeals/providers/order_provider.dart';
import 'package:takemeals/providers/product_provider.dart';
import 'package:takemeals/providers/user_provider.dart';
import 'package:takemeals/screens/home/home_screen.dart';
import 'package:takemeals/screens/order/order_screen.dart';
import 'package:takemeals/screens/profile/profile_screen.dart';
import 'package:takemeals/screens/search/search_screen.dart';
import 'package:takemeals/utils/constants.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _navitems = [
    {"icon": "assets/icons/home.svg", "title": "Home"},
    {"icon": "assets/icons/search.svg", "title": "Search"},
    {"icon": "assets/icons/order.svg", "title": "Orders"},
    {"icon": "assets/icons/profile.svg", "title": "Profile"},
  ];

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await orderProvider.fetchOrders();
    await productProvider.fetchProducts();
    if (mounted) {
      await userProvider.fetchUserData(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        activeColor: primaryColor,
        inactiveColor: bodyTextColor,
        items: List.generate(
          _navitems.length,
          (index) => BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _navitems[index]["icon"],
              height: 30,
              width: 30,
              colorFilter: ColorFilter.mode(
                index == _selectedIndex ? primaryColor : bodyTextColor,
                BlendMode.srcIn,
              ),
            ),
            label: _navitems[index]["title"],
          ),
        ),
      ),
    );
  }
}
