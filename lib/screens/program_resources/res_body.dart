import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/components/study_card.dart';
import '/utilities/constants.dart';

class ResBody extends StatefulWidget {
  const ResBody({Key? key}) : super(key: key);

  @override
  State<ResBody> createState() => _ResBodyState();
}

class _ResBodyState extends State<ResBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: const [
          StudyCard(
            icon: Icon(Icons.person),
            title: 'Relazione con noi stessi',
            pdfPath: 'lib/assets/docs/Relazione con noi stessi.pdf',
          ),
          StudyCard(
            icon: Icon(Icons.people),
            title: 'Rapporti con il prossimo',
            pdfPath: 'lib/assets/docs/Rapporti con il prossimo.pdf',
          ),
          StudyCard(
            icon: Icon(Icons.family_restroom),
            title: 'Relazione con la famiglia',
            pdfPath: 'lib/assets/docs/Relazione con la famiglia.pdf',
          ),
          StudyCard(
            icon: Icon(Icons.favorite),
            title: 'Relazione nella coppia cristiana',
            pdfPath: 'lib/assets/docs/Relazione nella coppia cristiana.pdf',
          ),
          StudyCard(
            icon: Icon(Icons.church),
            title: 'Relazioni con la Chiesa locale',
            pdfPath: 'lib/assets/docs/Relazioni con la Chiesa locale.pdf',
          ),
          StudyCard(
            icon: FaIcon(FontAwesomeIcons.cross),
            title: 'Relazione con Dio',
            pdfPath: 'lib/assets/docs/Relazione con Dio.pdf',
          ),
        ],
      ),
    );
  }
}
