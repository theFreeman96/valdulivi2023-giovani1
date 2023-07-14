import 'package:flutter/material.dart';

import '/utilities/constants.dart';
import '/components/search_bar.dart';
import '/components/main_list.dart';

import '/assets/data/models.dart';
import '/assets/data/queries.dart';

import 'songs_detail.dart';

class SongsBody extends StatefulWidget {
  const SongsBody({Key? key}) : super(key: key);

  @override
  State<SongsBody> createState() => _SongsBodyState();
}

class _SongsBodyState extends State<SongsBody> {
  final FocusNode myFocusNode = FocusNode();
  final QueryCtr query = QueryCtr();

  late Future<List?> future;
  @override
  void initState() {
    future = query.getAllSongs();
    super.initState();
  }

  void runFilter(String keyword) {
    Future<List?> results;
    if (keyword.isEmpty) {
      results = future;

      setState(() {
        future = query.getAllSongs();
      });
    } else {
      results = query.searchSong(keyword);

      setState(() {
        future = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          focusNode: myFocusNode,
          filter: runFilter,
          label: 'Cerca per numero, titolo o testo',
          hint: 'Cerca un cantico',
        ),
        const Divider(height: 0.0),
        MainList(
          future: future,
          padding: const EdgeInsets.all(kDefaultPadding),
          row: buildRow,
          message: 'Nessun cantico trovato',
        ),
      ],
    );
  }

  Widget buildRow(Songs get, int i) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          get.id.toString(),
        ),
      ),
      title: Text(get.title),
      trailing: const Icon(
        Icons.navigate_next,
        color: kLightGrey,
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SongsDetail(
                index: get.id,
                from: 'Songs',
              );
            },
          ),
        );
      },
    );
  }
}
