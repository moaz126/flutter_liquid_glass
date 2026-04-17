import 'package:flutter/material.dart';

// MARK: - FallbackTabBar

final class FallbackTabBar extends StatelessWidget {
  const FallbackTabBar({
    super.key,
    required this.onTabSelected,
    required this.selectedIndex,
  });

  final ValueChanged<int> onTabSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTabSelected,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          activeIcon: Icon(Icons.bar_chart),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
