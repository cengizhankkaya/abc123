import 'package:abc123/features/home/presentation/screens/badges_screen.dart';
import 'package:abc123/features/home/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:abc123/features/home/presentation/widgets/home_tab.dart';
import 'package:abc123/features/home/presentation/screens/daily_quest_screen.dart';
import 'package:abc123/features/home/presentation/screens/avatar_shop_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    const DailyQuestScreen(),
    const AvatarShopScreen(),
    BadgesScreen(isTab: true),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Allows content to go behind bottom bar
      body: Stack(
        children: [
          // Main Content
          IndexedStack(
            index: _currentIndex,
            children: _tabs,
          ),

          // Floating Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabSelected,
            ),
          ),
        ],
      ),
    );
  }
}
