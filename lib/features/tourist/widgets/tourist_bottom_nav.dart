import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';

class TouristBottomNav extends StatelessWidget {
  final int currentIndex;
  
  const TouristBottomNav({super.key, required this.currentIndex});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: AppTheme.primaryOrange,
          unselectedItemColor: AppTheme.gray,
          backgroundColor: AppTheme.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined),
              activeIcon: Icon(Icons.camera_alt),
              label: 'Challenges',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                if (currentIndex != 0) context.go('/tourist_home');
                break;
              case 1:
                if (currentIndex != 1) context.go('/tourist_search');
                break;
              case 2:
                if (currentIndex != 2) context.go('/tourist_challenges');
                break;
              case 3:
                if (currentIndex != 3) context.go('/tourist_bookings');
                break;
              case 4:
                if (currentIndex != 4) context.go('/tourist_profile');
                break;
            }
          },
        ),
      ),
    );
  }
}