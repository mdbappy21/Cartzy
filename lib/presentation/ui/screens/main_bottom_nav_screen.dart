import 'package:cartzy/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:cartzy/presentation/ui/screens/cart_screen.dart';
import 'package:cartzy/presentation/ui/screens/category_list_screen.dart';
import 'package:cartzy/presentation/ui/screens/home_screen.dart';
import 'package:cartzy/presentation/ui/screens/wish_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  final BottomNavBarController _bottomNavBarController= Get.find<BottomNavBarController>();

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
      builder: (_) {
        return Scaffold(
          body: _screens[_bottomNavBarController.selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _bottomNavBarController.selectedIndex,
            onDestinationSelected: _bottomNavBarController.changeIndex,
            destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.category), label: 'Category'),
            NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          ],),
        );
      }
    );
  }
}
