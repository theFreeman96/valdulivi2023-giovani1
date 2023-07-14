import 'package:flutter/material.dart';

import '../../components/theme_switch.dart';

import 'home_pages.dart';
import 'home_bottom.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: false,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(''),
        actions: const [
          ThemeSwitch(),
        ],
      ),
      body: HomePages(
        currentIndex: currentIndex,
      ),
      bottomNavigationBar: HomeBottomBar(
        currentIndex: currentIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
