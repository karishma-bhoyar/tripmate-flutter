import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        if (value == currentIndex) return;
        switch (value) {
          case 0:
            context.router.replace(const HomeRoute());
            break;
          case 1:
            context.router.replace(const ExploreRoute());
            break;
          case 2:
            context.router.replace(const MyBookingRoute());
            break;
          case 3:
            context.router.replace(FavoriteRoute());
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.whiteColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.greyColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long_rounded),
          label: 'My Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded),
          activeIcon: Icon(Icons.favorite_rounded),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
