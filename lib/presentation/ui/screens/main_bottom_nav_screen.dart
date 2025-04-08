import 'package:cartzy/presentation/ui/screens/category_list_screen.dart';
import 'package:cartzy/presentation/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CategoryListScreen(),
    CategoryListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.category), label: 'Category'),
        NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
      ],),
    );
  }
}
