import 'package:flutter/material.dart';
// import '../pages/home_page.dart';
// import '../pages/cart_page.dart';
// import '../pages/profile_page.dart';
import '../cart/view/cart_page.dart';
import '../chat/view/chat_page.dart';
import '../home/view/home_page.dart';
import '../profile/view/profile_page.dart';
import '../widgets/bottom_navigation.dart';
// import '../widgets/custom_bottom_navigation.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePageView(), // Use a view that accesses existing BlocProvider
      const CartPage(),
      const ChatPageWrapper(),
      const ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}