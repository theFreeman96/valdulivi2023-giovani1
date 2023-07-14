import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '/utilities/constants.dart';
import '/components/theme_switch.dart';

import '/assets/data/models.dart';
import '/assets/data/queries.dart';

class SongsDetail extends StatefulWidget {
  const SongsDetail({
    Key? key,
    required this.index,
    required this.from,
    this.id,
  }) : super(key: key);

  final int index;
  final String from;
  final int? id;

  @override
  State<SongsDetail> createState() => _SongsDetailState();
}

class _SongsDetailState extends State<SongsDetail> {
  late PageController pageController;
  final QueryCtr query = QueryCtr();

  late double fontSize = 18.0;
  final double fontSizeMin = 16.0;
  final double fontSizeMax = 20.0;

  late double lineHeight = 1.5;
  final double lineHeightMin = 1.0;
  final double lineHeightMax = 2.0;

  @override
  initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        if (widget.from == 'Songs' || widget.from == 'Drawer') {
          pageController.jumpToPage(widget.index - 1);
        } else {
          pageController.jumpToPage(widget.index);
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Orientation orientation = mediaQuery.orientation;
    return Stack(
      children: [
        FutureBuilder<List?>(
          future: query.getAllSongs(),
          initialData: const [],
          builder: (context, snapshot) {
            return PageView.builder(
              controller: pageController,
              itemBuilder: (context, i) {
                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty ||
                    snapshot.hasError) {
                  return Scaffold(
                    extendBody: true,
                    appBar: AppBar(
                      elevation: 0.0,
                      leading: IconButton(
                        tooltip: 'Indietro',
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                        },
                      ),
                      actions: const [
                        ThemeSwitch(),
                      ],
                    ),
                    body: const Center(child: CircularProgressIndicator()),
                  );
                }
                return buildPage(snapshot.data![i % snapshot.data!.length]);
              },
            );
          },
        ),
        Visibility(
          visible: orientation == Orientation.portrait ? false : true,
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (pageController.hasClients) {
                          pageController.animateToPage(
                            pageController.page!.toInt() - 1,
                            duration: const Duration(milliseconds: 10),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (pageController.hasClients) {
                          pageController.animateToPage(
                            pageController.page!.toInt() + 1,
                            duration: const Duration(milliseconds: 10),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPage(Songs get) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          tooltip: 'Indietro',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
        ),
        actions: const [
          ThemeSwitch(),
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        controller: pageController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: CircleAvatar(
                  child: Text(
                    get.id.toString(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  get.title,
                  style: const TextStyle(fontSize: 22.0),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: kDefaultPadding * 2,
                  bottom: kDefaultPadding * 7,
                ),
                child: Html(
                  data: get.text,
                  style: {
                    'ol': Style(
                      textAlign: TextAlign.center,
                      fontSize: FontSize(fontSize),
                      lineHeight: LineHeight(lineHeight),
                      listStylePosition: ListStylePosition.inside,
                    ),
                  },
                ),
              ),
              const SizedBox(height: kDefaultPadding * 3)
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'Impostazioni',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.format_size),
                              title: const Text('Carattere'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.text_decrease),
                                    tooltip: 'Testo più Piccolo',
                                    onPressed: () {
                                      if (fontSize > fontSizeMin) {
                                        fontSize = fontSize - 2.0;
                                      } else {
                                        log('Dimensione minima del testo: $fontSize');
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.replay),
                                    tooltip: 'Ripristina dimensione testo',
                                    onPressed: () {
                                      fontSize = 18.0;
                                      log('Dimensione default del testo: $fontSize');
                                      setState(
                                        () {},
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.text_increase),
                                    tooltip: 'Testo più Grande',
                                    onPressed: () {
                                      if (fontSize < fontSizeMax) {
                                        fontSize = fontSize + 2.0;
                                      } else {
                                        log('Dimensione massima del testo: $fontSize');
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.format_line_spacing),
                              title: const Text('Interlinea'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.density_small,
                                    ),
                                    tooltip: 'Diminuisci Interlinea',
                                    onPressed: () {
                                      if (lineHeight > lineHeightMin) {
                                        lineHeight = lineHeight - 0.5;
                                      } else {
                                        log('Interlinea minima: $lineHeight');
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.replay),
                                    tooltip: 'Ripristina dimensione testo',
                                    onPressed: () {
                                      lineHeight = 1.5;
                                      log('Interlinea di default: $lineHeight');
                                      setState(
                                        () {},
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.density_medium,
                                    ),
                                    tooltip: 'Aumenta Interlinea',
                                    onPressed: () {
                                      if (lineHeight < lineHeightMax) {
                                        lineHeight = lineHeight + 0.5;
                                      } else {
                                        log('Interlinea massima: $lineHeight');
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              title: const Center(
                                child: Text('Chiudi'),
                              ),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
