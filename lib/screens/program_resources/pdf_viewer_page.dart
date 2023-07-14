import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

import '../../components/theme_switch.dart';
import '/utilities/theme_provider.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} di $pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: const [
          ThemeSwitch(),
        ],
      ),
      body: PDFView(
        filePath: widget.file.path,
        nightMode: themeProvider.isDarkMode ? true : false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
      bottomNavigationBar: BottomAppBar(
        child: pages >= 2
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(text),
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 32),
                    onPressed: () {
                      final page = indexPage == 0 ? pages : indexPage - 1;
                      controller.setPage(page);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, size: 32),
                    onPressed: () {
                      final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                      controller.setPage(page);
                    },
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
