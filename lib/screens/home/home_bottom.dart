import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/utilities/constants.dart';
import '/utilities/theme_provider.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  final int currentIndex;
  final Function(int) onTabTapped;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BottomNavigationBar(
      elevation: 0.0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      type: BottomNavigationBarType.shifting,
      backgroundColor: themeProvider.isDarkMode ? kGrey : kPrimaryColor,
      currentIndex: currentIndex,
      onTap: onTabTapped,
      selectedItemColor: kWhite,
      unselectedItemColor: kWhite.withOpacity(0.6),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.watch_later),
          label: 'Programma',
          backgroundColor: themeProvider.isDarkMode ? kGrey : kPrimaryColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu_book),
          label: 'Studi',
          backgroundColor: themeProvider.isDarkMode ? kGrey : kPrimaryColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.library_music),
          label: 'Cantici',
          backgroundColor: themeProvider.isDarkMode ? kGrey : kPrimaryColor,
        )
      ],
    );
  }
}
