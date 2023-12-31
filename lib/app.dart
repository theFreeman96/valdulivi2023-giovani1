import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '/utilities/globals.dart';
import '/utilities//themes.dart';
import '/utilities/theme_provider.dart';
import '/utilities/scroll_behavior.dart';

import 'screens/home/home.dart';

class Valdulivi2023Giovani1 extends StatelessWidget {
  const Valdulivi2023Giovani1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeProvider, child) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeProvider.isDarkMode ? AppTheme.dark : AppTheme.light,
              title: 'Relazione',
              scaffoldMessengerKey: snackBarKey,
              builder: (context, child) {
                return ScrollConfiguration(
                  behavior: MyScrollBehavior(),
                  child: SizedBox(child: child),
                );
              },
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('it', ''),
                Locale('en', ''),
              ],
              home: const Home(),
            ),
          );
        },
      ),
    );
  }
}
