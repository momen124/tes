import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';

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
          items:  [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: 'Home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search_outlined),
              activeIcon: const Icon(Icons.search),
              label: 'Discover'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.camera_alt_outlined),
              activeIcon: const Icon(Icons.camera_alt),
              label: 'Challenges'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bookmark_outline),
              activeIcon: const Icon(Icons.bookmark),
              label: 'Bookings'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: 'Profile'.tr(),
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