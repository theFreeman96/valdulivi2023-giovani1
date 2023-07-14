import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:valdulivi2023_giovani1/components/study_card.dart';

import '../../notifications/notification_service.dart';
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
            icon: Icons.person,
            title: 'Relazione con noi stessi',
            pdfPath: 'lib/assets/docs/Relazione con noi stessi.pdf',
          ),
          StudyCard(
            icon: Icons.people,
            title: 'Rapporti con il prossimo',
            pdfPath: 'lib/assets/docs/Rapporti con il prossimo.pdf',
          ),
          StudyCard(
            icon: Icons.church,
            title: 'Relazioni con la Chiesa locale',
            pdfPath: 'lib/assets/docs/Relazioni con la Chiesa locale.pdf',
          ),
        ],
      ),
    );
  }
}
