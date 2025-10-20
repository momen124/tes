// lib/widgets/unified_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siwa/app/theme.dart';
import 'package:easy_localization/easy_localization.dart';

enum NavBarType { tourist, business, admin }

class TouristBottomNav extends StatelessWidget {
  final int currentIndex;
  final NavBarType type;

  const TouristBottomNav({
    super.key,
    required this.currentIndex,
    this.type = NavBarType.tourist,
  });

  List<BottomNavigationBarItem> get _items {
    switch (type) {
      case NavBarType.tourist:
        return  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: 'Home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_outlined),
            activeIcon: const Icon(Icons.search),
            label: 'Search'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today_outlined),
            activeIcon: const Icon(Icons.calendar_today),
            label: 'Challenges'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.emoji_events_outlined),
            activeIcon: const Icon(Icons.emoji_events),
            label: 'Bookings'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: 'Profile'.tr(),
          ),
        ];
      case NavBarType.business:
        return  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: 'Dashboard'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt_outlined),
            activeIcon: const Icon(Icons.list_alt),
            label: 'Listings'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today_outlined),
            activeIcon: const Icon(Icons.calendar_today),
            label: 'Bookings'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: 'Profile'.tr(),
          ),
        ];
      case NavBarType.admin:
        return  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: 'Dashboard'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_outline),
            activeIcon: const Icon(Icons.people),
            label: 'Users'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.verified_user_outlined),
            activeIcon: const Icon(Icons.verified_user),
            label: 'Moderation'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined),
            activeIcon: const Icon(Icons.history),
            label: 'Logs'.tr(),
          ),
        ];
    }
  }

  void _onTap(BuildContext context, int index) {
    switch (type) {
      case NavBarType.tourist:
        switch (index) {
          case 0:
            context.go('/tourist_home');
            break;
          case 1:
            context.go('/tourist_search');
            break;
          case 2:
            context.go('/tourist_challenges');
            break;
          case 3:
            context.go('/tourist_bookings');
            break;
          case 4:
            context.go('/tourist_profile');
            break;
        }
        break;
      case NavBarType.business:
        switch (index) {
          case 0:
            context.go('/business_dashboard');
            break;
          case 1:
            context.go('/business_listings');
            break;
          case 2:
            context.go('/tourist_bookings'); // Business bookings view
            break;
          case 3:
            context.go('/business_profile');
            break;
        }
        break;
      case NavBarType.admin:
        switch (index) {
          case 0:
            context.go('/admin_dashboard');
            break;
          case 1:
            context.go('/admin_dashboard'); // Users view
            break;
          case 2:
            context.go('/admin_moderation');
            break;
          case 3:
            context.go('/admin_logs');
            break;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _onTap(context, index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppTheme.primaryOrange,
          unselectedItemColor: AppTheme.gray,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          items: _items,
        ),
      ),
    );
  }
}

// Wrapper widget for consistent app bar styling
class UnifiedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final PreferredSizeWidget? bottom;

  const UnifiedAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppTheme.white,
      foregroundColor: AppTheme.darkGray,
      leading: leading ??
          (showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onBackPressed ?? () => context.pop(),
                )
              : null),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}