import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../utilities/constants.dart';

import '../screens/program_resources/pdf_viewer_page.dart';

class StudyCard extends StatelessWidget {
  const StudyCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.pdfPath,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String pdfPath;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(kDefaultPadding),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            icon,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () async {
          var path = pdfPath;
          var file = await PDFApi.loadAsset(path);
          openPDF(context, file);
        },
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

class PDFApi {
  static Future<File> loadAsset(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();

    return _storeFile(path, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
