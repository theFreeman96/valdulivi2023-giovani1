import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../program_resources/prog_body.dart';
import '../program_resources/res_body.dart';
import '/utilities/constants.dart';
import '/utilities/theme_provider.dart';
import '/components/page_header.dart';

import '/screens/songs/songs_body.dart';

class HomePages extends StatelessWidget {
  const HomePages({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  final int currentIndex;

  final List<Widget> pageBodies = const [
    ProgBody(),
    ResBody(),
    SongsBody(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    Orientation orientation = mediaQuery.orientation;
    return orientation == Orientation.portrait
        ? NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: mediaQuery.size.height * 0.25,
                  floating: false,
                  pinned: false,
                  toolbarHeight: 0.0,
                  collapsedHeight: 0.0,
                  automaticallyImplyLeading: false,
                  backgroundColor:
                      themeProvider.isDarkMode ? kGrey : kPrimaryColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: PageHeader(
                      image: themeProvider.isDarkMode
                          ? 'lib/assets/images/header_dark.jpg'
                          : 'lib/assets/images/header.jpg',
                    ),
                  ),
                ),
              ];
            },
            body: pageBodies[currentIndex],
          )
        : Row(
            children: <Widget>[
              SizedBox(
                width: mediaQuery.size.width * 0.35,
                height: mediaQuery.size.height,
                child: const PageHeader(
                  image: 'lib/assets/images/header.jpg',
                ),
              ),
              Expanded(
                child: pageBodies[currentIndex],
              ),
            ],
          );
  }
}
