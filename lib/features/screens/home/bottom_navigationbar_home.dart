import 'package:flutter/material.dart';
import 'package:fooddelivery/utils/constants/colors.dart';
import 'package:fooddelivery/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigationBarHome extends StatelessWidget {
  const BottomNavigationBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = WHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: 0,
        backgroundColor: darkMode ? WColors.black : Colors.white,
        indicatorColor:
            darkMode
                ? WColors.white.withAlpha((0.1).round())
                : WColors.black.withAlpha((0.1).round()),
        destinations: [
          const NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          const NavigationDestination(
            icon: Icon(Iconsax.heart),
            label: 'Wishlist',
          ),
          const NavigationDestination(
            icon: Icon(Iconsax.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
