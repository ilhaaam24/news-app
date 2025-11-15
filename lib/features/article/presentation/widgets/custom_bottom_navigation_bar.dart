import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: 0,
      unselectedIconTheme: IconThemeData(
        color: Colors.black.withValues(alpha: 0.6),
      ),
      selectedLabelStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      selectedItemColor: Colors.blue,
      onTap: (value) {
        if (value == 0) {
          Navigator.pushNamed(context, '/');
        } else if (value == 1) {
          Navigator.pushNamed(context, '/explore_page');
        } else if (value == 2) {
          Navigator.pushNamed(context, '/bookmark_page');
        } else if (value == 3) {
          Navigator.pushNamed(context, '/profile_page');
        }
      },
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark_outline_outlined),
          label: 'Bookmark',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
