import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/theme_provider.dart';
import '/utilities/constants.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(image),
          alignment: Alignment.center,
        ),
        color: themeProvider.isDarkMode ? kGrey : kPrimaryColor,
      ),
    );
  }
}
