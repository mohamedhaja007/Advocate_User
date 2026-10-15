import 'package:flutter/material.dart';
import '../../../../core/widgets/app_bottom_navigation.dart';
import 'home_screen.dart';
import '../../../lawyers/presentation/pages/lawyers_screen.dart';
import '../../../bookings/presentation/pages/bookings_screen.dart';
import '../../../account/presentation/pages/account_screen.dart';

class MainNavigationShell extends StatefulWidget {
  final int initialIndex;

  const MainNavigationShell({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = const [
    HomeScreen(),
    LawyersScreen(),
    BookingsScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. SCROLLABLE PAGE CONTENT
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          // 2. PURE FLOATING TRANSLUCENT NAVBAR
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 12,
            child: AppBottomNavigation(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
